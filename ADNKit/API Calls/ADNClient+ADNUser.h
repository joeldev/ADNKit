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

// GET /stream/0/users/[user_id]
// http://developers.app.net/docs/resources/user/lookup/#retrieve-a-user

- (void)fetchCurrentUserWithCompletion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

// PUT /stream/0/users/me
// TODO: link

- (void)updateCurrentUser:(ADNUser *)user fullName:(NSString *)fullName descriptionText:(NSString *)descriptionText completion:(ADNClientCompletionBlock)completionHandler;
- (void)updateCurrentUserName:(NSString *)fullName locale:(NSString *)locale timezone:(NSString *)timezone descriptionText:(NSString *)descriptionText completion:(ADNClientCompletionBlock)completionHander;

// GET /stream/0/users/[user_id]/avatar
// TODO: link

- (void)fetchCurrentUserAvatarWithCompletionBlock:(ADNClientCompletionBlock)completionBlock;

// POST /stream/0/users/me/avatar
// TODO: link

- (void)updateCurrentUserAvatarWithImageData:(NSData *)imageData completion:(ADNClientCompletionBlock)completionHandler;
- (void)updateCurrentUserAvatarWithImageAtURL:(NSURL *)URL completion:(ADNClientCompletionBlock)completionHandler;

// GET /stream/0/users/[user_id]/cover
// TODO: link

- (void)fetchCurrentUserCoverImageWithCompletionBlock:(ADNClientCompletionBlock)completionBlock;

// POST /stream/0/users/[user_id]/follow
// TODO: link

- (void)followUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)followUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

// DELETE /stream/0/users/[user_id]/follow
// TODO: link

- (void)unfollowUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)unfollowUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

// POST /stream/0/users/[user_id]/mute
// TODO: link

- (void)muteUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)muteUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

// DELETE /stream/0/users/[user_id]/mute
// TODO: link

- (void)unmuteUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)unmuteUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

// GET /stream/0/users
// TODO: link

- (void)fetchUsersWithIDs:(NSArray *)userIDs completion:(ADNClientCompletionBlock)completionHandler;

// GET /stream/0/users/search
// TODO: link

- (void)searchForUsersWithQuery:(NSString *)query completion:(ADNClientCompletionBlock)completionHandler;

// GET /stream/0/users/[user_id]/following
// TODO: link

- (void)fetchUsersUserFollowing:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUsersUserWithIDFollowing:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

// GET /stream/0/users/[user_id]/followers
// TODO: link

- (void)fetchUsersFollowingUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUsersFollowingUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

// GET /stream/0/users/[user_id]/following/ids
// TODO: link

- (void)fetchUserIDsUserFollowing:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUserIDsUserWithIDFollowing:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

// GET /stream/0/users/[user_id]/followers/ids
// TODO: link

- (void)fetchUserIDsFollowingUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUserIDsFollowingUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

// GET /stream/0/users/[user_id]/muted
// TODO: link

- (void)fetchMutedUsersForUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchMutedUsersForUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

// GET /stream/0/users/muted/ids
// TODO: link

- (void)fetchMutedUserIDsForUsers:(NSArray *)users completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchMutedUserIDsForUserIDs:(NSArray *)userIDs completion:(ADNClientCompletionBlock)completionHandler;

// GET /stream/0/posts/[post_id]/reposters
// TODO: link

- (void)fetchUsersRepostedForPost:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUsersRepostedForPostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler;

// GET /stream/0/posts/[post_id]/stars
// TODO: link

- (void)fetchUsersStarredForPost:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUsersStarredForPostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler;

@end
