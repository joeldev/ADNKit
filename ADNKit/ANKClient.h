/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "AFNetworking.h"
#import "ANKJSONRequestOperation.h"


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


typedef NS_ENUM(NSUInteger, ANKResponseDecodingType) {
	ANKResponseDecodingTypeModel = 0, // default - decodes server responses as model objects
	ANKResponseDecodingTypeNone // don't decode server response
};


@class ANKAPIResponseMeta;
typedef void (^ANKClientCompletionBlock)(id responseObject, ANKAPIResponseMeta *meta, NSError *error);


@class ANKPaginationSettings, ANKGeneralParameters, ANKUser, ANKAPIResponseMeta;

@interface ANKClient : AFHTTPClient

+ (NSURL *)APIBaseURL; // defaults to @"https://alpha-api.app.net/stream/0/" -- subclass and override to change it
+ (instancetype)sharedClient;

@property (readonly, strong) ANKUser *authenticatedUser; // the authenticated user object
@property (strong) NSString *accessToken; // access token acquired by auth or persisted across launches and set directly
@property (strong) ANKPaginationSettings *pagination;
@property (strong) ANKGeneralParameters *generalParameters;
@property (assign) ANKResponseDecodingType responseDecodingType;

@property (assign) BOOL shouldRequestAnnotations; // when yes, annotations will be fetched regardless of the object type
@property (assign) BOOL shouldUseSharedUserDefaultsController; // default NO - uses [NSUserDefaults standardUserDefaults] when NO, [[NSUserDefaultsController sharedUserDefaultsController] defaults] when YES.
@property (assign) BOOL shouldSynchronizeOnUserDefaultsWrite; // default NO - if set to YES, will call synchronize on each write to make sure that user defaults are written to disk immediately

@property (assign) dispatch_queue_t successCallbackQueue;
@property (assign) dispatch_queue_t failureCallbackQueue;

@property (copy) void (^webAuthCompletionHandler)(BOOL success, NSError *error); // set as completion block for oauth authentication

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

// use this method to log back in when you have a stored accessToken for this user. this is asynchronous because we need to fetch the current user. this method sets the authenticatedUser property.
- (void)logInWithAccessToken:(NSString *)accessToken completion:(void (^)(BOOL succeeded, ANKAPIResponseMeta *meta, NSError *error))completionHandler;

// return YES when an authenticated user session is active, NO otherwise
- (BOOL)isAuthenticated;

// returns YES when there is an access token set and an authenticated user object (set via logInWithAccessToken:completion:)
- (BOOL)isLoggedIn;

// does all proper cleanup required to log this user out. does not invalidate the auth token, simply "forgets" it.
- (void)logOut;

// does everything the above method does and also invalidates the auth token
- (void)logOutAndDeauthorizeUserTokenWithCompletion:(ANKClientCompletionBlock)completionHandler;

#pragma mark -
#pragma mark Pagination

// returns a copy of the receiever with the passed pagination settings
- (instancetype)clientWithPagination:(ANKPaginationSettings *)pagination;

#pragma mark -
#pragma mark User Defaults

// These methods provide an easy way to store per-user preferences. Each ANKClient represents a single authenticated user, so using these methods on a particular ANKClient will read/write settings for that user. The user ID is used as the key namespace, which won't change even if the user changes their username.

- (NSUserDefaults *)userDefaults; // will likely be [NSUserDefaults standandUserDefaults]
- (NSDictionary *)authenticatedUserDefaults;
- (void)setObject:(id)object forKeyInAuthenticatedUserDefaults:(NSString *)key;
- (id)objectForKeyInAuthenticatedUserDefaults:(NSString *)key;


#pragma mark -
#pragma mark Operation Queues

- (void)setSuccessCallbackQueue:(dispatch_queue_t)successCallbackQueue failureCallbackQueue:(dispatch_queue_t)failureCallbackQueue;

@end
