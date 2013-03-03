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

- (NSString *)scopeStringForAuthScopes:(ADNAuthScope)scopes;

@end


@implementation ADNClient

+ (instancetype)sharedClient {
    static ADNClient *sharedADNClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedADNClient = [[ADNClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://alpha-api.app.net/stream/0/"]];
    });
    
    return sharedADNClient;
}


- (id)initWithBaseURL:(NSURL *)URL {
    if ((self = [super initWithBaseURL:URL])) {
		self.parameterEncoding = AFJSONParameterEncoding;
		[self setDefaultHeader:@"Accept" value:@"application/json"];
		[self registerHTTPOperationClass:[ADNJSONRequestOperation class]];
	}
    
    return self;
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


- (NSURLRequest *)webAuthRequestForClientID:(NSString *)clientID redirectURI:(NSString *)redirectURI responseType:(ADNWebAuthResponseType)responseType authScopes:(ADNAuthScope)authScopes state:(NSString *)state appStoreCompliant:(BOOL)shouldBeAppStoreCompliant {
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
