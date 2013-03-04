//
//  ADNClient+ADNUser.h
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNClient.h"


@interface ADNClient (ADNUser)

// /stream/0/users/[user_id]
// http://developers.app.net/docs/resources/user/lookup/#retrieve-a-user

- (void)fetchMyUserWithCompletion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

@end
