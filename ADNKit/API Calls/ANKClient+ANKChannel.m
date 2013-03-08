//
//  ADNClient+ADNChannel.m
//  ADNKit
//
//  Created by Joel Levin on 3/7/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKClient+ANKChannel.h"
#import "ANKChannel.h"
#import "ANKUser.h"
#import "ANKACL.h"


@implementation ANKClient (ANKChannel)

// http://developers.app.net/docs/resources/channel/subscriptions/#get-current-users-subscribed-channels

- (void)fetchCurrentUserSubscribedChannelsWithCompletion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:@"channels"
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKChannel class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


- (void)fetchCurrentUserPrivateMessageChannelsWithCompletion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:@"channels" parameters:nil success:[self successHandlerForCollectionOfResourceClass:[ANKChannel class] clientHandler:completionHandler filterBlock:^BOOL(id object) {
		return [(ANKChannel *)object isPrivateMessageChannel];
	}] failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/lookup/#retrieve-my-channels

- (void)fetchCurrentUserCreatedChannelsWithCompletion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:@"users/me/channels"
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKChannel class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/lookup/#retrieve-number-of-unread-pm-channels

- (void)fetchUnreadPMChannelsCountWithCompletion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:@"users/me/channels/pm/num_unread"
	   parameters:nil
		  success:[self successHandlerForPrimitiveResponseWithClientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/lookup/#retrieve-a-channel

- (void)fetchChannelWithID:(NSString *)channelID completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"channels/%@", channelID]
	   parameters:nil
		  success:[self successHandlerForResourceClass:[ANKChannel class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/lookup/#retrieve-multiple-channels

- (void)fetchChannelsWithIDs:(NSArray *)channelIDs completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:@"channels"
	   parameters:@{@"ids": [channelIDs componentsJoinedByString:@","]}
		  success:[self successHandlerForCollectionOfResourceClass:[ANKChannel class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/subscriptions/#retrieve-users-subscribed-to-a-channel

- (void)fetchUsersSubscribedToChannel:(ANKChannel *)channel completion:(ADNClientCompletionBlock)completionHandler {
	[self fetchUsersSubscribedToChannelWithID:channel.channelID completion:completionHandler];
}


- (void)fetchUsersSubscribedToChannelWithID:(NSString *)channelID completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"channels/%@/subscribers", channelID]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKUser class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/subscriptions/#retrieve-user-ids-subscribed-to-a-channel

- (void)fetchUserIDsSubscribedToChannel:(ANKChannel *)channel completion:(ADNClientCompletionBlock)completionHandler {
	[self fetchUserIDsSubscribedToChannelWithID:channel.channelID completion:completionHandler];
}


- (void)fetchUserIDsSubscribedToChannelWithID:(NSString *)channelID completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"channels/%@/subscribers/ids", channelID]
	   parameters:nil
		  success:[self successHandlerForPrimitiveResponseWithClientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/subscriptions/#retrieve-user-ids-subscribed-to-a-channel

- (void)fetchUserIDsSubscribedToChannelIDs:(NSArray *)channelIDs completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:@"channels/subscribers/ids"
	   parameters:nil
		  success:[self successHandlerForPrimitiveResponseWithClientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/lifecycle/#create-a-channel

- (void)createChannel:(ANKChannel *)channel completion:(ADNClientCompletionBlock)completionHandler {
	[self postPath:@"channels"
		parameters:[channel JSONDictionary]
		   success:[self successHandlerForResourceClass:[ANKChannel class] clientHandler:completionHandler]
		   failure:[self failureHandlerForClientHandler:completionHandler]];
}


- (void)createChannelWithType:(NSString *)type readers:(ANKACL *)readersACL writers:(ANKACL *)writersACL completion:(ADNClientCompletionBlock)completionHandler {
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

- (void)updateChannel:(ANKChannel *)channel completion:(ADNClientCompletionBlock)completionHandler {
	[self putPath:[NSString stringWithFormat:@"channels/%@", channel.channelID]
	   parameters:[channel JSONDictionary]
		  success:[self successHandlerForResourceClass:[ANKChannel class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


- (void)updateChannelWithID:(NSString *)channelID readers:(ANKACL *)readersACL writers:(ANKACL *)writersACL completion:(ADNClientCompletionBlock)completionHandler {
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

- (void)subscribeToChannel:(ANKChannel *)channel completion:(ADNClientCompletionBlock)completionHandler {
	[self subscribeToChannelWithID:channel.channelID completion:completionHandler];
}


- (void)subscribeToChannelWithID:(NSString *)channelID completion:(ADNClientCompletionBlock)completionHandler {
	[self postPath:[NSString stringWithFormat:@"channels/%@/subscribe", channelID]
		parameters:nil
		   success:[self successHandlerForResourceClass:[ANKChannel class] clientHandler:completionHandler]
		   failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/channel/subscriptions/#unsubscribe-from-a-channel

- (void)unsubscribeToChannel:(ANKChannel *)channel completion:(ADNClientCompletionBlock)completionHandler {
	[self unsubscribeToChannelWithID:channel.channelID completion:completionHandler];
}


- (void)unsubscribeToChannelWithID:(NSString *)channelID completion:(ADNClientCompletionBlock)completionHandler {
	[self deletePath:[NSString stringWithFormat:@"channels/%@/subscribe", channelID]
		  parameters:nil
			 success:[self successHandlerForResourceClass:[ANKChannel class] clientHandler:completionHandler]
			 failure:[self failureHandlerForClientHandler:completionHandler]];
}


@end
