//
//  ADNClient+ADNPost.m
//  ADNKit
//
//  Created by Joel Levin on 3/5/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKClient+ANKPost.h"
#import "ANKPost.h"
#import "ANKUser.h"


@implementation ANKClient (ANKPost)

// http://developers.app.net/docs/resources/post/lookup/#retrieve-a-post

- (void)fetchPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"posts/%@", postID]
	   parameters:nil
		  success:[self successHandlerForResourceClass:[ANKPost class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/lookup/#retrieve-multiple-posts

- (void)fetchPostsWithIDs:(NSArray *)postIDs completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"posts"]
	   parameters:@{@"ids": [postIDs componentsJoinedByString:@","]}
		  success:[self successHandlerForCollectionOfResourceClass:[ANKPost class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/replies/#retrieve-the-replies-to-a-post

- (void)fetchRepliesToPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler {
	[self fetchRepliesToPostWithID:post.postID completion:completionHandler];
}


- (void)fetchRepliesToPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"posts/%@/replies", postID]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKPost class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/stars/#retrieve-posts-starred-by-a-user

- (void)fetchPostsStarredByUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler {
	[self fetchPostsStarredByUserWithID:user.userID completion:completionHandler];
}


- (void)fetchPostsStarredByUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"posts/%@/stars", userID]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKPost class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/lifecycle/#create-a-post

- (void)createPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler {
	[self postPath:@"posts"
		parameters:[post JSONDictionary]
		   success:[self successHandlerForResourceClass:[ANKPost class] clientHandler:completionHandler]
		   failure:[self failureHandlerForClientHandler:completionHandler]];
}


- (void)createPostWithText:(NSString *)text completion:(ANKClientCompletionBlock)completionHandler {
	[self createPostWithText:text inReplyToPostWithID:nil completion:completionHandler];
}


- (void)createPostWithText:(NSString *)text inReplyToPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler {
	[self createPostWithText:text inReplyToPostWithID:post.postID completion:completionHandler];
}


- (void)createPostWithText:(NSString *)text inReplyToPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler {
	[self postPath:@"posts"
		parameters:(postID ? @{@"text": text, @"reply_to": postID} : @{@"text": text})
		   success:[self successHandlerForResourceClass:[ANKPost class] clientHandler:completionHandler]
		   failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/lifecycle/#delete-a-post

- (void)deletePost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler {
	[self deletePostWithID:post.postID completion:completionHandler];
}


- (void)deletePostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler {
	[self deletePath:[NSString stringWithFormat:@"posts/%@", postID]
		  parameters:nil
			 success:[self successHandlerForResourceClass:[ANKPost class] clientHandler:completionHandler]
			 failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/reposts/#repost-a-post

- (void)repostPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler {
	[self repostPostWithID:post.postID completion:completionHandler];
}


- (void)repostPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler {
	[self postPath:[NSString stringWithFormat:@"posts/%@/repost", postID]
		parameters:nil
		   success:[self successHandlerForResourceClass:[ANKPost class] clientHandler:completionHandler]
		   failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/reposts/#unrepost-a-post

- (void)unrepostPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler {
	[self unrepostPostWithID:post.postID completion:completionHandler];
}


- (void)unrepostPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler {
	[self deletePath:[NSString stringWithFormat:@"posts/%@/repost", postID]
		  parameters:nil
			 success:[self successHandlerForResourceClass:[ANKPost class] clientHandler:completionHandler]
			 failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/stars/#star-a-post

- (void)starPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler {
	[self starPostWithID:post.postID completion:completionHandler];
}


- (void)starPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler {
	[self postPath:[NSString stringWithFormat:@"posts/%@/star", postID]
		parameters:nil
		   success:[self successHandlerForResourceClass:[ANKPost class] clientHandler:completionHandler]
		   failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/stars/#unstar-a-post

- (void)unstarPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler {
	[self unstarPostWithID:post.postID completion:completionHandler];
}


- (void)unstarPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler {
	[self deletePath:[NSString stringWithFormat:@"posts/%@/star", postID]
		  parameters:nil
			 success:[self successHandlerForResourceClass:[ANKPost class] clientHandler:completionHandler]
			 failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/report/#report-a-post

- (void)reportPostAsSpam:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler {
	[self reportPostWithIDAsSpam:post.postID completion:completionHandler];
}


- (void)reportPostWithIDAsSpam:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler {
	[self postPath:[NSString stringWithFormat:@"posts/%@/report", postID]
		parameters:nil
		   success:[self successHandlerForResourceClass:[ANKPost class] clientHandler:completionHandler]
		   failure:[self failureHandlerForClientHandler:completionHandler]];
}


@end
