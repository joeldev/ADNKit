//
//  ADNClient+ADNMessage.m
//  ADNKit
//
//  Created by Joel Levin on 3/7/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNClient+ADNMessage.h"
#import "ADNMessage.h"
#import "ADNChannel.h"


@implementation ADNClient (ADNMessage)

// http://developers.app.net/docs/resources/message/lifecycle/#retrieve-the-messages-in-a-channel

- (void)fetchMessagesInChannel:(ADNChannel *)channel completion:(ADNClientCompletionBlock)completionHandler {
	[self fetchMessagesInChannelWithID:channel.channelID completion:completionHandler];
}


- (void)fetchMessagesInChannelWithID:(NSString *)channelID completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"channels/%@/messages", channelID]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ADNMessage class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/message/lookup/#retrieve-a-message

- (void)fetchMessageWithID:(NSString *)messageID inChannel:(ADNChannel *)channel completion:(ADNClientCompletionBlock)completionHandler {
	[self fetchMessageWithID:messageID inChannelWithID:channel.channelID completion:completionHandler];
}


- (void)fetchMessageWithID:(NSString *)messageID inChannelWithID:(NSString *)channelID completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"channels/%@/messages/%@", channelID, messageID]
	   parameters:nil
		  success:[self successHandlerForResourceClass:[ADNMessage class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/message/lookup/#retrieve-multiple-messages

- (void)fetchMessagesWithIDs:(NSArray *)messageIDs completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:@"channels/messages"
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ADNMessage class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/message/lookup/#retrieve-my-messages

- (void)fetchMessagesCreatedByCurrentUserWithCompletion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:@"users/me/messages"
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ADNMessage class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/message/lifecycle/#create-a-message

- (void)createMessage:(ADNMessage *)message inChannel:(ADNChannel *)channel completion:(ADNClientCompletionBlock)completionHandler {
	[self createMessage:message inChannelWithID:channel.channelID completion:completionHandler];
}


- (void)createMessage:(ADNMessage *)message inChannelWithID:(NSString *)channelID completion:(ADNClientCompletionBlock)completionHandler {
	[self postPath:[NSString stringWithFormat:@"channels/%@/messages", channelID]
		parameters:[message JSONDictionary]
		   success:[self successHandlerForResourceClass:[ADNMessage class] clientHandler:completionHandler]
		   failure:[self failureHandlerForClientHandler:completionHandler]];
}


- (void)createMessageWithText:(NSString *)messageText inReplyToMessageWithID:(NSString *)messageID inChannel:(ADNChannel *)channel completion:(ADNClientCompletionBlock)completionHandler {
	[self createMessageWithText:messageText inReplyToMessageWithID:messageID inChannel:channel completion:completionHandler];
}


- (void)createMessageWithText:(NSString *)messageText inReplyToMessageWithID:(NSString *)messageID inChannelWithID:(NSString *)channelID completion:(ADNClientCompletionBlock)completionHandler {
	ADNMessage *message = [[ADNMessage alloc] init];
	message.text = messageText;
	message.inReplyToMessageID = messageID ?: nil;
	[self createMessage:message inChannelWithID:channelID completion:completionHandler];
}


@end
