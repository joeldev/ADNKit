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


@class ANKUser, ANKPost;

@interface ANKClient (ANKUser)

- (AFHTTPRequestOperation *)fetchCurrentUserWithCompletion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchUsersWithIDs:(NSArray *)userIDs completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)searchForUsersWithQuery:(NSString *)query completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)fetchAvatarImageURLForUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchCoverImageURLForUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)fetchUsersUserFollowing:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchUsersUserWithIDFollowing:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchUsersFollowingUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchUsersFollowingUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)fetchUserIDsUserFollowing:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchUserIDsUserWithIDFollowing:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchUserIDsFollowingUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchUserIDsFollowingUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)fetchMutedUsersForUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchMutedUsersForUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchMutedUserIDsForUsers:(NSArray *)users completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchMutedUserIDsForUserIDs:(NSArray *)userIDs completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)fetchBlockedUsersForUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchBlockedUsersForUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchBlockedUsersForUsers:(NSArray *)users completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchBlockedUsersForUserIDs:(NSArray *)users completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)fetchUsersRepostedForPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchUsersRepostedForPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchUsersStarredForPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchUsersStarredForPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)updateCurrentUser:(ANKUser *)user fullName:(NSString *)fullName descriptionText:(NSString *)descriptionText completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)updateCurrentUserName:(NSString *)fullName locale:(NSString *)locale timezone:(NSString *)timezone descriptionText:(NSString *)descriptionText completion:(ANKClientCompletionBlock)completionHander;
- (AFHTTPRequestOperation *)updateCurrentUserAvatarWithImageData:(NSData *)imageData mimeType:(NSString *)mimeType completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)updateCurrentUserCoverImageWithImageData:(NSData *)imageData mimeType:(NSString *)mimeType completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)followUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)followUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)unfollowUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)unfollowUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)muteUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)muteUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)unmuteUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)unmuteUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)blockUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)blockUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)unblockUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)unblockUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;

@end
