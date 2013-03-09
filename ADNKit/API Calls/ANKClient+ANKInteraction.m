//
//  ANKClient+ANKInteraction.m
//  ADNKit
//
//  Created by Joel Levin on 3/8/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKClient+ANKInteraction.h"
#import "ANKInteraction.h"


@implementation ANKClient (ANKInteraction)

- (void)fetchInteractionsForCurrentUserWithCompletion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:@"users/me/interations"
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKInteraction class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}

@end
