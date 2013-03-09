//
//  ADNClient+ADNUser.h
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

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

@end
