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

- (ANKJSONRequestOperation *)fetchCurrentUserWithCompletion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)fetchUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)fetchUsersWithIDs:(NSArray *)userIDs completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)searchForUsersWithQuery:(NSString *)query completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)fetchAvatarImageURLForUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchCoverImageURLForUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;

- (ANKJSONRequestOperation *)fetchUsersUserFollowing:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)fetchUsersUserWithIDFollowing:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)fetchUsersFollowingUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)fetchUsersFollowingUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;

- (ANKJSONRequestOperation *)fetchUserIDsUserFollowing:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)fetchUserIDsUserWithIDFollowing:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)fetchUserIDsFollowingUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)fetchUserIDsFollowingUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;

- (ANKJSONRequestOperation *)fetchMutedUsersForUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)fetchMutedUsersForUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)fetchMutedUserIDsForUsers:(NSArray *)users completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)fetchMutedUserIDsForUserIDs:(NSArray *)userIDs completion:(ANKClientCompletionBlock)completionHandler;

- (ANKJSONRequestOperation *)fetchBlockedUsersForUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)fetchBlockedUsersForUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)fetchBlockedUsersForUsers:(NSArray *)users completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)fetchBlockedUsersForUserIDs:(NSArray *)users completion:(ANKClientCompletionBlock)completionHandler;

- (ANKJSONRequestOperation *)fetchUsersRepostedForPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)fetchUsersRepostedForPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)fetchUsersStarredForPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)fetchUsersStarredForPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler;

- (ANKJSONRequestOperation *)updateCurrentUser:(ANKUser *)user fullName:(NSString *)fullName descriptionText:(NSString *)descriptionText completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)updateCurrentUserName:(NSString *)fullName locale:(NSString *)locale timezone:(NSString *)timezone descriptionText:(NSString *)descriptionText completion:(ANKClientCompletionBlock)completionHander;
- (ANKJSONRequestOperation *)updateCurrentUserAvatarWithImageData:(NSData *)imageData mimeType:(NSString *)mimeType completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)updateCurrentUserCoverImageWithImageData:(NSData *)imageData mimeType:(NSString *)mimeType completion:(ANKClientCompletionBlock)completionHandler;

- (ANKJSONRequestOperation *)followUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)followUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)unfollowUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)unfollowUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;

- (ANKJSONRequestOperation *)muteUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)muteUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)unmuteUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)unmuteUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;

- (ANKJSONRequestOperation *)blockUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)blockUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)unblockUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)unblockUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;

@end
