//
//  ADNClient+ADNChannel.h
//  ADNKit
//
//  Created by Joel Levin on 3/7/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKClient+ANKHandlerBlocks.h"


@class ANKChannel, ANKACL, ANKUser;

@interface ANKClient (ANKChannel)

- (void)fetchCurrentUserSubscribedChannelsWithCompletion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchCurrentUserPrivateMessageChannelsWithCompletion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchCurrentUserCreatedChannelsWithCompletion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchUnreadPMChannelsCountWithCompletion:(ANKClientCompletionBlock)completionHandler;

- (void)fetchChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchChannelsWithIDs:(NSArray *)channelIDs completion:(ANKClientCompletionBlock)completionHandler;

- (void)fetchUsersSubscribedToChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchUsersSubscribedToChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchUserIDsSubscribedToChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchUserIDsSubscribedToChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchUserIDsSubscribedToChannelIDs:(NSArray *)channelIDs completion:(ANKClientCompletionBlock)completionHandler;

- (void)createChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (void)createChannelWithType:(NSString *)type readers:(ANKACL *)readersACL writers:(ANKACL *)writersACL completion:(ANKClientCompletionBlock)completionHandler;

- (void)updateChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (void)updateChannelWithID:(NSString *)channelID readers:(ANKACL *)readersACL writers:(ANKACL *)writersACL completion:(ANKClientCompletionBlock)completionHandler;

- (void)subscribeToChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (void)subscribeToChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;
- (void)unsubscribeToChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (void)unsubscribeToChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;

@end
