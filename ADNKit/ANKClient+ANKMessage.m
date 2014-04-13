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

- (ANKJSONRequestOperation *)fetchMessagesInChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler {
	return [self fetchMessagesInChannelWithID:channel.channelID completion:completionHandler];
}


- (ANKJSONRequestOperation *)fetchMessagesInChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:[NSString stringWithFormat:@"channels/%@/messages", channelID]
					 parameters:nil
						success:[self successHandlerForCollectionOfResourceClass:[ANKMessage class] clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/message/lookup/#retrieve-a-message

- (ANKJSONRequestOperation *)fetchMessageWithID:(NSString *)messageID inChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler {
	return [self fetchMessageWithID:messageID inChannelWithID:channel.channelID completion:completionHandler];
}


- (ANKJSONRequestOperation *)fetchMessageWithID:(NSString *)messageID inChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:[NSString stringWithFormat:@"channels/%@/messages/%@", channelID, messageID]
					 parameters:nil
						success:[self successHandlerForResourceClass:[ANKMessage class] clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/message/lookup/#retrieve-multiple-messages

- (ANKJSONRequestOperation *)fetchMessagesWithIDs:(NSArray *)messageIDs completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:@"channels/messages"
					 parameters:@{@"ids": [messageIDs componentsJoinedByString:@","]}
						success:[self successHandlerForCollectionOfResourceClass:[ANKMessage class] clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/message/lookup/#retrieve-my-messages

- (ANKJSONRequestOperation *)fetchMessagesCreatedByCurrentUserWithCompletion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:@"users/me/messages"
					 parameters:nil
						success:[self successHandlerForCollectionOfResourceClass:[ANKMessage class] clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/message/lifecycle/#create-a-message

- (ANKJSONRequestOperation *)createMessage:(ANKMessage *)message inChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler {
	return [self createMessage:message inChannelWithID:channel.channelID completion:completionHandler];
}


- (ANKJSONRequestOperation *)createMessage:(ANKMessage *)message inChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler {
	return [self enqueuePOSTPath:[NSString stringWithFormat:@"channels/%@/messages", channelID]
					  parameters:[message JSONDictionary]
						 success:[self successHandlerForResourceClass:[ANKMessage class] clientHandler:completionHandler]
						 failure:[self failureHandlerForClientHandler:completionHandler]];
}


- (ANKJSONRequestOperation *)createMessageWithText:(NSString *)messageText inReplyToMessageWithID:(NSString *)messageID inChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler {
	return [self createMessageWithText:messageText inReplyToMessageWithID:messageID inChannelWithID:channel.channelID completion:completionHandler];
}


- (ANKJSONRequestOperation *)createMessageWithText:(NSString *)messageText inReplyToMessageWithID:(NSString *)messageID inChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler {
	ANKMessage *message = [[ANKMessage alloc] init];
	message.text = messageText;
	message.inReplyToMessageID = messageID ?: nil;
	return [self createMessage:message inChannelWithID:channelID completion:completionHandler];
}


- (ANKJSONRequestOperation *)deleteMessageWithID:(NSString *)messageID inChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler {
    return [self enqueueDELETEPath:[NSString stringWithFormat:@"channels/%@/messages/%@",channelID,messageID]
                        parameters:nil
                           success:[self successHandlerForResourceClass:[ANKMessage class] clientHandler:completionHandler]
                           failure:[self failureHandlerForClientHandler:completionHandler]];
}


- (ANKJSONRequestOperation *)deleteMessage:(ANKMessage *)message completion:(ANKClientCompletionBlock)completionHandler {
    return [self deleteMessageWithID:message.messageID inChannelWithID:message.channelID completion:completionHandler];
}


@end
