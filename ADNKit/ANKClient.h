//
//  ADNClient.h
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "AFNetworking.h"


typedef NS_ENUM(NSUInteger, ANKAuthScope) {
    ANKAuthScopeNone            = 0,
    ANKAuthScopeBasic           = (1 << 0), // see basic information about this user
    ANKAuthScopeStream          = (1 << 1), // read this user’s stream
    ANKAuthScopeEmail           = (1 << 2), // access this user’s email address
    ANKAuthScopeWritePost       = (1 << 3), // create a new post as this user
    ANKAuthScopeFollow          = (1 << 4), // add or remove follows (or mutes) for this user
    ANKAuthScopePublicMessages  = (1 << 5), // send and receive public messages as this user
    ANKAuthScopeMessages        = (1 << 6), // send and receive public and private messages as this user
    ANKAuthScopeUpdateProfile   = (1 << 7), // update a user’s name, images, and other profile information
    ANKAuthScopeFiles           = (1 << 8), // manage a user’s files. This is not needed for uploading files.
    ANKAuthScopeExport          = (1 << 9), // bulk export all of this user’s App.net data
};


@class ANKPaginationSettings;

@interface ANKClient : AFHTTPClient

+ (instancetype)sharedClient;

@property (strong) NSString *accessToken; // access token acquired by auth or persisted across launches and set directly
@property (assign) BOOL shouldRequestAnnotations; // when yes, annotations will be fetched regardless of the object type
@property (copy) void (^webAuthCompletionHandler)(BOOL success, NSError *error); // set as completion block for oauth authentication
@property (strong) ANKPaginationSettings *defaultPagination;

#pragma mark -
#pragma mark Authentication

// username/password authentication
- (void)authenticateUsername:(NSString *)username password:(NSString *)password clientID:(NSString *)clientID passwordGrantSecret:(NSString *)passwordGrantSecret authScopes:(ANKAuthScope)authScopes completionHandler:(void (^)(BOOL success, NSError *error))completionHander;

// web-style authentication. call this method first, and then load the resulting URLRequest is a webview
- (NSURLRequest *)webAuthRequestForClientID:(NSString *)clientID redirectURI:(NSString *)redirectURI authScopes:(ANKAuthScope)authScopes state:(NSString *)state appStoreCompliant:(BOOL)shouldBeAppStoreCompliant;
// once you have an access code, call this method to finish web auth
- (void)authenticateWebAuthAccessCode:(NSString *)accessCode forClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret;

// returns the auth scope string expected by the server for the given scopes
+ (NSString *)scopeStringForAuthScopes:(ANKAuthScope)scopes;

// to conform to the requirements of username/password auth, it is required to show the user what permissions they are authorizing for you by signing in.
// this method returns full descriptions for the given scopes that can be placed in the UI
+ (NSArray *)scopeDescriptionsForScope:(ANKAuthScope)scope;

#pragma mark -
#pragma mark Pagination

- (instancetype)clientWithPagination:(ANKPaginationSettings *)pagination;

// call this method to apply the passed pagination settings to all requests fired from within the requestsBlock (similar to UIView animation).
// this does not effect the defaultPagination
- (void)paginate:(ANKPaginationSettings *)pagination requestsBlock:(void (^)(ANKPaginationSettings *currentPagination))requestsBlock;

@end
