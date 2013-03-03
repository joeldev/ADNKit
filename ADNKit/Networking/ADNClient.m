//
//  ADNClient.m
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNClient.h"
#import "ADNJSONRequestOperation.h"


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


- (NSURL *)webAuthURLForClientID:(NSString *)clientID redirectURI:(NSString *)redirectURI responseType:(ADNWebAuthResponseType)responseType authScopes:(ADNAuthScopes)authScopes state:(NSString *)state appStoreCompliant:(BOOL)shouldBeAppStoreCompliant {
#warning TODO
	// http://developers.app.net/docs/authentication/flows/web/
	return nil;
}


- (void)authenticateUsername:(NSString *)username password:(NSString *)password clientID:(NSString *)clientID passwordGrantSecret:(NSString *)passwordGrantSecret authScopes:(ADNAuthScopes)authScopes completionHandler:(void (^)(BOOL success, NSError *error))completionHander {
#warning TODO
	// http://developers.app.net/docs/authentication/flows/password/
	if (completionHander) {
		completionHander(NO, nil);
	}
}


@end
