/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ANKClient+ANKChannel.h"
#import "ANKChannel.h"
#import "ANKUser.h"
#import "ANKACL.h"


@implementation ANKClient (ANKChannel)

// http://developers.app.net/docs/resources/channel/subscriptions/#get-current-users-subscribed-channels

- (ANKJSONRequestOperation *)fetchCurrentUserSubscribedChannelsWithCompletion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:@"channels"
					 parameters:nil
						success:[self successHandlerForCollectionOfResourceClass:[ANKChannel class] clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}

- (ANKJSONRequestOperation *)fetchCurrentUserSubscribedChannelsWithTypes:(NSArray *)types completion:(ANKClientCompletionBlock)completionHandler {
	if (!types) {
		types = @[];
	}
	
	return [self enqueueGETPath:@"channels"
					 parameters:@{ @"channel_types": [types componentsJoinedByString:@","] }
						success:[self successHandlerForCollectionOfResourceClass:[ANKChannel class] clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


- (ANKJSONRequestOperation *)fetchCurrentUserPrivateMessageChannelsWithCompletion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:@"channels" parameters:nil success:[self successHandlerForCollectionOfResourceClass:[ANKChannel class] clientHandler:completionHandler filteredWith:^BOOL(id object) {
		return [(ANKChannel *)object isPrivateMessageChannel];
	}] failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/lookup/#retrieve-my-channels

- (ANKJSONRequestOperation *)fetchCurrentUserCreatedChannelsWithCompletion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:@"users/me/channels"
					 parameters:nil
						success:[self successHandlerForCollectionOfResourceClass:[ANKChannel class] clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/lookup/#retrieve-number-of-unread-pm-channels

- (ANKJSONRequestOperation *)fetchUnreadPMChannelsCountWithCompletion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:@"users/me/channels/pm/num_unread"
					 parameters:nil
						success:[self successHandlerForPrimitiveResponseWithClientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/lookup/#retrieve-a-channel

- (ANKJSONRequestOperation *)fetchChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:[NSString stringWithFormat:@"channels/%@", channelID]
					 parameters:nil
						success:[self successHandlerForResourceClass:[ANKChannel class] clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/lookup/#retrieve-multiple-channels

- (ANKJSONRequestOperation *)fetchChannelsWithIDs:(NSArray *)channelIDs completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:@"channels"
					 parameters:@{@"ids": [channelIDs componentsJoinedByString:@","]}
						success:[self successHandlerForCollectionOfResourceClass:[ANKChannel class] clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/subscriptions/#retrieve-users-subscribed-to-a-channel

- (ANKJSONRequestOperation *)fetchUsersSubscribedToChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler {
	return [self fetchUsersSubscribedToChannelWithID:channel.channelID completion:completionHandler];
}


- (ANKJSONRequestOperation *)fetchUsersSubscribedToChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:[NSString stringWithFormat:@"channels/%@/subscribers", channelID]
					 parameters:nil
						success:[self successHandlerForCollectionOfResourceClass:[ANKUser class] clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/subscriptions/#retrieve-user-ids-subscribed-to-a-channel

- (ANKJSONRequestOperation *)fetchUserIDsSubscribedToChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler {
	return [self fetchUserIDsSubscribedToChannelWithID:channel.channelID completion:completionHandler];
}


- (ANKJSONRequestOperation *)fetchUserIDsSubscribedToChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:[NSString stringWithFormat:@"channels/%@/subscribers/ids", channelID]
					 parameters:nil
						success:[self successHandlerForPrimitiveResponseWithClientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/subscriptions/#retrieve-user-ids-subscribed-to-a-channel

- (ANKJSONRequestOperation *)fetchUserIDsSubscribedToChannelIDs:(NSArray *)channelIDs completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:@"channels/subscribers/ids"
					 parameters:nil
						success:[self successHandlerForPrimitiveResponseWithClientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/muting/#get-current-users-muted-channels

- (ANKJSONRequestOperation *)fetchMutedChannelsForCurrentUserWithCompletion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:@"users/me/channels/muted"
					 parameters:nil
						success:[self successHandlerForCollectionOfResourceClass:[ANKChannel class] clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/lifecycle/#create-a-channel

- (ANKJSONRequestOperation *)createChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueuePOSTPath:@"channels"
					  parameters:[channel JSONDictionary]
						 success:[self successHandlerForResourceClass:[ANKChannel class] clientHandler:completionHandler]
						 failure:[self failureHandlerForClientHandler:completionHandler]];
}


- (ANKJSONRequestOperation *)createChannelWithType:(NSString *)type readers:(ANKACL *)readersACL writers:(ANKACL *)writersACL completion:(ANKClientCompletionBlock)completionHandler {
	NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObject:type forKey:@"type"];
	if (readersACL) {
		parameters[@"readers"] = [readersACL JSONDictionary];
	}
	if (writersACL) {
		parameters[@"writers"] = [writersACL JSONDictionary];
	}
	
	return [self enqueuePOSTPath:@"channels"
					  parameters:parameters
						 success:[self successHandlerForResourceClass:[ANKChannel class] clientHandler:completionHandler]
						 failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/lifecycle/#update-a-channel

- (ANKJSONRequestOperation *)updateChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueuePUTPath:[NSString stringWithFormat:@"channels/%@", channel.channelID]
					 parameters:[channel JSONDictionary]
						success:[self successHandlerForResourceClass:[ANKChannel class] clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


- (ANKJSONRequestOperation *)updateChannelWithID:(NSString *)channelID readers:(ANKACL *)readersACL writers:(ANKACL *)writersACL completion:(ANKClientCompletionBlock)completionHandler {
	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
	if (readersACL) {
		parameters[@"readers"] = [readersACL JSONDictionary];
	}
	if (writersACL) {
		parameters[@"writers"] = [writersACL JSONDictionary];
	}
	
	return [self enqueuePUTPath:[NSString stringWithFormat:@"channels/%@", channelID]
					 parameters:parameters
						success:[self successHandlerForResourceClass:[ANKChannel class] clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/subscriptions/#subscribe-to-a-channel

- (ANKJSONRequestOperation *)subscribeToChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler {
	return [self subscribeToChannelWithID:channel.channelID completion:completionHandler];
}


- (ANKJSONRequestOperation *)subscribeToChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueuePOSTPath:[NSString stringWithFormat:@"channels/%@/subscribe", channelID]
					  parameters:nil
						 success:[self successHandlerForResourceClass:[ANKChannel class] clientHandler:completionHandler]
						 failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/subscriptions/#unsubscribe-from-a-channel

- (ANKJSONRequestOperation *)unsubscribeToChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler {
	return [self unsubscribeToChannelWithID:channel.channelID completion:completionHandler];
}


- (ANKJSONRequestOperation *)unsubscribeToChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueDELETEPath:[NSString stringWithFormat:@"channels/%@/subscribe", channelID]
						parameters:nil
						   success:[self successHandlerForResourceClass:[ANKChannel class] clientHandler:completionHandler]
						   failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/muting/#mute-a-channel

- (ANKJSONRequestOperation *)muteChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler {
	return [self muteChannelWithID:channel.channelID completion:completionHandler];
}


- (ANKJSONRequestOperation *)muteChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueuePOSTPath:[NSString stringWithFormat:@"channels/%@/mute", channelID]
					  parameters:nil
						 success:[self successHandlerForResourceClass:[ANKChannel class] clientHandler:completionHandler]
						 failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/muting/#unmute-a-channel

- (ANKJSONRequestOperation *)unmuteChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler {
	return [self unmuteChannelWithID:channel.channelID completion:completionHandler];
}


- (ANKJSONRequestOperation *)unmuteChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueDELETEPath:[NSString stringWithFormat:@"channels/%@/mute", channelID]
						parameters:nil
						   success:[self successHandlerForResourceClass:[ANKChannel class] clientHandler:completionHandler]
						   failure:[self failureHandlerForClientHandler:completionHandler]];
}


@end
