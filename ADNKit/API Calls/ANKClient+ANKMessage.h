//
//  ADNClient+ADNMessage.h
//  ADNKit
//
//  Created by Joel Levin on 3/7/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKClient+ANKHandlerBlocks.h"


@class ANKMessage, ANKChannel;

@interface ANKClient (ANKMessage)

- (void)fetchMessagesInChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchMessagesInChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchMessageWithID:(NSString *)messageID inChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchMessageWithID:(NSString *)messageID inChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchMessagesWithIDs:(NSArray *)messageIDs completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchMessagesCreatedByCurrentUserWithCompletion:(ANKClientCompletionBlock)completionHandler;

- (void)createMessage:(ANKMessage *)message inChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (void)createMessage:(ANKMessage *)message inChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;
- (void)createMessageWithText:(NSString *)messageText inReplyToMessageWithID:(NSString *)messageID inChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (void)createMessageWithText:(NSString *)messageText inReplyToMessageWithID:(NSString *)messageID inChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;

@end
