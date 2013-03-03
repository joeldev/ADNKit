//
//  ADNClient.m
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNClient.h"
#import "ADNJSONRequestOperation.h"


@interface ADNClient ()

@property (strong) AFHTTPClient *webAuthClient;

- (NSString *)scopeStringForAuthScopes:(ADNAuthScope)scopes;
- (void)webAuthDidCompleteSuccessfully:(BOOL)wasSuccessful error:(NSError *)error;

@end


@implementation ADNClient

+ (instancetype)sharedClient {
    static ADNClient *sharedADNClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedADNClient = [[ADNClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://alpha-api.app.net/stream/0"]];
    });
    
    return sharedADNClient;
}


- (id)initWithBaseURL:(NSURL *)URL {
    if ((self = [super initWithBaseURL:URL])) {
		self.parameterEncoding = AFJSONParameterEncoding;
		[self setDefaultHeader:@"Accept" value:@"application/json"];
		[self registerHTTPOperationClass:[ADNJSONRequestOperation class]];
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


#pragma mark -
#pragma mark Auth

- (void)authenticateUsername:(NSString *)username password:(NSString *)password clientID:(NSString *)clientID passwordGrantSecret:(NSString *)passwordGrantSecret authScopes:(ADNAuthScope)authScopes completionHandler:(void (^)(BOOL success, NSError *error))completionHander {
#warning TODO
	// http://developers.app.net/docs/authentication/flows/password/
	if (completionHander) {
		completionHander(NO, nil);
	}
}


- (NSURLRequest *)webAuthRequestForClientID:(NSString *)clientID redirectURI:(NSString *)redirectURI authScopes:(ADNAuthScope)authScopes state:(NSString *)state appStoreCompliant:(BOOL)shouldBeAppStoreCompliant {
	// http://developers.app.net/docs/authentication/flows/web/
	
	NSMutableString *URLString = [NSMutableString stringWithFormat:@"https://account.app.net/oauth/authenticate?client_id=%@&response_type=code", clientID];
	
	if (authScopes) {
		[URLString appendFormat:@"&scope=%@", [self scopeStringForAuthScopes:authScopes]];
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
	self.webAuthClient = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"https://account.app.net/oauth"]];
	self.webAuthClient.parameterEncoding = AFFormURLParameterEncoding;
	[self.webAuthClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
	
	NSDictionary *parameters = @{@"client_id": clientID, @"client_secret:": clientSecret, @"grant_type": @"authorization_code", @"redirect_uri": @"foo://bar", @"code": accessCode};
	
	[self.webAuthClient postPath:@"/access_token" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSDictionary *responseDictionary = (NSDictionary *)responseObject;
		if (responseDictionary[@"access_token"]) {
			self.accessToken = responseDictionary[@"access_token"];
			[self webAuthDidCompleteSuccessfully:YES error:nil];
		} else {
			// TODO: create an error saying that we didn't get access_token back
			[self webAuthDidCompleteSuccessfully:NO error:nil];
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		[self webAuthDidCompleteSuccessfully:NO error:error];
	}];
}


#pragma mark -
#pragma mark Internal API

- (void)webAuthDidCompleteSuccessfully:(BOOL)wasSuccessful error:(NSError *)error {
	if (self.webAuthCompletionHandler) {
		self.webAuthCompletionHandler(wasSuccessful, error);
		self.webAuthCompletionHandler = nil;
	}
	if (self.webAuthClient) {
		self.webAuthClient = nil;
	}
}


- (NSString *)scopeStringForAuthScopes:(ADNAuthScope)scopes {
	if (scopes == ADNAuthScopeNone) return nil;
    
    NSMutableArray *scopeValues = [NSMutableArray array];
    
    if ((scopes & ADNAuthScopeBasic) == ADNAuthScopeBasic)						[scopeValues addObject:@"basic"];
	if ((scopes & ADNAuthScopeStream) == ADNAuthScopeStream)					[scopeValues addObject:@"stream"];
	if ((scopes & ADNAuthScopeEmail) == ADNAuthScopeEmail)						[scopeValues addObject:@"email"];
	if ((scopes & ADNAuthScopeWritePost) == ADNAuthScopeWritePost)				[scopeValues addObject:@"write_post"];
	if ((scopes & ADNAuthScopeFollow) == ADNAuthScopeFollow)					[scopeValues addObject:@"follow"];
	if ((scopes & ADNAuthScopePublicMessages) == ADNAuthScopePublicMessages)	[scopeValues addObject:@"public_messages"];
	if ((scopes & ADNAuthScopeMessages) == ADNAuthScopeMessages)				[scopeValues addObject:@"messages"];
	if ((scopes & ADNAuthScopeUpdateProfile) == ADNAuthScopeUpdateProfile)		[scopeValues addObject:@"update_profile"];
	if ((scopes & ADNAuthScopeExport) == ADNAuthScopeExport)					[scopeValues addObject:@"export"];
	if ((scopes & ADNAuthScopeFiles) == ADNAuthScopeFiles)						[scopeValues addObject:@"files"];
    
    return [scopeValues componentsJoinedByString:@","];
}


@end
