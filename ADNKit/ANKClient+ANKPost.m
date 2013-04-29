/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

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
	[self getPath:[NSString stringWithFormat:@"users/%@/stars", userID]
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
