//
//  ADNClient+ADNPost.h
//  ADNKit
//
//  Created by Joel Levin on 3/5/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKClient+ANKHandlerBlocks.h"


@class ANKPost, ANKUser;

@interface ANKClient (ANKPost)

- (void)fetchPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchPostsWithIDs:(NSArray *)postIDs completion:(ANKClientCompletionBlock)completionHandler;

- (void)fetchRepliesToPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchRepliesToPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler;

- (void)fetchPostsStarredByUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchPostsStarredByUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;

- (void)createPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler;
- (void)createPostWithText:(NSString *)text completion:(ANKClientCompletionBlock)completionHandler;
- (void)createPostWithText:(NSString *)text inReplyToPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler;
- (void)createPostWithText:(NSString *)text inReplyToPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler;
- (void)deletePost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler;
- (void)deletePostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler;

- (void)repostPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler;
- (void)repostPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler;
- (void)unrepostPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler;
- (void)unrepostPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler;

- (void)starPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler;
- (void)starPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler;
- (void)unstarPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler;
- (void)unstarPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler;

- (void)reportPostAsSpam:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler;
- (void)reportPostWithIDAsSpam:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler;

@end
