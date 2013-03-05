//
//  ADNClient+ADNUser.m
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNClient+ADNUser.h"
#import "ADNUser.h"
#import "ADNPost.h"


@interface ADNClient (ADNUserPrivate)

- (NSString *)endpointPathForUserID:(NSString *)userID endpoint:(NSString *)endpoint;
- (ADNUser *)userForID:(NSString *)userID;

@end


@implementation ADNClient (ADNUser)

- (NSString *)endpointPathForUserID:(NSString *)userID endpoint:(NSString *)endpoint {
	return [NSString stringWithFormat:@"users/%@%@%@", userID, endpoint != nil ? @"/" : @"", endpoint ?: @""];
}


- (ADNUser *)userForID:(NSString *)userID {
	ADNUser *user = [[ADNUser alloc] init];
	user.userID = userID;
	return user;
}


// GET /stream/0/users/[user_id]
// http://developers.app.net/docs/resources/user/lookup/#retrieve-a-user

- (void)fetchCurrentUserWithCompletion:(ADNClientCompletionBlock)completionHandler {
	[self fetchUserWithID:@"me" completion:completionHandler];
}


- (void)fetchUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:[self endpointPathForUserID:userID endpoint:nil]
	   parameters:nil
		  success:[self successHandlerForResourceClass:[ADNUser class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// PUT /stream/0/users/me
// http://developers.app.net/docs/resources/user/profile/#update-a-user

- (void)updateCurrentUser:(ADNUser *)user fullName:(NSString *)fullName descriptionText:(NSString *)descriptionText completion:(ADNClientCompletionBlock)completionHandler {
	[self updateCurrentUserName:fullName locale:user.locale timezone:user.timezone descriptionText:descriptionText completion:completionHandler];
}


- (void)updateCurrentUserName:(NSString *)fullName locale:(NSString *)locale timezone:(NSString *)timezone descriptionText:(NSString *)descriptionText completion:(ADNClientCompletionBlock)completionHander {
	[self putPath:@"users/me"
	   parameters:@{@"name": fullName, @"locale": locale, @"timezone": timezone, @"description": @{@"text": descriptionText}}
		  success:[self successHandlerForResourceClass:[ADNUser class] clientHandler:completionHander]
		  failure:[self failureHandlerForClientHandler:completionHander]];
}


// GET /stream/0/users/[user_id]/avatar
// http://developers.app.net/docs/resources/user/profile/#retrieve-a-users-avatar-image

- (void)fetchAvatarImageURLForUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


// POST /stream/0/users/me/avatar
// http://developers.app.net/docs/resources/user/profile/#update-a-users-avatar-image

- (void)updateCurrentUserAvatarWithImageData:(NSData *)imageData mimeType:(NSString *)mimeType completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


// GET /stream/0/users/[user_id]/cover
// http://developers.app.net/docs/resources/user/profile/#retrieve-a-users-cover-image

- (void)fetchCoverImageURLForUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


// POST /stream/0/users/[user_id]/follow
// http://developers.app.net/docs/resources/user/following/#follow-a-user

- (void)followUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler {
	[self followUserWithID:user.userID completion:completionHandler];
}


- (void)followUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler {
	[self postPath:[self endpointPathForUserID:userID endpoint:@"follow"]
		parameters:nil
		   success:[self successHandlerForResourceClass:[ADNUser class] clientHandler:completionHandler]
		   failure:[self failureHandlerForClientHandler:completionHandler]];
}


// DELETE /stream/0/users/[user_id]/follow
// http://developers.app.net/docs/resources/user/following/#unfollow-a-user

- (void)unfollowUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler {
	[self unfollowUserWithID:user.userID completion:completionHandler];
}


- (void)unfollowUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler {
	[self deletePath:[self endpointPathForUserID:userID endpoint:@"follow"]
		  parameters:nil
			 success:[self successHandlerForResourceClass:[ADNUser class] clientHandler:completionHandler]
			 failure:[self failureHandlerForClientHandler:completionHandler]];
}


// POST /stream/0/users/[user_id]/mute
// http://developers.app.net/docs/resources/user/muting/#mute-a-user

- (void)muteUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler {
	[self muteUserWithID:user.userID completion:completionHandler];
}


- (void)muteUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler {
	[self postPath:[self endpointPathForUserID:userID endpoint:@"mute"]
		parameters:nil
		   success:[self successHandlerForResourceClass:[ADNUser class] clientHandler:completionHandler]
		   failure:[self failureHandlerForClientHandler:completionHandler]];
}


// DELETE /stream/0/users/[user_id]/mute
// http://developers.app.net/docs/resources/user/muting/#unmute-a-user

- (void)unmuteUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler {
	[self unmuteUserWithID:user.userID completion:completionHandler];
}


- (void)unmuteUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler {
	[self deletePath:[self endpointPathForUserID:userID endpoint:@"mute"]
		  parameters:nil
			 success:[self successHandlerForResourceClass:[ADNUser class] clientHandler:completionHandler]
			 failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/users
// http://developers.app.net/docs/resources/user/lookup/#retrieve-multiple-users

- (void)fetchUsersWithIDs:(NSArray *)userIDs completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:@"users"
	   parameters:@{@"ids": [userIDs componentsJoinedByString:@","]}
		  success:[self successHandlerForCollectionOfResourceClass:[ADNUser class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/users/search
// http://developers.app.net/docs/resources/user/lookup/#search-for-users

- (void)searchForUsersWithQuery:(NSString *)query completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:@"users/search"
	   parameters:@{@"q": query}
		  success:[self successHandlerForCollectionOfResourceClass:[ADNUser class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/users/[user_id]/following
// http://developers.app.net/docs/resources/user/following/#list-users-a-user-is-following

- (void)fetchUsersUserFollowing:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler {
	[self fetchUsersUserWithIDFollowing:user.userID completion:completionHandler];
}


- (void)fetchUsersUserWithIDFollowing:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:[self endpointPathForUserID:userID endpoint:@"following"]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ADNUser class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/users/[user_id]/followers
// http://developers.app.net/docs/resources/user/following/#list-users-following-a-user

- (void)fetchUsersFollowingUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler {
	[self fetchUsersFollowingUserWithID:user.userID completion:completionHandler];
}


- (void)fetchUsersFollowingUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:[self endpointPathForUserID:userID endpoint:@"followers"]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ADNUser class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/users/[user_id]/following/ids
// http://developers.app.net/docs/resources/user/following/#list-user-ids-a-user-is-following

- (void)fetchUserIDsUserFollowing:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler {
	[self fetchUserIDsUserWithIDFollowing:user.userID completion:completionHandler];
}


- (void)fetchUserIDsUserWithIDFollowing:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:[self endpointPathForUserID:userID endpoint:@"following/ids"]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ADNUser class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/users/[user_id]/followers/ids
// http://developers.app.net/docs/resources/user/following/#list-user-ids-following-a-user

- (void)fetchUserIDsFollowingUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler {
	[self fetchUserIDsFollowingUserWithID:user.userID completion:completionHandler];
}


- (void)fetchUserIDsFollowingUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:[self endpointPathForUserID:userID endpoint:@"followers/ids"]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ADNUser class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/users/[user_id]/muted
// http://developers.app.net/docs/resources/user/muting/#list-muted-users

- (void)fetchMutedUsersForUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler {
	[self fetchMutedUsersForUserWithID:user.userID completion:completionHandler];
}


- (void)fetchMutedUsersForUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:[self endpointPathForUserID:userID endpoint:completionHandler]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ADNUser class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/users/[user_id]/muted
// http://developers.app.net/docs/resources/user/muting/#retrieve-muted-user-ids-for-multiple-users

- (void)fetchMutedUserIDsForUsers:(NSArray *)users completion:(ADNClientCompletionBlock)completionHandler {
	[self fetchMutedUserIDsForUserIDs:[users valueForKeyPath:@"userID"] completion:completionHandler];
}


- (void)fetchMutedUserIDsForUserIDs:(NSArray *)userIDs completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:@"muted/ids"
	   parameters:@{@"ids": [userIDs componentsJoinedByString:@","]}
		  success:[self successHandlerForCollectionOfResourceClass:[ADNUser class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/posts/[post_id]/reposters
// http://developers.app.net/docs/resources/user/post-interactions/#list-users-who-have-reposted-a-post

- (void)fetchUsersRepostedForPost:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler {
	[self fetchUsersRepostedForPostWithID:post.postID completion:completionHandler];
}


- (void)fetchUsersRepostedForPostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"posts/%@/reposters", postID]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ADNUser class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/posts/[post_id]/stars
// http://developers.app.net/docs/resources/user/post-interactions/#list-users-who-have-starred-a-post

- (void)fetchUsersStarredForPost:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler {
	[self fetchUsersStarredForPostWithID:post.postID completion:completionHandler];
}


- (void)fetchUsersStarredForPostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"posts/%@/stars", postID]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ADNUser class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


@end
