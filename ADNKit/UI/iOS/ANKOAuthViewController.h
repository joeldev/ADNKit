//
//  ANKOAuthViewController.h
//  ADNKit
//
//  Created by Joel Levin on 3/8/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ANKOAuthViewController : UIViewController

- (id)initWithWebAuthRequest:(NSURLRequest *)request client:(ANKClient *)client completion:(void (^)(ANKClient *authedClient, NSError *error, ANKOAuthViewController *controller))completionHander;

// called after you parse the access code out from your redirect URI
- (void)authenticateWebAuthAccessCode:(NSString *)accessCode forClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret;

- (void)cancel;

@end
