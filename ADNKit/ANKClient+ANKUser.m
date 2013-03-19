/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ANKClient+ANKUser.h"
#import "ANKUser.h"
#import "ANKPost.h"


@interface ANKClient (ANKUserPrivate)

- (NSString *)endpointPathForUserID:(NSString *)userID endpoint:(NSString *)endpoint;
- (ANKUser *)userForID:(NSString *)userID;

@end


@implementation ANKClient (ANKUser)

- (NSString *)endpointPathForUserID:(NSString *)userID endpoint:(NSString *)endpoint {
	return [NSString stringWithFormat:@"users/%@%@%@", userID, endpoint != nil ? @"/" : @"", endpoint ?: @""];
}


- (ANKUser *)userForID:(NSString *)userID {
	ANKUser *user = [[ANKUser alloc] init];
	user.userID = userID;
	return user;
}


// GET /stream/0/users/[user_id]
// http://developers.app.net/docs/resources/user/lookup/#retrieve-a-user

- (void)fetchCurrentUserWithCompletion:(ANKClientCompletionBlock)completionHandler {
	[self fetchUserWithID:@"me" completion:completionHandler];
}


- (void)fetchUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:[self endpointPathForUserID:userID endpoint:nil]
	   parameters:nil
		  success:[self successHandlerForResourceClass:[ANKUser class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// PUT /stream/0/users/me
// http://developers.app.net/docs/resources/user/profile/#update-a-user

- (void)updateCurrentUser:(ANKUser *)user fullName:(NSString *)fullName descriptionText:(NSString *)descriptionText completion:(ANKClientCompletionBlock)completionHandler {
	[self updateCurrentUserName:fullName locale:user.locale timezone:user.timezone descriptionText:descriptionText completion:completionHandler];
}


- (void)updateCurrentUserName:(NSString *)fullName locale:(NSString *)locale timezone:(NSString *)timezone descriptionText:(NSString *)descriptionText completion:(ANKClientCompletionBlock)completionHander {
	[self putPath:@"users/me"
	   parameters:@{@"name": fullName, @"locale": locale, @"timezone": timezone, @"description": @{@"text": descriptionText}}
		  success:[self successHandlerForResourceClass:[ANKUser class] clientHandler:completionHander]
		  failure:[self failureHandlerForClientHandler:completionHander]];
}


// GET /stream/0/users/[user_id]/avatar
// http://developers.app.net/docs/resources/user/profile/#retrieve-a-users-avatar-image

- (void)fetchAvatarImageURLForUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	NSURLRequest *URLRequest = [self requestWithMethod:@"HEAD" path:[self endpointPathForUserID:userID endpoint:@"avatar"] parameters:nil];
	AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:URLRequest];
	[requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		if (completionHandler) {
			completionHandler([operation.response URL], nil, nil);
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if (completionHandler) {
			completionHandler(nil, nil, error);
		}
	}];
	[self enqueueHTTPRequestOperation:requestOperation];
}


// POST /stream/0/users/me/avatar
// http://developers.app.net/docs/resources/user/profile/#update-a-users-avatar-image

- (void)updateCurrentUserAvatarWithImageData:(NSData *)imageData mimeType:(NSString *)mimeType completion:(ANKClientCompletionBlock)completionHandler {
	NSURLRequest *URLRequest = [self multipartFormRequestWithMethod:@"POST" path:[self endpointPathForUserID:@"me" endpoint:@"avatar"] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
		[formData appendPartWithFileData:imageData name:@"avatar" fileName:@"avatar" mimeType:mimeType];
	}];
	AFHTTPRequestOperation *requestOperation = [self HTTPRequestOperationWithRequest:URLRequest
																			 success:[self successHandlerForResourceClass:[ANKUser class] clientHandler:completionHandler]
																			 failure:[self failureHandlerForClientHandler:completionHandler]];
	[self enqueueHTTPRequestOperation:requestOperation];
}


// GET /stream/0/users/[user_id]/cover
// http://developers.app.net/docs/resources/user/profile/#retrieve-a-users-cover-image

- (void)fetchCoverImageURLForUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	NSURLRequest *URLRequest = [self requestWithMethod:@"HEAD" path:[self endpointPathForUserID:userID endpoint:@"cover"] parameters:nil];
	AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:URLRequest];
	[requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		if (completionHandler) {
			completionHandler([operation.response URL], nil, nil);
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if (completionHandler) {
			completionHandler(nil, nil, error);
		}
	}];
	[self enqueueHTTPRequestOperation:requestOperation];
}


// POST /stream/0/users/[user_id]/follow
// http://developers.app.net/docs/resources/user/following/#follow-a-user

- (void)followUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler {
	[self followUserWithID:user.userID completion:completionHandler];
}


- (void)followUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	[self postPath:[self endpointPathForUserID:userID endpoint:@"follow"]
		parameters:nil
		   success:[self successHandlerForResourceClass:[ANKUser class] clientHandler:completionHandler]
		   failure:[self failureHandlerForClientHandler:completionHandler]];
}


// DELETE /stream/0/users/[user_id]/follow
// http://developers.app.net/docs/resources/user/following/#unfollow-a-user

- (void)unfollowUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler {
	[self unfollowUserWithID:user.userID completion:completionHandler];
}


- (void)unfollowUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	[self deletePath:[self endpointPathForUserID:userID endpoint:@"follow"]
		  parameters:nil
			 success:[self successHandlerForResourceClass:[ANKUser class] clientHandler:completionHandler]
			 failure:[self failureHandlerForClientHandler:completionHandler]];
}


// POST /stream/0/users/[user_id]/mute
// http://developers.app.net/docs/resources/user/muting/#mute-a-user

- (void)muteUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler {
	[self muteUserWithID:user.userID completion:completionHandler];
}


- (void)muteUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	[self postPath:[self endpointPathForUserID:userID endpoint:@"mute"]
		parameters:nil
		   success:[self successHandlerForResourceClass:[ANKUser class] clientHandler:completionHandler]
		   failure:[self failureHandlerForClientHandler:completionHandler]];
}


// DELETE /stream/0/users/[user_id]/mute
// http://developers.app.net/docs/resources/user/muting/#unmute-a-user

- (void)unmuteUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler {
	[self unmuteUserWithID:user.userID completion:completionHandler];
}


- (void)unmuteUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	[self deletePath:[self endpointPathForUserID:userID endpoint:@"mute"]
		  parameters:nil
			 success:[self successHandlerForResourceClass:[ANKUser class] clientHandler:completionHandler]
			 failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/users
// http://developers.app.net/docs/resources/user/lookup/#retrieve-multiple-users

- (void)fetchUsersWithIDs:(NSArray *)userIDs completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:@"users"
	   parameters:@{@"ids": [userIDs componentsJoinedByString:@","]}
		  success:[self successHandlerForCollectionOfResourceClass:[ANKUser class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/users/search
// http://developers.app.net/docs/resources/user/lookup/#search-for-users

- (void)searchForUsersWithQuery:(NSString *)query completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:@"users/search"
	   parameters:@{@"q": query}
		  success:[self successHandlerForCollectionOfResourceClass:[ANKUser class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/users/[user_id]/following
// http://developers.app.net/docs/resources/user/following/#list-users-a-user-is-following

- (void)fetchUsersUserFollowing:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler {
	[self fetchUsersUserWithIDFollowing:user.userID completion:completionHandler];
}


- (void)fetchUsersUserWithIDFollowing:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:[self endpointPathForUserID:userID endpoint:@"following"]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKUser class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/users/[user_id]/followers
// http://developers.app.net/docs/resources/user/following/#list-users-following-a-user

- (void)fetchUsersFollowingUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler {
	[self fetchUsersFollowingUserWithID:user.userID completion:completionHandler];
}


- (void)fetchUsersFollowingUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:[self endpointPathForUserID:userID endpoint:@"followers"]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKUser class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/users/[user_id]/following/ids
// http://developers.app.net/docs/resources/user/following/#list-user-ids-a-user-is-following

- (void)fetchUserIDsUserFollowing:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler {
	[self fetchUserIDsUserWithIDFollowing:user.userID completion:completionHandler];
}


- (void)fetchUserIDsUserWithIDFollowing:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:[self endpointPathForUserID:userID endpoint:@"following/ids"]
	   parameters:nil
		  success:[self successHandlerForPrimitiveResponseWithClientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/users/[user_id]/followers/ids
// http://developers.app.net/docs/resources/user/following/#list-user-ids-following-a-user

- (void)fetchUserIDsFollowingUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler {
	[self fetchUserIDsFollowingUserWithID:user.userID completion:completionHandler];
}


- (void)fetchUserIDsFollowingUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:[self endpointPathForUserID:userID endpoint:@"followers/ids"]
	   parameters:nil
		  success:[self successHandlerForPrimitiveResponseWithClientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/users/[user_id]/muted
// http://developers.app.net/docs/resources/user/muting/#list-muted-users

- (void)fetchMutedUsersForUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler {
	[self fetchMutedUsersForUserWithID:user.userID completion:completionHandler];
}


- (void)fetchMutedUsersForUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:[self endpointPathForUserID:userID endpoint:completionHandler]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKUser class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/users/[user_id]/muted
// http://developers.app.net/docs/resources/user/muting/#retrieve-muted-user-ids-for-multiple-users

- (void)fetchMutedUserIDsForUsers:(NSArray *)users completion:(ANKClientCompletionBlock)completionHandler {
	[self fetchMutedUserIDsForUserIDs:[users valueForKeyPath:@"userID"] completion:completionHandler];
}


- (void)fetchMutedUserIDsForUserIDs:(NSArray *)userIDs completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:@"muted/ids"
	   parameters:@{@"ids": [userIDs componentsJoinedByString:@","]}
		  success:[self successHandlerForPrimitiveResponseWithClientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/posts/[post_id]/reposters
// http://developers.app.net/docs/resources/user/post-interactions/#list-users-who-have-reposted-a-post

- (void)fetchUsersRepostedForPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler {
	[self fetchUsersRepostedForPostWithID:post.postID completion:completionHandler];
}


- (void)fetchUsersRepostedForPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"posts/%@/reposters", postID]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKUser class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/posts/[post_id]/stars
// http://developers.app.net/docs/resources/user/post-interactions/#list-users-who-have-starred-a-post

- (void)fetchUsersStarredForPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler {
	[self fetchUsersStarredForPostWithID:post.postID completion:completionHandler];
}


- (void)fetchUsersStarredForPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"posts/%@/stars", postID]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKUser class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


@end
