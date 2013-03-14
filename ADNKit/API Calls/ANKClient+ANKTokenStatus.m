//
//  ANKClient+ANKTokenStatus.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/14/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKClient+ANKTokenStatus.h"
#import "ANKTokenStatus.h"


@implementation ANKClient (ANKTokenStatus)

- (void)fetchTokenStatusForCurrentUserWithCompletion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:@"token"
	   parameters:nil
		  success:[self successHandlerForResourceClass:[ANKTokenStatus class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


- (void)fetchTokenStatusesForAuthorizedUsersWithCompletion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:@"apps/me/tokens"
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKTokenStatus class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


- (void)fetchAuthorizedUserIDsWithCompletion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:@"apps/me/tokens/user_ids"
	   parameters:nil
		  success:[self successHandlerForPrimitiveResponseWithClientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


@end
