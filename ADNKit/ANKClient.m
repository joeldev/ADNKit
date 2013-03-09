//
//  ADNClient.m
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKClient.h"
#import "ANKJSONRequestOperation.h"


@interface ANKClient ()

@property (strong) AFHTTPClient *authHTTPClient;
@property (strong) NSString *webAuthRedirectURI;

- (void)initializeHTTPAuthClient;
- (void)HTTPAuthDidCompleteSuccessfully:(BOOL)wasSuccessful error:(NSError *)error handler:(void (^)(BOOL successful, NSError *error))handler;
- (void)authenticateWithParameters:(NSDictionary *)params handler:(void (^)(BOOL successful, NSError *error))handler;

@end


@implementation ANKClient

+ (instancetype)sharedClient {
    static ANKClient *sharedADNClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedADNClient = [[ANKClient alloc] init];
    });
    
    return sharedADNClient;
}


- (id)init {
    if ((self = [super initWithBaseURL:[NSURL URLWithString:@"https://alpha-api.app.net/stream/0/"]])) {
		self.parameterEncoding = AFJSONParameterEncoding;
		[self setDefaultHeader:@"Accept" value:@"application/json"];
		[self registerHTTPOperationClass:[ANKJSONRequestOperation class]];
		
		[self addObserver:self forKeyPath:@"accessToken" options:NSKeyValueObservingOptionNew context:nil];
	}
    
    return self;
}


- (void)dealloc {
	[self removeObserver:self forKeyPath:@"accessToken"];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:@"accessToken"]) {
		if (self.accessToken) {
			[self setDefaultHeader:@"Authorization" value:[@"Bearer " stringByAppendingString:self.accessToken]];
		} else {
			[self setDefaultHeader:@"Authorization" value:nil];
		}
	}
}


- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters {
	NSMutableDictionary *mutableParameters = parameters ? [parameters mutableCopy] : [NSMutableDictionary dictionary];
	if (self.shouldRequestAnnotations) {
		mutableParameters[@"include_annotations"] = @(1);
	}
	return [super requestWithMethod:method path:path parameters:mutableParameters];
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
			self.accessToken = responseDictionary[@"access_token"];
			[self HTTPAuthDidCompleteSuccessfully:YES error:nil handler:handler];
		} else {
			// TODO: create an error saying that we didn't get access_token back
			[self HTTPAuthDidCompleteSuccessfully:NO error:nil handler:handler];
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		[self HTTPAuthDidCompleteSuccessfully:NO error:error handler:handler];
	}];
}


- (void)HTTPAuthDidCompleteSuccessfully:(BOOL)wasSuccessful error:(NSError *)error handler:(void (^)(BOOL successful, NSError *error))handler {
	if (handler) {
		handler(wasSuccessful, error);
	}
	
	self.authHTTPClient = nil;
	self.webAuthCompletionHandler = nil;
	self.webAuthRedirectURI = nil;
}


@end
