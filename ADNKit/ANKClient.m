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
#import "AFHTTPRequestOperation.h"
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
#import "ANKChannel.h"
#import "ANKClient+ANKTokenStatus.h"
#import "ANKStreamContext.h"
#import "ANKAPIRequestSerializer.h"
#import "ANKAPIResponseSerializer.h"
#import <SocketShuttle/KATSocketShuttle.h>


static const NSString *kANKUserStreamEndpointURL = @"wss://stream-channel.app.net/stream/user";


@interface ANKClient () <KATSocketShuttleDelegate>

@property (strong) NSString *webAuthRedirectURI;
@property (readwrite, strong) AFHTTPRequestOperationManager *requestManager;
@property (readwrite, strong) ANKUser *authenticatedUser;

@property (nonatomic, strong) KATSocketShuttle *socketShuttle;
@property (nonatomic, copy) NSString *streamingConnectionID;
@property (nonatomic, copy) NSString *lastSuccessfulStreamingConnectionID;
@property (nonatomic, strong) NSMutableSet *streamContexts;

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
    if ((self = [super init])) {
        self.requestManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[[self class] APIBaseURL]];
        self.requestManager.requestSerializer = [ANKAPIRequestSerializer serializer];
        self.requestManager.responseSerializer = [ANKAPIResponseSerializer serializer];

		self.pagination = [[ANKPaginationSettings alloc] init];
		self.generalParameters = [[ANKGeneralParameters alloc] init];
		self.generalParameters.includeHTML = NO;

		[self addObserver:self forKeyPath:@"accessToken" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"generalParameters" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"pagination" options:NSKeyValueObservingOptionNew context:nil];

        self.streamContexts = [[NSMutableSet alloc] init];
        self.streamingAvailbility = ANKStreamingAvailabilityWiFi;
	}

    return self;
}


- (void)dealloc {
	[self removeObserver:self forKeyPath:@"accessToken"];
    [self removeObserver:self forKeyPath:@"generalParameters"];
	[self removeObserver:self forKeyPath:@"pagination"];
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
        [self.requestManager.requestSerializer clearAuthorizationHeader];

        if ([self.accessToken length] > 0) {
            [self.requestManager.requestSerializer setValue:[@"Bearer " stringByAppendingString:self.accessToken] forHTTPHeaderField:@"Authorization"];
        }
	} else if ([keyPath isEqualToString:@"generalParameters"] || [keyPath isEqualToString:@"pagination"]) {
        ANKAPIRequestSerializer *requestSerializer = (ANKAPIRequestSerializer *)self.requestManager.requestSerializer;

        requestSerializer.defaultParameters = [self defaultQueryParameters];
	}
}

- (NSDictionary *)defaultQueryParameters
{
    NSMutableDictionary *defaultQueryParameters = [NSMutableDictionary new];

    [defaultQueryParameters addEntriesFromDictionary:[self.generalParameters JSONDictionary]];
    [defaultQueryParameters addEntriesFromDictionary:[self.pagination JSONDictionary]];

    return [defaultQueryParameters copy];
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
#pragma mark Setters

- (void)setSuccessCallbackQueue:(dispatch_queue_t)successCallbackQueue failureCallbackQueue:(dispatch_queue_t)failureCallbackQueue
{
    self.successCallbackQueue = successCallbackQueue;
    self.failureCallbackQueue = failureCallbackQueue;
}


#pragma mark -
#pragma mark Internal API

- (void)authenticateWithParameters:(NSDictionary *)params handler:(void (^)(BOOL successful, NSError *error))handler {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager POST:@"https://account.app.net/oauth/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseDictionary) {
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

	self.webAuthCompletionHandler = nil;
	self.webAuthRedirectURI = nil;
}


#pragma mark -
#pragma mark Streams

- (NSURLRequest *)streamingRequest {
    if (!self.streamingConnectionID) {
        self.streamingConnectionID = [[NSProcessInfo processInfo] globallyUniqueString];
    }

    NSMutableURLRequest *streamingRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[(NSString *)kANKUserStreamEndpointURL stringByAppendingFormat:@"?connection_id=%@", self.streamingConnectionID]]];

    [streamingRequest setValue:self.requestManager.requestSerializer.HTTPRequestHeaders[@"Authorization"] forHTTPHeaderField:@"Authorization"];

    return streamingRequest;
}


- (void)requestStreamingUpdatesForOperation:(AFHTTPRequestOperation *)operation withDelegate:(id<ANKStreamingDelegate>)delegate {
    NSString *subscriptionID = nil;

    if (!self.streamingConnectionID) {
        [operation pause];

        self.socketShuttle = [[KATSocketShuttle alloc] initWithRequest:[self streamingRequest] delegate:self connectConditions:self.streamingAvailbility == ANKStreamingAvailabilityWiFi ? KATSocketConnectConditionWLAN : KATSocketConnectConditionAlways];
    }

    if (self.socketShuttle.socketState == KATSocketStateConnected) {
        [self reconfigureOperationForStreaming:operation subscriptionID:&subscriptionID];
    } else if (self.socketShuttle.socketState == KATSocketStateDisconnected || self.socketShuttle.socketState == KATSocketStateOffline) {
        if (operation.isPaused) {
            [operation resume];
        } else if (operation.isReady) {
            [operation start];
        }
    } else if (self.socketShuttle.socketState == KATSocketStateConnecting){
        [operation pause];
    }

    [self.streamContexts addObject:[ANKStreamContext streamContextWithOperation:operation identifier:subscriptionID delegate:delegate]];
}


- (void)reconfigureOperationForStreaming:(AFHTTPRequestOperation *)operation subscriptionID:(NSString **)subscriptionID {
    NSString *uniqueString = [[NSProcessInfo processInfo] globallyUniqueString];
    *subscriptionID = uniqueString;

    NSURL *modifiedURL = [NSURL URLWithString:[operation.request.URL.absoluteString stringByAppendingFormat:@"&connection_id=%@&subscription_id=%@", self.streamingConnectionID, uniqueString]];
    NSMutableURLRequest *request = [operation.request mutableCopy];
    request.URL = modifiedURL;

    [operation setValue:request forKey:@"request"];

    if (operation.isPaused) {
        [operation resume];
    } else if (operation.isFinished) {
        [operation start];
    }
}


- (id)parsedObjectFromJSON:(NSDictionary *)JSON {
    if (self.responseDecodingType != ANKResponseDecodingTypeNone) {
        NSSet *dataSet = [[NSSet alloc] initWithArray:JSON[@"data"]];
        NSDictionary *sampleObject = [dataSet anyObject];

        if (sampleObject) {
            BOOL isUser = sampleObject[@"username"] && sampleObject[@"timezone"] && sampleObject[@"avatar_image"];
            BOOL isMessage = sampleObject[@"channel_id"] && !sampleObject[@"canonical_url"] && !sampleObject[@"num_stars"];
            BOOL isPost = sampleObject[@"num_stars"] && sampleObject[@"user"] && sampleObject[@"canonical_url"] && sampleObject[@"text"];
            BOOL isChannel = sampleObject[@"has_unread"] && sampleObject[@"readers"];
            BOOL isFile = sampleObject[@"complete"] && sampleObject[@"file_token"];

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
            else if (isChannel)
                resourceClass = [ANKChannel class];

            if (resourceClass)
                return [self unboxCollectionResponse:response ofResourceClass:resourceClass];
        }
    }

    return JSON;
}


- (NSSet *)streamingDelegates {
    return [self.streamContexts valueForKey:@"delegate"];
}


- (NSSet *)streamingDelegatesImplementingDelegateMethod:(SEL)delegateMethod {
    return [[self streamingDelegates] filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id<ANKStreamingDelegate> streamingDelegate, NSDictionary *bindings) {
        return [streamingDelegate respondsToSelector:delegateMethod];
    }]];
}


- (void)iterateOverStreamingDelegatesImplementingDelegateMethod:(SEL)delegateMethod withBlock:(void (^)(id<ANKStreamingDelegate>streamingDelegate))iterativeBlock {
    [[self streamingDelegatesImplementingDelegateMethod:delegateMethod] enumerateObjectsUsingBlock:^(id<ANKStreamingDelegate>streamingDelegate, BOOL *stop) {
        iterativeBlock(streamingDelegate);
    }];
}


- (void)socketShuttleDisconnectCommon {
    self.socketShuttle = [[KATSocketShuttle alloc] initWithRequest:[self streamingRequest] delegate:self connectConditions:self.streamingAvailbility == ANKStreamingAvailabilityWiFi ? KATSocketConnectConditionWLAN : KATSocketConnectConditionAlways];
}


#pragma mark -
#pragma mark KATSocketShuttleDelegate

- (void)socketDidOpen:(KATSocketShuttle *)socket {
    __weak typeof(self) weakSelf = self;
    [self iterateOverStreamingDelegatesImplementingDelegateMethod:@selector(clientSocketDidConnect:) withBlock:^(id<ANKStreamingDelegate> streamingDelegate) {
        [streamingDelegate clientSocketDidConnect:weakSelf];
    }];
}


- (void)socket:(KATSocketShuttle *)socket didReceiveMessage:(id)message {
    NSError *error = nil;
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:[message dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        return;
    }

    NSDictionary *metaDict = JSON[@"meta"];
    NSString *connectionID = metaDict[@"connection_id"];
    NSArray *subscriptionIDs = metaDict[@"subscription_ids"];
    BOOL isInitialConnectionResponse = (JSON.count == 1 && connectionID);
    ANKAPIResponse *response = [[ANKAPIResponse alloc] initWithResponseObject:JSON];

    if (isInitialConnectionResponse) {
        BOOL connectionWasRevived = [self.streamingConnectionID isEqualToString:self.lastSuccessfulStreamingConnectionID];
        self.streamingConnectionID = connectionID;
        self.lastSuccessfulStreamingConnectionID = self.streamingConnectionID;

        if (!connectionWasRevived) {
            for (ANKStreamContext *streamContext in self.streamContexts) {
                NSString *newID = nil;
                [self reconfigureOperationForStreaming:streamContext.operation subscriptionID:&newID];
                streamContext.identifier = newID;
            }
        }
    } else {
        for (NSString *subscriptionID in subscriptionIDs) {
            id object = [self parsedObjectFromJSON:JSON];

            NSLog(@"Received object: %@ for subscription ID: %@", object, subscriptionID);

            for (id<ANKStreamingDelegate> streamingDelegate in [[self.streamContexts filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"identifier == %@", subscriptionID]] valueForKey:@"delegate"]) {
                NSLog(@"Messaging delegate %@", streamingDelegate);
                
                [streamingDelegate client:self didReceiveObject:object withMeta:response.meta];
            }
        }
    }
}


- (void)socket:(KATSocketShuttle *)socket didFailWithError:(NSError *)error {
    [self socketShuttleDisconnectCommon];

    __weak typeof(self) weakSelf = self;
    [self iterateOverStreamingDelegatesImplementingDelegateMethod:@selector(client:didDisconnectOnSocketError:) withBlock:^(id<ANKStreamingDelegate> streamingDelegate) {
        [streamingDelegate client:weakSelf didDisconnectOnSocketError:error];
    }];
}


- (void)socket:(KATSocketShuttle *)socket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    [self socketShuttleDisconnectCommon];

    __weak typeof(self) weakSelf = self;
    [self iterateOverStreamingDelegatesImplementingDelegateMethod:@selector(clientSocketDidDisconnect:) withBlock:^(id<ANKStreamingDelegate> streamingDelegate) {
        [streamingDelegate clientSocketDidDisconnect:weakSelf];
    }];
}


@end
