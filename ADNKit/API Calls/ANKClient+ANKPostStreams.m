//
//  ADNClient+ADNPostStreams.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/5/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKClient+ANKPostStreams.h"
#import "ANKPost.h"
#import "ANKUser.h"


@implementation ANKClient (ANKPostStreams)

// http://developers.app.net/docs/resources/post/streams/#retrieve-the-global-stream

- (void)fetchGlobalStreamWithCompletion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:@"posts/stream/global"
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKPost class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/streams/#retrieve-tagged-posts

- (void)fetchPostsWithHashtag:(NSString *)hashtag completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"posts/tag/%@", hashtag]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKPost class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/streams/#retrieve-posts-created-by-a-user

- (void)fetchPostsCreatedByUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler {
	[self fetchPostsCreatedByUserWithID:user.userID completion:completionHandler];
}


- (void)fetchPostsCreatedByUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"users/%@/posts", userID]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKPost class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/streams/#retrieve-posts-mentioning-a-user

- (void)fetchPostsMentioningUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler {
	[self fetchPostsMentioningUserWithID:user.userID completion:completionHandler];
}


- (void)fetchPostsMentioningUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"users/%@/mentions", userID]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKPost class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/streams/#retrieve-a-users-personalized-stream

- (void)fetchStreamForCurrentUserWithCompletion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:@"posts/stream"
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKPost class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/post/streams/#retrieve-a-users-unified-stream

- (void)fetchUnifiedStreamForCurrentUserWithCompletion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:@"posts/stream/unified"
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKPost class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


@end
