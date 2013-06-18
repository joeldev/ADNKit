/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.

 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ANKClient.h"
#import "ANKJSONRequestOperation.h"
#import "ANKPaginationSettings.h"
#import "ANKGeneralParameters.h"
#import "ANKAPIResponseMeta.h"
#import "ANKAPIResponse.h"
#import "ANKTokenStatus.h"
#import "ANKResourceMap.h"
#import "ANKUser.h"
#import "ANKMessage.h"
#import "ANKFile.h"
#import "ANKPost.h"
#import "ANKClient+ANKTokenStatus.h"
#import <SocketShuttle/KATSocketShuttle.h>
#import "ANKStreamContext.h"


static const NSString *ADNAPIUserStreamEndpointURL = @"wss://stream-channel.app.net/stream/user";


@interface ANKClient () <KATSocketShuttleDelegate>

@property (strong) AFHTTPClient *authHTTPClient;
@property (strong) NSString *webAuthRedirectURI;
@property (readwrite, strong) ANKUser *authenticatedUser;

@property (nonatomic, strong) KATSocketShuttle *socketShuttle;
@property (nonatomic, copy) NSString *streamingConnectionID;
@property (nonatomic, strong) NSMutableSet *socketContexts;

- (void)initializeHTTPAuthClient;
- (void)HTTPAuthDidCompleteSuccessfully:(BOOL)wasSuccessful error:(NSError *)error handler:(void (^)(BOOL successful, NSError *error))handler;
- (void)authenticateWithParameters:(NSDictionary *)params handler:(void (^)(BOOL successful, NSError *error))handler;

@end


@implementation ANKClient

+ (instancetype)sharedClient {
    static ANKClient *sharedANKClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedANKClient = [[ANKClient alloc] init];
    });

    return sharedANKClient;
}


+ (NSURL *)APIBaseURL {
	return [NSURL URLWithString:@"https://alpha-api.app.net/stream/0/"];
}


- (id)init {
    if ((self = [super initWithBaseURL:[[self class] APIBaseURL]])) {
		self.parameterEncoding = AFJSONParameterEncoding;
		self.pagination = [[ANKPaginationSettings alloc] init];
		self.generalParameters = [[ANKGeneralParameters alloc] init];
		self.generalParameters.includeHTML = NO;

		[self setDefaultHeader:@"Accept" value:@"application/json"];
		[self registerHTTPOperationClass:[ANKJSONRequestOperation class]];

		[self addObserver:self forKeyPath:@"accessToken" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"shouldRequestAnnotations" options:NSKeyValueObservingOptionNew context:nil];

        self.socketContexts = [[NSMutableSet alloc] init];
	}

    return self;
}


- (void)dealloc {
	[self removeObserver:self forKeyPath:@"accessToken"];
	[self removeObserver:self forKeyPath:@"shouldRequestAnnotations"];
}


- (id)copyWithZone:(NSZone *)zone {
	ANKClient *copy = [[[self class] alloc] init];

	copy.accessToken = [self.accessToken copyWithZone:zone];
	copy.authenticatedUser = [self.authenticatedUser copyWithZone:zone];
	copy.generalParameters = [self.generalParameters copyWithZone:zone];
	copy.pagination = [self.pagination copyWithZone:zone];
	copy.shouldUseSharedUserDefaultsController = self.shouldUseSharedUserDefaultsController;
	copy.shouldSynchronizeOnUserDefaultsWrite = self.shouldSynchronizeOnUserDefaultsWrite;
	copy.responseDecodingType = self.responseDecodingType;

	return copy;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:@"accessToken"]) {
		[self setDefaultHeader:@"Authorization" value:self.accessToken ? [@"Bearer " stringByAppendingString:self.accessToken] : nil];
	} else if ([keyPath isEqualToString:@"shouldRequestAnnotations"]) {
		self.generalParameters.includeAnnotations = self.shouldRequestAnnotations;
	}
}


- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters {
	NSMutableURLRequest *request = [super requestWithMethod:method path:path parameters:parameters];

	NSMutableDictionary *commonParameters = [NSMutableDictionary dictionary];

	if (self.generalParameters) {
		[commonParameters addEntriesFromDictionary:[self.generalParameters JSONDictionary]];
	}

	if (self.pagination) {
		[commonParameters addEntriesFromDictionary:[self.pagination JSONDictionary]];
	}

	if (commonParameters.count) {
		NSString *encodedParameters = AFQueryStringFromParametersWithEncoding(commonParameters, self.stringEncoding);
		NSString *URLString = [request.URL absoluteString];
		request.URL = [NSURL URLWithString:[URLString stringByAppendingFormat:[URLString rangeOfString:@"?"].location == NSNotFound ? @"?%@" : @"&%@", encodedParameters]];
	}

	return request;
}


#pragma mark -
#pragma mark Authentication

- (void)authenticateUsername:(NSString *)username password:(NSString *)password clientID:(NSString *)clientID passwordGrantSecret:(NSString *)passwordGrantSecret authScopes:(ANKAuthScope)authScopes completionHandler:(void (^)(BOOL success, NSError *error))completionHander {
	// http://developers.app.net/docs/authentication/flows/password/

	NSDictionary *parameters = @{@"client_id": clientID, @"password_grant_secret": passwordGrantSecret, @"grant_type": @"password", @"username": username, @"password": password, @"scope": [[self class] scopeStringForAuthScopes:authScopes]};
	[self authenticateWithParameters:parameters handler:completionHander];
}


- (NSURLRequest *)webAuthRequestForClientID:(NSString *)clientID redirectURI:(NSString *)redirectURI authScopes:(ANKAuthScope)authScopes state:(NSString *)state appStoreCompliant:(BOOL)shouldBeAppStoreCompliant {
	// http://developers.app.net/docs/authentication/flows/web/
	self.webAuthRedirectURI = redirectURI;
	NSMutableString *URLString = [NSMutableString stringWithFormat:@"https://account.app.net/oauth/authenticate?client_id=%@&response_type=code", clientID];

	if (authScopes) {
		[URLString appendFormat:@"&scope=%@", [[self class] scopeStringForAuthScopes:authScopes]];
	}

	if (redirectURI) {
		[URLString appendFormat:@"&redirect_uri=%@", redirectURI];
	}

	if (shouldBeAppStoreCompliant) {
		[URLString appendString:@"&adnview=appstore"];
	}

	if (state) {
		[URLString appendFormat:@"&state=%@", state];
	}

	NSURL *URL = [NSURL URLWithString:URLString];
	return [NSURLRequest requestWithURL:URL cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:60];
}


- (void)authenticateWebAuthAccessCode:(NSString *)accessCode forClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret {
	// http://developers.app.net/docs/authentication/flows/web/
	NSDictionary *parameters = @{@"client_id": clientID, @"client_secret": clientSecret, @"grant_type": @"authorization_code", @"redirect_uri": self.webAuthRedirectURI, @"code": accessCode};
	[self authenticateWithParameters:parameters handler:self.webAuthCompletionHandler];
}


+ (NSString *)scopeStringForAuthScopes:(ANKAuthScope)scopes {
	if (scopes == ANKAuthScopeNone) return nil;

    NSMutableArray *scopeValues = [NSMutableArray array];

    if ((scopes & ANKAuthScopeBasic) == ANKAuthScopeBasic)						[scopeValues addObject:@"basic"];
	if ((scopes & ANKAuthScopeStream) == ANKAuthScopeStream)					[scopeValues addObject:@"stream"];
	if ((scopes & ANKAuthScopeEmail) == ANKAuthScopeEmail)						[scopeValues addObject:@"email"];
	if ((scopes & ANKAuthScopeWritePost) == ANKAuthScopeWritePost)				[scopeValues addObject:@"write_post"];
	if ((scopes & ANKAuthScopeFollow) == ANKAuthScopeFollow)					[scopeValues addObject:@"follow"];
	if ((scopes & ANKAuthScopePublicMessages) == ANKAuthScopePublicMessages)	[scopeValues addObject:@"public_messages"];
	if ((scopes & ANKAuthScopeMessages) == ANKAuthScopeMessages)				[scopeValues addObject:@"messages"];
	if ((scopes & ANKAuthScopeUpdateProfile) == ANKAuthScopeUpdateProfile)		[scopeValues addObject:@"update_profile"];
	if ((scopes & ANKAuthScopeExport) == ANKAuthScopeExport)					[scopeValues addObject:@"export"];
	if ((scopes & ANKAuthScopeFiles) == ANKAuthScopeFiles)						[scopeValues addObject:@"files"];

    return [scopeValues componentsJoinedByString:@","];
}


+ (NSArray *)scopeDescriptionsForScope:(ANKAuthScope)scope {
	NSMutableArray *scopeDescriptions = [NSMutableArray array];

	static NSDictionary *scopeDescriptionMap = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSMutableDictionary *mapping = [[NSMutableDictionary alloc] init];
		mapping[@"basic"] = @"See basic information about you";
		mapping[@"stream"] = @"Read your stream";
		mapping[@"email"] = @"Access your email address";
		mapping[@"write_post"] = @"Create posts for you";
		mapping[@"follow"] = @"Add or remove follows (or mutes) for you";
		mapping[@"public_messages"] = @"Send and receive public messages for you";
		mapping[@"messages"] = @"Send and receive private and public messages for you";
		mapping[@"update_profile"] = @"Update your profile information";
		mapping[@"export"] = @"Bulk export all of your App.net data";
		mapping[@"files"] = @"Manage your files for you";

		scopeDescriptionMap = mapping;
	});

	NSArray *scopeKeys = [[self scopeStringForAuthScopes:scope] componentsSeparatedByString:@","];
	for (NSString *scopeKey in scopeKeys) {
		[scopeDescriptions addObject:scopeDescriptionMap[scopeKey]];
	}

	return scopeDescriptions;
}


- (void)logInWithAccessToken:(NSString *)accessToken completion:(void (^)(BOOL succeeded, ANKAPIResponseMeta *meta, NSError *error))completionHandler {
	self.accessToken = accessToken;
	[self fetchTokenStatusForCurrentUserWithCompletion:^(ANKTokenStatus *tokenStatus, ANKAPIResponseMeta *meta, NSError *error) {
		BOOL success = tokenStatus.user != nil;
		if (success) {
			self.authenticatedUser = tokenStatus.user;
		}
		if (completionHandler) {
			completionHandler(success, meta, error);
		}
	}];
}


- (BOOL)isAuthenticated {
	return self.accessToken != nil;
}


- (BOOL)isLoggedIn {
	return self.isAuthenticated && self.authenticatedUser != nil;
}


- (void)logOut {
	self.accessToken = nil;
	self.authenticatedUser = nil;
}


- (void)logOutAndDeauthorizeUserTokenWithCompletion:(ANKClientCompletionBlock)completionHandler {
	[self deauthorizeCurrentUserTokenWithCompletion:^(id responseObject, ANKAPIResponseMeta *meta, NSError *error) {
		if (!meta.isError && !error) {
			[self logOut];
		}

		if (completionHandler) {
			completionHandler(responseObject, meta, error);
		}
	}];
}


#pragma mark -
#pragma mark Pagination

- (instancetype)clientWithPagination:(ANKPaginationSettings *)pagination {
	ANKClient *clientCopy = [self copy];
	clientCopy.pagination = pagination;
	return clientCopy;
}


#pragma mark -
#pragma mark User Defaults

- (NSUserDefaults *)userDefaults {
#ifdef ANK_OSX
	return (self.shouldUseSharedUserDefaultsController ? [[NSUserDefaultsController sharedUserDefaultsController] defaults] : [NSUserDefaults standardUserDefaults]);
#else
	return [NSUserDefaults standardUserDefaults];
#endif
}


- (NSDictionary *)authenticatedUserDefaults {
	return self.isAuthenticated ? [self.userDefaults objectForKey:[NSString stringWithFormat:@"ANKUser%@", self.authenticatedUser.userID]] : nil;
}


- (void)setObject:(id)object forKeyInAuthenticatedUserDefaults:(NSString *)key {
	if (self.isAuthenticated) {
		NSDictionary *settings = [self authenticatedUserDefaults] ?: @{};
		NSMutableDictionary *modifiedSettings = [NSMutableDictionary dictionaryWithDictionary:settings];

		if (object) {
			modifiedSettings[key] = object;
		} else {
			[modifiedSettings removeObjectForKey:key];
		}

		[self.userDefaults setObject:modifiedSettings forKey:[NSString stringWithFormat:@"ANKUser%@", self.authenticatedUser.userID]];
		if (self.shouldSynchronizeOnUserDefaultsWrite) {
			[self.userDefaults synchronize];
		}
	}
}


- (id)objectForKeyInAuthenticatedUserDefaults:(NSString *)key {
	return self.authenticatedUserDefaults[key];
}


#pragma mark -
#pragma mark Streams

- (void)requestStreamingUpdatesForOperation:(ANKJSONRequestOperation *)operation withDelegate:(id<ANKStreamingDelegate>)delegate {
    [operation pause];

    ANKJSONRequestOperation *finalizedOperation = operation;
    NSString *subscriptionID = nil;

    if (!self.streamingConnectionID) {

        NSMutableURLRequest *streamingRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"wss://stream-channel.app.net/stream/user"]];
        [streamingRequest setValue:[self defaultValueForHeader:@"Authorization"] forHTTPHeaderField:@"Authorization"];
        self.socketShuttle = [[KATSocketShuttle alloc] initWithRequest:streamingRequest delegate:self];
    } else {

        finalizedOperation = [self reconfigureOperationForStreaming:operation subscriptionID:&subscriptionID streamingDelegate:delegate];
    }

    ANKStreamContext *context = [[ANKStreamContext alloc] initWithBaseOperation:finalizedOperation identifier:subscriptionID socketShuttle:nil streamingDelegate:delegate];
    [self.socketContexts addObject:context];
}


- (ANKJSONRequestOperation *)reconfigureOperationForStreaming:(ANKJSONRequestOperation *)operation subscriptionID:(NSString **)subscriptionID streamingDelegate:(id<ANKStreamingDelegate>)streamingDelegate
{
    NSString *uniqueString = [[NSProcessInfo processInfo] globallyUniqueString];
    *subscriptionID = uniqueString;

    NSURL *modifiedURL = [NSURL URLWithString:[operation.request.URL.absoluteString stringByAppendingFormat:@"&connection_id=%@&subscription_id=%@", self.streamingConnectionID, uniqueString]];
    NSMutableURLRequest *request = [operation.request mutableCopy];
    request.URL = modifiedURL;

    [operation cancel];

    ANKJSONRequestOperation *newOperation = [[ANKJSONRequestOperation alloc] initWithRequest:request];
    [self enqueueHTTPRequestOperation:newOperation];

    return newOperation;
}


- (id)parsedObjectFromJSON:(NSDictionary *)JSON
{
    if (self.responseDecodingType != ANKResponseDecodingTypeNone) {

        NSSet *dataSet = [[NSSet alloc] initWithArray:JSON[@"data"]];
        NSDictionary *sampleObject = [dataSet anyObject];

        if (sampleObject) {
            BOOL isUser = sampleObject[@"username"] && sampleObject[@"timezone"] && sampleObject[@"avatar_image"];
            BOOL isMessage = sampleObject[@"channel_id"] && !sampleObject[@"canonical_url"] && !sampleObject[@"num_stars"];
            BOOL isPost = sampleObject[@"num_stars"] && sampleObject[@"user"] && sampleObject[@"canonical_url"] && sampleObject[@"text"];
            //        BOOL isChannel = sampleObject[@"has_unread"] && sampleObject[@"readers"];
            BOOL isFile = sampleObject[@"complete"] && sampleObject[@"derived_files"];

            ANKAPIResponse *response = [[ANKAPIResponse alloc] initWithResponseObject:JSON];
            Class resourceClass = nil;

            if (isUser)
                resourceClass = [ANKUser class];
            else if (isMessage)
                resourceClass = [ANKMessage class];
            else if (isPost)
                resourceClass = [ANKPost class];
            else if (isFile)
                resourceClass = [ANKFile class];
            //        else if (isChannel)
            //            resourceClass = [ANKChannel class];

            if (resourceClass)
                return [self unboxCollectionResponse:response ofResourceClass:resourceClass];
        }
    }

    return JSON;
}

- (NSSet *)streamingDelegates {
    return [self.socketContexts valueForKey:@"streamingDelegate"];
}

- (NSSet *)streamingDelegatesImplementingDelegateMethod:(SEL)delegateMethod {
    return [[self streamingDelegates] filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id<ANKStreamingDelegate> streamingDelegate, NSDictionary *bindings) {
        return [streamingDelegate respondsToSelector:delegateMethod];
    }]];
}


#pragma mark -
#pragma mark Internal API

- (void)initializeHTTPAuthClient {
	self.authHTTPClient = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"https://account.app.net/oauth"]];
	self.authHTTPClient.parameterEncoding = AFFormURLParameterEncoding;
	[self.authHTTPClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
}


- (void)authenticateWithParameters:(NSDictionary *)params handler:(void (^)(BOOL successful, NSError *error))handler {
	[self initializeHTTPAuthClient];
	[self.authHTTPClient postPath:@"access_token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
		if (responseDictionary[@"access_token"]) {
			if (responseDictionary[@"token"]) {
				ANKTokenStatus *token = [ANKResolve(ANKTokenStatus) objectFromJSONDictionary:responseDictionary[@"token"]];
				self.authenticatedUser = token.user;
			}
			self.accessToken = responseDictionary[@"access_token"];
			[self HTTPAuthDidCompleteSuccessfully:YES error:nil handler:handler];
		} else {
			NSError *error = [NSError errorWithDomain:kANKErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey: @"Could not find key access_token in response", NSLocalizedFailureReasonErrorKey: responseDictionary}];
			[self HTTPAuthDidCompleteSuccessfully:NO error:error handler:handler];
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		[self HTTPAuthDidCompleteSuccessfully:NO error:error handler:handler];
	}];
}


- (void)HTTPAuthDidCompleteSuccessfully:(BOOL)wasSuccessful error:(NSError *)error handler:(void (^)(BOOL successful, NSError *error))handler {
	if (error.localizedRecoverySuggestion) {
		NSDictionary *errorDictionary = [NSJSONSerialization JSONObjectWithData:[error.localizedRecoverySuggestion dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
		if (errorDictionary) {
			NSError *modifiedError = [NSError errorWithDomain:kANKErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey: errorDictionary[@"error"]}];
			error = modifiedError;
		}
	}
	if (handler) {
		handler(wasSuccessful, error);
	}

	self.authHTTPClient = nil;
	self.webAuthCompletionHandler = nil;
	self.webAuthRedirectURI = nil;
}


#pragma mark -
#pragma mark KATSocketShuttleDelegate

- (void)socketDidOpen:(KATSocketShuttle *)socket {

    __weak typeof(self) weakSelf = self;
    [[self streamingDelegatesImplementingDelegateMethod:@selector(clientSocketDidConnect:)] enumerateObjectsUsingBlock:^(id<ANKStreamingDelegate> streamingDelegate, BOOL *stop) {
        [streamingDelegate clientSocketDidConnect:weakSelf];
    }];
}

- (void)socket:(KATSocketShuttle *)socket didReceiveMessage:(id)message {
    NSError *error = nil;
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:[message dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];

    if (error) {
        NSLog(@"JSON couldn't be parsed. %@", error);
        return;
    }

    NSDictionary *metaDict = JSON[@"meta"];
    NSString *connectionID = metaDict[@"connection_id"];
    NSArray *subscriptionIDs = metaDict[@"subscription_ids"];

    ANKAPIResponse *response = [[ANKAPIResponse alloc] initWithResponseObject:JSON];

    if (!self.streamingConnectionID) {
        self.streamingConnectionID = connectionID;

        for (ANKStreamContext *streamContext in self.socketContexts) {
            NSString *newID = nil;
            streamContext.baseOperation = [self reconfigureOperationForStreaming:streamContext.baseOperation subscriptionID:&newID streamingDelegate:streamContext.streamingDelegate];
            streamContext.identifier = newID;
        }

    } else {
        for (NSString *subscriptionID in subscriptionIDs) {
            id object = [self parsedObjectFromJSON:JSON];
            
            for (ANKStreamContext *streamContext in [self.socketContexts filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"identifier == %@", subscriptionID]]) {
                [streamContext.streamingDelegate client:self didReceiveObject:object withMeta:response.meta];
            }
        }
    }
}

- (void)socket:(KATSocketShuttle *)socket didFailWithError:(NSError *)error {

}

- (void)socket:(KATSocketShuttle *)socket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {

}

@end
