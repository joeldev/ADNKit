//
//  ADNClient+ADNPost.h
//  ADNKit
//
//  Created by Joel Levin on 3/5/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNClient.h"


@class ADNPost, ADNUser;

@interface ADNClient (ADNPost)

- (void)fetchPostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchPostsWithIDs:(NSArray *)postIDs completion:(ADNClientCompletionBlock)completionHandler;

- (void)fetchRepliesToPost:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchRepliesToPostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler;

- (void)fetchPostsStarredByUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchPostsStarredByUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

- (void)createPost:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler;
- (void)createPostWithText:(NSString *)text completion:(ADNClientCompletionBlock)completionHandler;
- (void)createPostWithText:(NSString *)text inReplyToPost:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler;
- (void)createPostWithText:(NSString *)text inReplyToPostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler;
- (void)deletePost:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler;
- (void)deletePostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler;

- (void)repostPost:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler;
- (void)repostPostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler;
- (void)unrepostPost:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler;
- (void)unrepostPostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler;

- (void)starPost:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler;
- (void)starPostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler;
- (void)unstarPost:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler;
- (void)unstarPostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler;

- (void)reportPostAsSpam:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler;
- (void)reportPostWithIDAsSpam:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler;

@end
