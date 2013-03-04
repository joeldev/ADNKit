//
//  ADNClient.h
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "AFNetworking.h"


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

typedef void (^AFNetworkingSuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^AFNetworkingFailureBlock)(AFHTTPRequestOperation *operation, NSError *error);
typedef void (^ADNClientCompletionBlock)(id responseObject, NSError *error);


@interface ADNClient : AFHTTPClient

+ (instancetype)sharedClient;

#pragma mark -
#pragma mark Authentication

// username/password authentication
- (void)authenticateUsername:(NSString *)username password:(NSString *)password clientID:(NSString *)clientID passwordGrantSecret:(NSString *)passwordGrantSecret authScopes:(ADNAuthScope)authScopes completionHandler:(void (^)(BOOL success, NSError *error))completionHander;

// web-style authentication. call this method first, and then load the resulting URLRequest is a webview
- (NSURLRequest *)webAuthRequestForClientID:(NSString *)clientID redirectURI:(NSString *)redirectURI authScopes:(ADNAuthScope)authScopes state:(NSString *)state appStoreCompliant:(BOOL)shouldBeAppStoreCompliant;
// once you have an access code, call this method to finish web auth
- (void)authenticateWebAuthAccessCode:(NSString *)accessCode forClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret;

#pragma mark -
#pragma mark App.net API implementation convenience methods

- (AFNetworkingSuccessBlock)successHandlerForResourceClass:(Class)resourceClass clientHandler:(ADNClientCompletionBlock)handler;
- (AFNetworkingFailureBlock)successHandlerForCollectionOfResourceClass:(Class)resourceClass clientHandler:(ADNClientCompletionBlock)handler;
- (AFNetworkingFailureBlock)failureHandlerForClientHandler:(ADNClientCompletionBlock)handler;

#pragma mark -
#pragma mark Properties

@property (strong) NSString *accessToken;
@property (copy) void (^webAuthCompletionHandler)(BOOL success, NSError *error);

@end
