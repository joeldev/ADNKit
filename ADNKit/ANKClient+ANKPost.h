/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ANKClient+ANKHandlerBlocks.h"


@class ANKPost, ANKSearchQuery, ANKUser;

@interface ANKClient (ANKPost)

- (AFHTTPRequestOperation *)fetchPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchPostsWithIDs:(NSArray *)postIDs completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)fetchRepliesToPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchRepliesToPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)fetchPostsStarredByUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchPostsStarredByUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)createPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)createPostWithText:(NSString *)text completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)createPostWithText:(NSString *)text inReplyToPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)createPostWithText:(NSString *)text inReplyToPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)deletePost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)deletePostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)repostPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)repostPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)unrepostPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)unrepostPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)starPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)starPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)unstarPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)unstarPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)reportPostAsSpam:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)reportPostWithIDAsSpam:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)searchForPostsWithQuery:(ANKSearchQuery *)query completion:(ANKClientCompletionBlock)completionHandler;

@end
