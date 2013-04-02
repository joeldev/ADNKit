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

- (void)fetchCurrentUserWithCompletion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchUsersWithIDs:(NSArray *)userIDs completion:(ANKClientCompletionBlock)completionHandler;
- (void)searchForUsersWithQuery:(NSString *)query completion:(ANKClientCompletionBlock)completionHandler;

- (void)fetchAvatarImageURLForUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchCoverImageURLForUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;

- (void)fetchUsersUserFollowing:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchUsersUserWithIDFollowing:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchUsersFollowingUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchUsersFollowingUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;

- (void)fetchUserIDsUserFollowing:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchUserIDsUserWithIDFollowing:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchUserIDsFollowingUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchUserIDsFollowingUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;

- (void)fetchMutedUsersForUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchMutedUsersForUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchMutedUserIDsForUsers:(NSArray *)users completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchMutedUserIDsForUserIDs:(NSArray *)userIDs completion:(ANKClientCompletionBlock)completionHandler;

- (void)fetchBlockedUsersForUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchBlockedUsersForUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchBlockedUsersForUsers:(NSArray *)users completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchBlockedUsersForUserIDs:(NSArray *)users completion:(ANKClientCompletionBlock)completionHandler;

- (void)fetchUsersRepostedForPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchUsersRepostedForPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchUsersStarredForPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchUsersStarredForPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler;

- (void)updateCurrentUser:(ANKUser *)user fullName:(NSString *)fullName descriptionText:(NSString *)descriptionText completion:(ANKClientCompletionBlock)completionHandler;
- (void)updateCurrentUserName:(NSString *)fullName locale:(NSString *)locale timezone:(NSString *)timezone descriptionText:(NSString *)descriptionText completion:(ANKClientCompletionBlock)completionHander;
- (void)updateCurrentUserAvatarWithImageData:(NSData *)imageData mimeType:(NSString *)mimeType completion:(ANKClientCompletionBlock)completionHandler;

- (void)followUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (void)followUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;
- (void)unfollowUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (void)unfollowUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;

- (void)muteUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (void)muteUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;
- (void)unmuteUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (void)unmuteUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;

- (void)blockUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (void)blockUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;
- (void)unblockUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (void)unblockUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;

@end
