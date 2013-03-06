//
//  ADNClient+ADNPost.m
//  ADNKit
//
//  Created by Joel Levin on 3/5/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNClient+ADNPost.h"
#import "ADNPost.h"
#import "ADNUser.h"


@implementation ADNClient (ADNPost)

- (void)createPostWithText:(NSString *)text completion:(ADNClientCompletionBlock)completionHandler {
	[self createPostWithText:text inReplyToPostIDWithID:nil completion:completionHandler];
}


- (void)createPostWithText:(NSString *)text inReplyToPost:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler {
	[self createPostWithText:text inReplyToPostWithID:post.postID completion:completionHandler];
}


- (void)createPostWithText:(NSString *)text inReplyToPostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler {
	[self postPath:@"posts"
		parameters:@{@"text": text, @"reply_to": postID}
		   success:[self successHandlerForResourceClass:[ADNPost class] clientHandler:completionHandler]
		   failure:[self failureHandlerForClientHandler:completionHandler]];
}


@end
