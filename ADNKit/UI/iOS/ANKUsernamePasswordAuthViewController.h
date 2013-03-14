//
//  ANKUsernamePasswordAuthViewController.h
//  ADNKit
//
//  Created by Joel Levin on 3/8/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ANKUsernamePasswordAuthViewController : UITableViewController <UITextFieldDelegate>

- (id)initWithClient:(ANKClient *)client clientID:(NSString *)clientID passwordGrantSecret:(NSString *)passwordGrantSecret authScopes:(ANKAuthScope)authScopes completion:(void (^)(ANKClient *authedClient, NSError *error, ANKUsernamePasswordAuthViewController *controller))completionHandler;

// set these blocks if you want to show a loading UI during the request
@property (copy) void (^authRequestDidBegin)(void);
@property (copy) void (^authRequestDidFinish)(void);

@end
