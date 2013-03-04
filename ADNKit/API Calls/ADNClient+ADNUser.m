//
//  ADNClient+ADNUser.m
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNClient+ADNUser.h"
#import "ADNUser.h"


@implementation ADNClient (ADNUser)

// /stream/0/users/[user_id]
// http://developers.app.net/docs/resources/user/lookup/#retrieve-a-user

- (void)fetchMyUserWithCompletion:(ADNClientCompletionBlock)completionHandler {
	[self fetchUserWithID:@"me" completion:completionHandler];
}


- (void)fetchUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"users/%@", userID]
	   parameters:nil
		  success:[self successHandlerForResourceClass:[ADNUser class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


@end
