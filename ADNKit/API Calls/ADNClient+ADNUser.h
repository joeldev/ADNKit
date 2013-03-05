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
// http://developers.app.net/docs/resources/user/profile/#update-a-user

- (void)updateCurrentUser:(ADNUser *)user fullName:(NSString *)fullName descriptionText:(NSString *)descriptionText completion:(ADNClientCompletionBlock)completionHandler;
- (void)updateCurrentUserName:(NSString *)fullName locale:(NSString *)locale timezone:(NSString *)timezone descriptionText:(NSString *)descriptionText completion:(ADNClientCompletionBlock)completionHander;

// GET /stream/0/users/[user_id]/avatar
// http://developers.app.net/docs/resources/user/profile/#retrieve-a-users-avatar-image

- (void)fetchCurrentUserAvatarWithCompletionBlock:(ADNClientCompletionBlock)completionBlock;

// POST /stream/0/users/me/avatar
// http://developers.app.net/docs/resources/user/profile/#update-a-users-avatar-image

- (void)updateCurrentUserAvatarWithImageData:(NSData *)imageData completion:(ADNClientCompletionBlock)completionHandler;
- (void)updateCurrentUserAvatarWithImageAtURL:(NSURL *)URL completion:(ADNClientCompletionBlock)completionHandler;

// GET /stream/0/users/[user_id]/cover
// http://developers.app.net/docs/resources/user/profile/#retrieve-a-users-cover-image

- (void)fetchCurrentUserCoverImageWithCompletionBlock:(ADNClientCompletionBlock)completionBlock;

// POST /stream/0/users/[user_id]/follow
// http://developers.app.net/docs/resources/user/following/#follow-a-user

- (void)followUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)followUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

// DELETE /stream/0/users/[user_id]/follow
// http://developers.app.net/docs/resources/user/following/#unfollow-a-user

- (void)unfollowUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)unfollowUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

// POST /stream/0/users/[user_id]/mute
// http://developers.app.net/docs/resources/user/muting/#mute-a-user

- (void)muteUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)muteUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

// DELETE /stream/0/users/[user_id]/mute
// http://developers.app.net/docs/resources/user/muting/#unmute-a-user

- (void)unmuteUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)unmuteUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

// GET /stream/0/users
// http://developers.app.net/docs/resources/user/lookup/#retrieve-multiple-users

- (void)fetchUsersWithIDs:(NSArray *)userIDs completion:(ADNClientCompletionBlock)completionHandler;

// GET /stream/0/users/search
// http://developers.app.net/docs/resources/user/lookup/#search-for-users

- (void)searchForUsersWithQuery:(NSString *)query completion:(ADNClientCompletionBlock)completionHandler;

// GET /stream/0/users/[user_id]/following
// http://developers.app.net/docs/resources/user/following/#list-users-a-user-is-following

- (void)fetchUsersUserFollowing:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUsersUserWithIDFollowing:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

// GET /stream/0/users/[user_id]/followers
// http://developers.app.net/docs/resources/user/following/#list-users-following-a-user

- (void)fetchUsersFollowingUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUsersFollowingUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

// GET /stream/0/users/[user_id]/following/ids
// http://developers.app.net/docs/resources/user/following/#list-user-ids-a-user-is-following

- (void)fetchUserIDsUserFollowing:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUserIDsUserWithIDFollowing:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

// GET /stream/0/users/[user_id]/followers/ids
// http://developers.app.net/docs/resources/user/following/#list-user-ids-following-a-user

- (void)fetchUserIDsFollowingUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUserIDsFollowingUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

// GET /stream/0/users/[user_id]/muted
// http://developers.app.net/docs/resources/user/muting/#list-muted-users

- (void)fetchMutedUsersForUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchMutedUsersForUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

// GET /stream/0/users/muted/ids
// http://developers.app.net/docs/resources/user/muting/#retrieve-muted-user-ids-for-multiple-users

- (void)fetchMutedUserIDsForUsers:(NSArray *)users completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchMutedUserIDsForUserIDs:(NSArray *)userIDs completion:(ADNClientCompletionBlock)completionHandler;

// GET /stream/0/posts/[post_id]/reposters
// http://developers.app.net/docs/resources/user/post-interactions/#list-users-who-have-reposted-a-post

- (void)fetchUsersRepostedForPost:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUsersRepostedForPostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler;

// GET /stream/0/posts/[post_id]/stars
// http://developers.app.net/docs/resources/user/post-interactions/#list-users-who-have-starred-a-post

- (void)fetchUsersStarredForPost:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUsersStarredForPostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler;

@end
