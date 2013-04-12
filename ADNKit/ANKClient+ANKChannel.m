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

- (void)fetchCurrentUserSubscribedChannelsWithCompletion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:@"channels"
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKChannel class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


- (void)fetchCurrentUserPrivateMessageChannelsWithCompletion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:@"channels" parameters:nil success:[self successHandlerForCollectionOfResourceClass:[ANKChannel class] clientHandler:completionHandler filteredWith:^BOOL(id object) {
		return [(ANKChannel *)object isPrivateMessageChannel];
	}] failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/lookup/#retrieve-my-channels

- (void)fetchCurrentUserCreatedChannelsWithCompletion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:@"users/me/channels"
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKChannel class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/lookup/#retrieve-number-of-unread-pm-channels

- (void)fetchUnreadPMChannelsCountWithCompletion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:@"users/me/channels/pm/num_unread"
	   parameters:nil
		  success:[self successHandlerForPrimitiveResponseWithClientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/lookup/#retrieve-a-channel

- (void)fetchChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"channels/%@", channelID]
	   parameters:nil
		  success:[self successHandlerForResourceClass:[ANKChannel class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/lookup/#retrieve-multiple-channels

- (void)fetchChannelsWithIDs:(NSArray *)channelIDs completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:@"channels"
	   parameters:@{@"ids": [channelIDs componentsJoinedByString:@","]}
		  success:[self successHandlerForCollectionOfResourceClass:[ANKChannel class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/subscriptions/#retrieve-users-subscribed-to-a-channel

- (void)fetchUsersSubscribedToChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler {
	[self fetchUsersSubscribedToChannelWithID:channel.channelID completion:completionHandler];
}


- (void)fetchUsersSubscribedToChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"channels/%@/subscribers", channelID]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKUser class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/subscriptions/#retrieve-user-ids-subscribed-to-a-channel

- (void)fetchUserIDsSubscribedToChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler {
	[self fetchUserIDsSubscribedToChannelWithID:channel.channelID completion:completionHandler];
}


- (void)fetchUserIDsSubscribedToChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"channels/%@/subscribers/ids", channelID]
	   parameters:nil
		  success:[self successHandlerForPrimitiveResponseWithClientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/subscriptions/#retrieve-user-ids-subscribed-to-a-channel

- (void)fetchUserIDsSubscribedToChannelIDs:(NSArray *)channelIDs completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:@"channels/subscribers/ids"
	   parameters:nil
		  success:[self successHandlerForPrimitiveResponseWithClientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/muting/#get-current-users-muted-channels

- (void)fetchMutedChannelsForCurrentUserWithCompletion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:@"users/me/channels/muted"
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKChannel class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/lifecycle/#create-a-channel

- (void)createChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler {
	[self postPath:@"channels"
		parameters:[channel JSONDictionary]
		   success:[self successHandlerForResourceClass:[ANKChannel class] clientHandler:completionHandler]
		   failure:[self failureHandlerForClientHandler:completionHandler]];
}


- (void)createChannelWithType:(NSString *)type readers:(ANKACL *)readersACL writers:(ANKACL *)writersACL completion:(ANKClientCompletionBlock)completionHandler {
	NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObject:type forKey:@"type"];
	if (readersACL) {
		parameters[@"readers"] = [readersACL JSONDictionary];
	}
	if (writersACL) {
		parameters[@"writers"] = [writersACL JSONDictionary];
	}
	
	[self postPath:@"channels"
		parameters:parameters
		   success:[self successHandlerForResourceClass:[ANKChannel class] clientHandler:completionHandler]
		   failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/lifecycle/#update-a-channel

- (void)updateChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler {
	[self putPath:[NSString stringWithFormat:@"channels/%@", channel.channelID]
	   parameters:[channel JSONDictionary]
		  success:[self successHandlerForResourceClass:[ANKChannel class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


- (void)updateChannelWithID:(NSString *)channelID readers:(ANKACL *)readersACL writers:(ANKACL *)writersACL completion:(ANKClientCompletionBlock)completionHandler {
	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
	if (readersACL) {
		parameters[@"readers"] = [readersACL JSONDictionary];
	}
	if (writersACL) {
		parameters[@"writers"] = [writersACL JSONDictionary];
	}
	
	[self putPath:[NSString stringWithFormat:@"channels/%@", channelID]
	   parameters:parameters
		  success:[self successHandlerForResourceClass:[ANKChannel class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/subscriptions/#subscribe-to-a-channel

- (void)subscribeToChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler {
	[self subscribeToChannelWithID:channel.channelID completion:completionHandler];
}


- (void)subscribeToChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler {
	[self postPath:[NSString stringWithFormat:@"channels/%@/subscribe", channelID]
		parameters:nil
		   success:[self successHandlerForResourceClass:[ANKChannel class] clientHandler:completionHandler]
		   failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/subscriptions/#unsubscribe-from-a-channel

- (void)unsubscribeToChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler {
	[self unsubscribeToChannelWithID:channel.channelID completion:completionHandler];
}


- (void)unsubscribeToChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler {
	[self deletePath:[NSString stringWithFormat:@"channels/%@/subscribe", channelID]
		  parameters:nil
			 success:[self successHandlerForResourceClass:[ANKChannel class] clientHandler:completionHandler]
			 failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/muting/#mute-a-channel

- (void)muteChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler {
	[self muteChannelWithID:channel.channelID completion:completionHandler];
}


- (void)muteChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler {
	[self postPath:[NSString stringWithFormat:@"channels/%@/mute", channelID]
		parameters:nil
		   success:[self successHandlerForResourceClass:[ANKChannel class] clientHandler:completionHandler]
		   failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/muting/#unmute-a-channel

- (void)unmuteChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler {
	[self unmuteChannelWithID:channel.channelID completion:completionHandler];
}


- (void)unmuteChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler {
	[self deletePath:[NSString stringWithFormat:@"channels/%@/mute", channelID]
		  parameters:nil
			 success:[self successHandlerForResourceClass:[ANKChannel class] clientHandler:completionHandler]
			 failure:[self failureHandlerForClientHandler:completionHandler]];
}


@end
