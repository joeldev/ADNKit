//
//  ADNClient.h
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//


typedef NS_ENUM(NSUInteger, ADNWebAuthResponseType) {
	ADNWebAuthResponseTypeToken = 0,
	ADNWebAuthResponseTypeCode
};

typedef NS_ENUM(NSUInteger, ADNAuthScope) {
    ADNAuthScopeNone            = 0,
    ADNAuthScopeBasic           = (1 << 0), // see basic information about this user
    ADNAuthScopeStream          = (1 << 1), // read this user’s stream
    ADNAuthScopeEmail           = (1 << 2), // access this user’s email address
    ADNAuthScopeWritePost       = (1 << 3), // create a new post as this user
    ADNAuthScopeFollow          = (1 << 4), // add or remove follows (or mutes) for this user
    ADNAuthScopePublicMessages  = (1 << 5), // send and receive public messages as this user
    ADNAuthScopeMessages        = (1 << 6), // send and receive public and private messages as this user
    ADNAuthScopeUpdateProfile   = (1 << 7), // update a user’s name, images, and other profile information
    ADNAuthScopeFiles           = (1 << 8), // manage a user’s files. This is not needed for uploading files.
    ADNAuthScopeExport          = (1 << 9), // bulk export all of this user’s App.net data
};


@interface ADNClient : AFHTTPClient

+ (instancetype)sharedClient;

// username/password authentication
- (void)authenticateUsername:(NSString *)username password:(NSString *)password clientID:(NSString *)clientID passwordGrantSecret:(NSString *)passwordGrantSecret authScopes:(ADNAuthScope)authScopes completionHandler:(void (^)(BOOL success, NSError *error))completionHander;

// web-style authentication meant to be shown in a webview
- (NSURLRequest *)webAuthRequestForClientID:(NSString *)clientID redirectURI:(NSString *)redirectURI responseType:(ADNWebAuthResponseType)responseType authScopes:(ADNAuthScope)authScopes state:(NSString *)state appStoreCompliant:(BOOL)shouldBeAppStoreCompliant;

@property (strong) NSString *accessToken;

@end
