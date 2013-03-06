//
//  ADNClient+ADNUser.h
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNClient.h"


@class ADNUser, ADNPost;

@interface ADNClient (ADNUser)

- (void)fetchCurrentUserWithCompletion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUsersWithIDs:(NSArray *)userIDs completion:(ADNClientCompletionBlock)completionHandler;
- (void)searchForUsersWithQuery:(NSString *)query completion:(ADNClientCompletionBlock)completionHandler;

- (void)fetchAvatarImageURLForUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchCoverImageURLForUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

- (void)fetchUsersUserFollowing:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUsersUserWithIDFollowing:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUsersFollowingUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUsersFollowingUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

- (void)fetchUserIDsUserFollowing:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUserIDsUserWithIDFollowing:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUserIDsFollowingUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUserIDsFollowingUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

- (void)fetchMutedUsersForUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchMutedUsersForUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchMutedUserIDsForUsers:(NSArray *)users completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchMutedUserIDsForUserIDs:(NSArray *)userIDs completion:(ADNClientCompletionBlock)completionHandler;

- (void)fetchUsersRepostedForPost:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUsersRepostedForPostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUsersStarredForPost:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUsersStarredForPostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler;

- (void)updateCurrentUser:(ADNUser *)user fullName:(NSString *)fullName descriptionText:(NSString *)descriptionText completion:(ADNClientCompletionBlock)completionHandler;
- (void)updateCurrentUserName:(NSString *)fullName locale:(NSString *)locale timezone:(NSString *)timezone descriptionText:(NSString *)descriptionText completion:(ADNClientCompletionBlock)completionHander;
- (void)updateCurrentUserAvatarWithImageData:(NSData *)imageData mimeType:(NSString *)mimeType completion:(ADNClientCompletionBlock)completionHandler;

- (void)followUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)followUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;
- (void)unfollowUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)unfollowUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

- (void)muteUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)muteUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;
- (void)unmuteUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)unmuteUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

@end
