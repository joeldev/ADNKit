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
#import "AFHTTPRequestOperation.h"


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

- (AFHTTPRequestOperation *)fetchCurrentUserWithCompletion:(ANKClientCompletionBlock)completionHandler {
	return [self fetchUserWithID:@"me" completion:completionHandler];
}


- (AFHTTPRequestOperation *)fetchUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:[self endpointPathForUserID:userID endpoint:nil]
					 parameters:nil
						success:[self successHandlerForResourceClass:[ANKUser class] clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


// PUT /stream/0/users/me
// http://developers.app.net/docs/resources/user/profile/#update-a-user

- (AFHTTPRequestOperation *)updateCurrentUser:(ANKUser *)user fullName:(NSString *)fullName descriptionText:(NSString *)descriptionText completion:(ANKClientCompletionBlock)completionHandler {
	return [self updateCurrentUserName:fullName locale:user.locale timezone:user.timezone descriptionText:descriptionText completion:completionHandler];
}


- (AFHTTPRequestOperation *)updateCurrentUserName:(NSString *)fullName locale:(NSString *)locale timezone:(NSString *)timezone descriptionText:(NSString *)descriptionText completion:(ANKClientCompletionBlock)completionHander {
	return [self enqueuePUTPath:@"users/me"
					 parameters:@{@"name": fullName, @"locale": locale, @"timezone": timezone, @"description": @{@"text": descriptionText}}
						success:[self successHandlerForResourceClass:[ANKUser class] clientHandler:completionHander]
						failure:[self failureHandlerForClientHandler:completionHander]];
}


// GET /stream/0/users/[user_id]/avatar
// http://developers.app.net/docs/resources/user/profile/#retrieve-a-users-avatar-image

- (AFHTTPRequestOperation *)fetchAvatarImageURLForUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
    return [self.requestManager HEAD:[self endpointPathForUserID:userID endpoint:@"avatar"] parameters:nil success:^(AFHTTPRequestOperation *operation) {
        if (completionHandler) {
            completionHandler([operation.response URL], nil, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completionHandler) {
            completionHandler(nil, nil, error);
        }
    }];
}


// POST /stream/0/users/me/avatar
// http://developers.app.net/docs/resources/user/profile/#update-a-users-avatar-image

- (AFHTTPRequestOperation *)updateCurrentUserAvatarWithImageData:(NSData *)imageData mimeType:(NSString *)mimeType completion:(ANKClientCompletionBlock)completionHandler {
    NSURL *URL = [self.requestManager.baseURL URLByAppendingPathComponent:[self endpointPathForUserID:@"me" endpoint:@"avatar"]];
    NSMutableURLRequest *URLRequest = [self.requestManager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[URL absoluteString] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
		[formData appendPartWithFileData:imageData name:@"avatar" fileName:@"avatar" mimeType:mimeType];
    } error:nil];

	return [self.requestManager HTTPRequestOperationWithRequest:URLRequest
                                                        success:[self successHandlerForResourceClass:[ANKUser class] clientHandler:completionHandler]
                                                        failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/users/[user_id]/cover
// http://developers.app.net/docs/resources/user/profile/#retrieve-a-users-cover-image

- (AFHTTPRequestOperation *)fetchCoverImageURLForUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
    return [self.requestManager HEAD:[self endpointPathForUserID:userID endpoint:@"cover"] parameters:nil success:^(AFHTTPRequestOperation *operation) {
        if (completionHandler) {
            completionHandler([operation.response URL], nil, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completionHandler) {
            completionHandler(nil, nil, error);
        }
    }];
}


// POST /stream/0/users/me/cover
// http://developers.app.net/docs/resources/user/profile/#update-a-users-cover-image

- (AFHTTPRequestOperation *)updateCurrentUserCoverImageWithImageData:(NSData *)imageData mimeType:(NSString *)mimeType completion:(ANKClientCompletionBlock)completionHandler
{
    return [self.requestManager POST:[self endpointPathForUserID:@"me" endpoint:@"cover"] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
               [formData appendPartWithFileData:imageData name:@"cover" fileName:@"cover" mimeType:mimeType];
           } success:[self successHandlerForResourceClass:[ANKUser class] clientHandler:completionHandler]
             failure:[self failureHandlerForClientHandler:completionHandler]];
}


// POST /stream/0/users/[user_id]/follow
// http://developers.app.net/docs/resources/user/following/#follow-a-user

- (AFHTTPRequestOperation *)followUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler {
	return [self followUserWithID:user.userID completion:completionHandler];
}


- (AFHTTPRequestOperation *)followUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueuePOSTPath:[self endpointPathForUserID:userID endpoint:@"follow"]
					  parameters:nil
						 success:[self successHandlerForResourceClass:[ANKUser class] clientHandler:completionHandler]
						 failure:[self failureHandlerForClientHandler:completionHandler]];
}


// DELETE /stream/0/users/[user_id]/follow
// http://developers.app.net/docs/resources/user/following/#unfollow-a-user

- (AFHTTPRequestOperation *)unfollowUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler {
	return [self unfollowUserWithID:user.userID completion:completionHandler];
}


- (AFHTTPRequestOperation *)unfollowUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueDELETEPath:[self endpointPathForUserID:userID endpoint:@"follow"]
						parameters:nil
						   success:[self successHandlerForResourceClass:[ANKUser class] clientHandler:completionHandler]
						   failure:[self failureHandlerForClientHandler:completionHandler]];
}


// POST /stream/0/users/[user_id]/mute
// http://developers.app.net/docs/resources/user/muting/#mute-a-user

- (AFHTTPRequestOperation *)muteUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler {
	return [self muteUserWithID:user.userID completion:completionHandler];
}


- (AFHTTPRequestOperation *)muteUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueuePOSTPath:[self endpointPathForUserID:userID endpoint:@"mute"]
					  parameters:nil
						 success:[self successHandlerForResourceClass:[ANKUser class] clientHandler:completionHandler]
						 failure:[self failureHandlerForClientHandler:completionHandler]];
}


// DELETE /stream/0/users/[user_id]/mute
// http://developers.app.net/docs/resources/user/muting/#unmute-a-user

- (AFHTTPRequestOperation *)unmuteUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler {
	return [self unmuteUserWithID:user.userID completion:completionHandler];
}


- (AFHTTPRequestOperation *)unmuteUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueDELETEPath:[self endpointPathForUserID:userID endpoint:@"mute"]
						parameters:nil
						   success:[self successHandlerForResourceClass:[ANKUser class] clientHandler:completionHandler]
						   failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/users
// http://developers.app.net/docs/resources/user/lookup/#retrieve-multiple-users

- (AFHTTPRequestOperation *)fetchUsersWithIDs:(NSArray *)userIDs completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:@"users"
					 parameters:@{@"ids": [userIDs componentsJoinedByString:@","]}
						success:[self successHandlerForCollectionOfResourceClass:[ANKUser class] clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/users/search
// http://developers.app.net/docs/resources/user/lookup/#search-for-users

- (AFHTTPRequestOperation *)searchForUsersWithQuery:(NSString *)query completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:@"users/search"
					 parameters:@{@"q": query}
						success:[self successHandlerForCollectionOfResourceClass:[ANKUser class] clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/users/[user_id]/following
// http://developers.app.net/docs/resources/user/following/#list-users-a-user-is-following

- (AFHTTPRequestOperation *)fetchUsersUserFollowing:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler {
	return [self fetchUsersUserWithIDFollowing:user.userID completion:completionHandler];
}


- (AFHTTPRequestOperation *)fetchUsersUserWithIDFollowing:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:[self endpointPathForUserID:userID endpoint:@"following"]
					 parameters:nil
						success:[self successHandlerForCollectionOfResourceClass:[ANKUser class] clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/users/[user_id]/followers
// http://developers.app.net/docs/resources/user/following/#list-users-following-a-user

- (AFHTTPRequestOperation *)fetchUsersFollowingUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler {
	return [self fetchUsersFollowingUserWithID:user.userID completion:completionHandler];
}


- (AFHTTPRequestOperation *)fetchUsersFollowingUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:[self endpointPathForUserID:userID endpoint:@"followers"]
					 parameters:nil
						success:[self successHandlerForCollectionOfResourceClass:[ANKUser class] clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/users/[user_id]/following/ids
// http://developers.app.net/docs/resources/user/following/#list-user-ids-a-user-is-following

- (AFHTTPRequestOperation *)fetchUserIDsUserFollowing:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler {
	return [self fetchUserIDsUserWithIDFollowing:user.userID completion:completionHandler];
}


- (AFHTTPRequestOperation *)fetchUserIDsUserWithIDFollowing:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:[self endpointPathForUserID:userID endpoint:@"following/ids"]
					 parameters:nil
						success:[self successHandlerForPrimitiveResponseWithClientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/users/[user_id]/followers/ids
// http://developers.app.net/docs/resources/user/following/#list-user-ids-following-a-user

- (AFHTTPRequestOperation *)fetchUserIDsFollowingUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler {
	return [self fetchUserIDsFollowingUserWithID:user.userID completion:completionHandler];
}


- (AFHTTPRequestOperation *)fetchUserIDsFollowingUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:[self endpointPathForUserID:userID endpoint:@"followers/ids"]
					 parameters:nil
						success:[self successHandlerForPrimitiveResponseWithClientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/users/[user_id]/muted
// http://developers.app.net/docs/resources/user/muting/#list-muted-users

- (AFHTTPRequestOperation *)fetchMutedUsersForUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler {
	return [self fetchMutedUsersForUserWithID:user.userID completion:completionHandler];
}


- (AFHTTPRequestOperation *)fetchMutedUsersForUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:[self endpointPathForUserID:userID endpoint:completionHandler]
					 parameters:nil
						success:[self successHandlerForCollectionOfResourceClass:[ANKUser class] clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/users/[user_id]/muted
// http://developers.app.net/docs/resources/user/muting/#retrieve-muted-user-ids-for-multiple-users

- (AFHTTPRequestOperation *)fetchMutedUserIDsForUsers:(NSArray *)users completion:(ANKClientCompletionBlock)completionHandler {
	return [self fetchMutedUserIDsForUserIDs:[users valueForKeyPath:@"userID"] completion:completionHandler];
}


- (AFHTTPRequestOperation *)fetchMutedUserIDsForUserIDs:(NSArray *)userIDs completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:@"muted/ids"
					 parameters:@{@"ids": [userIDs componentsJoinedByString:@","]}
						success:[self successHandlerForPrimitiveResponseWithClientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/user/blocking/#list-blocked-users

- (AFHTTPRequestOperation *)fetchBlockedUsersForUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler {
	return [self fetchBlockedUsersForUserWithID:user.userID completion:completionHandler];
}


- (AFHTTPRequestOperation *)fetchBlockedUsersForUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:[self endpointPathForUserID:userID endpoint:@"blocked"]
					 parameters:nil
						success:[self successHandlerForCollectionOfResourceClass:[ANKUser class] clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/user/blocking/#retrieve-blocked-user-ids-for-multiple-users

- (AFHTTPRequestOperation *)fetchBlockedUsersForUsers:(NSArray *)users completion:(ANKClientCompletionBlock)completionHandler {
	return [self fetchBlockedUsersForUserIDs:[users valueForKeyPath:@"userID"] completion:completionHandler];
}


- (AFHTTPRequestOperation *)fetchBlockedUsersForUserIDs:(NSArray *)users completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:@"users/blocked/ids"
					 parameters:nil
						success:[self successHandlerForPrimitiveResponseWithClientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/posts/[post_id]/reposters
// http://developers.app.net/docs/resources/user/post-interactions/#list-users-who-have-reposted-a-post

- (AFHTTPRequestOperation *)fetchUsersRepostedForPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler {
	return [self fetchUsersRepostedForPostWithID:post.postID completion:completionHandler];
}


- (AFHTTPRequestOperation *)fetchUsersRepostedForPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:[NSString stringWithFormat:@"posts/%@/reposters", postID]
					 parameters:nil
						success:[self successHandlerForCollectionOfResourceClass:[ANKUser class] clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


// GET /stream/0/posts/[post_id]/stars
// http://developers.app.net/docs/resources/user/post-interactions/#list-users-who-have-starred-a-post

- (AFHTTPRequestOperation *)fetchUsersStarredForPost:(ANKPost *)post completion:(ANKClientCompletionBlock)completionHandler {
	return [self fetchUsersStarredForPostWithID:post.postID completion:completionHandler];
}


- (AFHTTPRequestOperation *)fetchUsersStarredForPostWithID:(NSString *)postID completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:[NSString stringWithFormat:@"posts/%@/stars", postID]
					 parameters:nil
						success:[self successHandlerForCollectionOfResourceClass:[ANKUser class] clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/user/blocking/#block-a-user

- (AFHTTPRequestOperation *)blockUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler {
	return [self blockUserWithID:user.userID completion:completionHandler];
}


- (AFHTTPRequestOperation *)blockUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueuePOSTPath:[self endpointPathForUserID:userID endpoint:@"block"]
					  parameters:nil
						 success:[self successHandlerForResourceClass:[ANKUser class] clientHandler:completionHandler]
						 failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/user/blocking/#unblock-a-user

- (AFHTTPRequestOperation *)unblockUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler {
	return [self unblockUserWithID:user.userID completion:completionHandler];
}


- (AFHTTPRequestOperation *)unblockUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueDELETEPath:[self endpointPathForUserID:userID endpoint:@"block"]
						parameters:nil
						   success:[self successHandlerForResourceClass:[ANKUser class] clientHandler:completionHandler]
						   failure:[self failureHandlerForClientHandler:completionHandler]];
}


@end
