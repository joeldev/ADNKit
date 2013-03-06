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

// http://developers.app.net/docs/resources/post/lookup/#retrieve-a-post

- (void)fetchPostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"posts/%@", postID]
	   parameters:nil
		  success:[self successHandlerForResourceClass:[ADNPost class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/lookup/#retrieve-multiple-posts

- (void)fetchPostsWithIDs:(NSArray *)postIDs completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"posts"]
	   parameters:@{@"ids": [postIDs componentsJoinedByString:@","]}
		  success:[self successHandlerForCollectionOfResourceClass:[ADNPost class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/replies/#retrieve-the-replies-to-a-post

- (void)fetchRepliesToPost:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler {
	[self fetchRepliesToPostWithID:post.postID completion:completionHandler];
}


- (void)fetchRepliesToPostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"posts/%@/replies", postID]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ADNPost class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/stars/#retrieve-posts-starred-by-a-user

- (void)fetchPostsStarredByUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler {
	[self fetchPostsStarredByUserWithID:user.userID completion:completionHandler];
}


- (void)fetchPostsStarredByUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"posts/%@/stars", userID]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ADNPost class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/lifecycle/#create-a-post

- (void)createPostWithText:(NSString *)text completion:(ADNClientCompletionBlock)completionHandler {
	[self createPostWithText:text inReplyToPostWithID:nil completion:completionHandler];
}


- (void)createPostWithText:(NSString *)text inReplyToPost:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler {
	[self createPostWithText:text inReplyToPostWithID:post.postID completion:completionHandler];
}


- (void)createPostWithText:(NSString *)text inReplyToPostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler {
	[self postPath:@"posts"
		parameters:(postID ? @{@"text": text, @"reply_to": postID} : @{@"text": text})
		   success:[self successHandlerForResourceClass:[ADNPost class] clientHandler:completionHandler]
		   failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/lifecycle/#delete-a-post

- (void)deletePost:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler {
	[self deletePostWithID:post.postID completion:completionHandler];
}


- (void)deletePostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler {
	[self deletePath:[NSString stringWithFormat:@"posts/%@", postID]
		  parameters:nil
			 success:[self successHandlerForResourceClass:[ADNPost class] clientHandler:completionHandler]
			 failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/reposts/#repost-a-post

- (void)repostPost:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler {
	[self repostPostWithID:post.postID completion:completionHandler];
}


- (void)repostPostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler {
	[self postPath:[NSString stringWithFormat:@"posts/%@/repost", postID]
		parameters:nil
		   success:[self successHandlerForResourceClass:[ADNPost class] clientHandler:completionHandler]
		   failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/reposts/#unrepost-a-post

- (void)unrepostPost:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler {
	[self unrepostPostWithID:post.postID completion:completionHandler];
}


- (void)unrepostPostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler {
	[self deletePath:[NSString stringWithFormat:@"posts/%@/repost", postID]
		  parameters:nil
			 success:[self successHandlerForResourceClass:[ADNPost class] clientHandler:completionHandler]
			 failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/stars/#star-a-post

- (void)starPost:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler {
	[self starPostWithID:post.postID completion:completionHandler];
}


- (void)starPostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler {
	[self postPath:[NSString stringWithFormat:@"posts/%@/star", postID]
		parameters:nil
		   success:[self successHandlerForResourceClass:[ADNPost class] clientHandler:completionHandler]
		   failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/stars/#unstar-a-post

- (void)unstarPost:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler {
	[self unstarPostWithID:post.postID completion:completionHandler];
}


- (void)unstarPostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler {
	[self deletePath:[NSString stringWithFormat:@"posts/%@/star", postID]
		  parameters:nil
			 success:[self successHandlerForResourceClass:[ADNPost class] clientHandler:completionHandler]
			 failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/report/#report-a-post

- (void)reportPostAsSpam:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler {
	[self reportPostWithIDAsSpam:post.postID completion:completionHandler];
}


- (void)reportPostWithIDAsSpam:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler {
	[self postPath:[NSString stringWithFormat:@"posts/%@/report", postID]
		parameters:nil
		   success:[self successHandlerForResourceClass:[ADNPost class] clientHandler:completionHandler]
		   failure:[self failureHandlerForClientHandler:completionHandler]];
}


@end
