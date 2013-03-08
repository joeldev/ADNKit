//
//  ADNClient+ADNMessage.h
//  ADNKit
//
//  Created by Joel Levin on 3/7/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNClient+ADNHandlerBlocks.h"


@class ADNMessage, ADNChannel;

@interface ADNClient (ADNMessage)

- (void)fetchMessagesInChannel:(ADNChannel *)channel completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchMessagesInChannelWithID:(NSString *)channelID completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchMessageWithID:(NSString *)messageID inChannel:(ADNChannel *)channel completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchMessageWithID:(NSString *)messageID inChannelWithID:(NSString *)channelID completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchMessagesWithIDs:(NSArray *)messageIDs completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchMessagesCreatedByCurrentUserWithCompletion:(ADNClientCompletionBlock)completionHandler;

- (void)createMessage:(ADNMessage *)message inChannel:(ADNChannel *)channel completion:(ADNClientCompletionBlock)completionHandler;
- (void)createMessage:(ADNMessage *)message inChannelWithID:(NSString *)channelID completion:(ADNClientCompletionBlock)completionHandler;
- (void)createMessageWithText:(NSString *)messageText inReplyToMessageWithID:(NSString *)messageID inChannel:(ADNChannel *)channel completion:(ADNClientCompletionBlock)completionHandler;
- (void)createMessageWithText:(NSString *)messageText inReplyToMessageWithID:(NSString *)messageID inChannelWithID:(NSString *)channelID completion:(ADNClientCompletionBlock)completionHandler;

@end
