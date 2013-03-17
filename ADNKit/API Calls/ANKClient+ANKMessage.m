/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

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
