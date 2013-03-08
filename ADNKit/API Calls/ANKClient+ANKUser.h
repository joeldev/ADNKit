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

- (void)fetchCurrentUserWithCompletion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUsersWithIDs:(NSArray *)userIDs completion:(ADNClientCompletionBlock)completionHandler;
- (void)searchForUsersWithQuery:(NSString *)query completion:(ADNClientCompletionBlock)completionHandler;

- (void)fetchAvatarImageURLForUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchCoverImageURLForUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

- (void)fetchUsersUserFollowing:(ANKUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUsersUserWithIDFollowing:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUsersFollowingUser:(ANKUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUsersFollowingUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

- (void)fetchUserIDsUserFollowing:(ANKUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUserIDsUserWithIDFollowing:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUserIDsFollowingUser:(ANKUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUserIDsFollowingUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

- (void)fetchMutedUsersForUser:(ANKUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchMutedUsersForUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchMutedUserIDsForUsers:(NSArray *)users completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchMutedUserIDsForUserIDs:(NSArray *)userIDs completion:(ADNClientCompletionBlock)completionHandler;

- (void)fetchUsersRepostedForPost:(ANKPost *)post completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUsersRepostedForPostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUsersStarredForPost:(ANKPost *)post completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUsersStarredForPostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler;

- (void)updateCurrentUser:(ANKUser *)user fullName:(NSString *)fullName descriptionText:(NSString *)descriptionText completion:(ADNClientCompletionBlock)completionHandler;
- (void)updateCurrentUserName:(NSString *)fullName locale:(NSString *)locale timezone:(NSString *)timezone descriptionText:(NSString *)descriptionText completion:(ADNClientCompletionBlock)completionHander;
- (void)updateCurrentUserAvatarWithImageData:(NSData *)imageData mimeType:(NSString *)mimeType completion:(ADNClientCompletionBlock)completionHandler;

- (void)followUser:(ANKUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)followUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;
- (void)unfollowUser:(ANKUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)unfollowUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

- (void)muteUser:(ANKUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)muteUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;
- (void)unmuteUser:(ANKUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)unmuteUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

@end
