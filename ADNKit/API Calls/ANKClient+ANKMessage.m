//
//  ADNClient+ADNMessage.m
//  ADNKit
//
//  Created by Joel Levin on 3/7/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKClient+ANKMessage.h"
#import "ANKMessage.h"
#import "ANKChannel.h"


@implementation ANKClient (ANKMessage)

// http://developers.app.net/docs/resources/message/lifecycle/#retrieve-the-messages-in-a-channel

- (void)fetchMessagesInChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler {
	[self fetchMessagesInChannelWithID:channel.channelID completion:completionHandler];
}


- (void)fetchMessagesInChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"channels/%@/messages", channelID]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKMessage class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/message/lookup/#retrieve-a-message

- (void)fetchMessageWithID:(NSString *)messageID inChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler {
	[self fetchMessageWithID:messageID inChannelWithID:channel.channelID completion:completionHandler];
}


- (void)fetchMessageWithID:(NSString *)messageID inChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"channels/%@/messages/%@", channelID, messageID]
	   parameters:nil
		  success:[self successHandlerForResourceClass:[ANKMessage class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/message/lookup/#retrieve-multiple-messages

- (void)fetchMessagesWithIDs:(NSArray *)messageIDs completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:@"channels/messages"
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKMessage class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/message/lookup/#retrieve-my-messages

- (void)fetchMessagesCreatedByCurrentUserWithCompletion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:@"users/me/messages"
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKMessage class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/message/lifecycle/#create-a-message

- (void)createMessage:(ANKMessage *)message inChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler {
	[self createMessage:message inChannelWithID:channel.channelID completion:completionHandler];
}


- (void)createMessage:(ANKMessage *)message inChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler {
	[self postPath:[NSString stringWithFormat:@"channels/%@/messages", channelID]
		parameters:[message JSONDictionary]
		   success:[self successHandlerForResourceClass:[ANKMessage class] clientHandler:completionHandler]
		   failure:[self failureHandlerForClientHandler:completionHandler]];
}


- (void)createMessageWithText:(NSString *)messageText inReplyToMessageWithID:(NSString *)messageID inChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler {
	[self createMessageWithText:messageText inReplyToMessageWithID:messageID inChannel:channel completion:completionHandler];
}


- (void)createMessageWithText:(NSString *)messageText inReplyToMessageWithID:(NSString *)messageID inChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler {
	ANKMessage *message = [[ANKMessage alloc] init];
	message.text = messageText;
	message.inReplyToMessageID = messageID ?: nil;
	[self createMessage:message inChannelWithID:channelID completion:completionHandler];
}


@end
