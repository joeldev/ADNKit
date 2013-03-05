//
//  ADNClient+ADNUser.m
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNClient+ADNUser.h"
#import "ADNUser.h"


@interface ADNClient (ADNUserPrivate)

- (NSString *)endpointPathForUserID:(NSString *)userID endpoint:(NSString *)endpoint;
- (ADNUser *)userForID:(NSString *)userID;

@end


@implementation ADNClient (ADNUser)

- (NSString *)endpointPathForUserID:(NSString *)userID endpoint:(NSString *)endpoint {
	return [NSString stringWithFormat:@"users/%@%@%@", userID, endpoint != nil ? @"/" : @"", endpoint];
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
// TODO: link

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
// TODO: link

- (void)fetchCurrentUserAvatarWithCompletionBlock:(ADNClientCompletionBlock)completionBlock {
	#warning missing API call
}


// POST /stream/0/users/me/avatar
// TODO: link

- (void)updateCurrentUserAvatarWithImageData:(NSData *)imageData completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


- (void)updateCurrentUserAvatarWithImageAtURL:(NSURL *)URL completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


// GET /stream/0/users/[user_id]/cover
// TODO: link

- (void)fetchCurrentUserCoverImageWithCompletionBlock:(ADNClientCompletionBlock)completionBlock {
	#warning missing API call
}


// POST /stream/0/users/[user_id]/follow
// TODO: link

- (void)followUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


- (void)followUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


// DELETE /stream/0/users/[user_id]/follow
// TODO: link

- (void)unfollowUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


- (void)unfollowUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


// POST /stream/0/users/[user_id]/mute
// TODO: link

- (void)muteUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


- (void)muteUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


// DELETE /stream/0/users/[user_id]/mute
// TODO: link

- (void)unmuteUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


- (void)unmuteUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


// GET /stream/0/users
// TODO: link

- (void)fetchUsersWithIDs:(NSArray *)userIDs completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


// GET /stream/0/users/search
// TODO: link

- (void)searchForUsersWithQuery:(NSString *)query completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


// GET /stream/0/users/[user_id]/following
// TODO: link

- (void)fetchUsersUserFollowing:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


- (void)fetchUsersUserWithIDFollowing:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


// GET /stream/0/users/[user_id]/followers
// TODO: link

- (void)fetchUsersFollowingUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


- (void)fetchUsersFollowingUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


// GET /stream/0/users/[user_id]/following/ids
// TODO: link

- (void)fetchUserIDsUserFollowing:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


- (void)fetchUserIDsUserWithIDFollowing:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


// GET /stream/0/users/[user_id]/followers/ids
// TODO: link

- (void)fetchUserIDsFollowingUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


- (void)fetchUserIDsFollowingUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


// GET /stream/0/users/[user_id]/muted
// TODO: link

- (void)fetchMutedUsersForUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


- (void)fetchMutedUsersForUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


// GET /stream/0/users/muted/ids
// TODO: link

- (void)fetchMutedUserIDsForUsers:(NSArray *)users completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


- (void)fetchMutedUserIDsForUserIDs:(NSArray *)userIDs completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


// GET /stream/0/posts/[post_id]/reposters
// TODO: link

- (void)fetchUsersRepostedForPost:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


- (void)fetchUsersRepostedForPostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


// GET /stream/0/posts/[post_id]/stars
// TODO: link

- (void)fetchUsersStarredForPost:(ADNPost *)post completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


- (void)fetchUsersStarredForPostWithID:(NSString *)postID completion:(ADNClientCompletionBlock)completionHandler {
	#warning missing API call
}


@end
