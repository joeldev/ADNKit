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

- (void)fetchCurrentUserSubscribedChannelsWithCompletion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchCurrentUserPrivateMessageChannelsWithCompletion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchCurrentUserCreatedChannelsWithCompletion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUnreadPMChannelsCountWithCompletion:(ADNClientCompletionBlock)completionHandler;

- (void)fetchChannelWithID:(NSString *)channelID completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchChannelsWithIDs:(NSArray *)channelIDs completion:(ADNClientCompletionBlock)completionHandler;

- (void)fetchUsersSubscribedToChannel:(ANKChannel *)channel completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUsersSubscribedToChannelWithID:(NSString *)channelID completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUserIDsSubscribedToChannel:(ANKChannel *)channel completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUserIDsSubscribedToChannelWithID:(NSString *)channelID completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUserIDsSubscribedToChannelIDs:(NSArray *)channelIDs completion:(ADNClientCompletionBlock)completionHandler;

- (void)createChannel:(ANKChannel *)channel completion:(ADNClientCompletionBlock)completionHandler;
- (void)createChannelWithType:(NSString *)type readers:(ANKACL *)readersACL writers:(ANKACL *)writersACL completion:(ADNClientCompletionBlock)completionHandler;

- (void)updateChannel:(ANKChannel *)channel completion:(ADNClientCompletionBlock)completionHandler;
- (void)updateChannelWithID:(NSString *)channelID readers:(ANKACL *)readersACL writers:(ANKACL *)writersACL completion:(ADNClientCompletionBlock)completionHandler;

- (void)subscribeToChannel:(ANKChannel *)channel completion:(ADNClientCompletionBlock)completionHandler;
- (void)subscribeToChannelWithID:(NSString *)channelID completion:(ADNClientCompletionBlock)completionHandler;
- (void)unsubscribeToChannel:(ANKChannel *)channel completion:(ADNClientCompletionBlock)completionHandler;
- (void)unsubscribeToChannelWithID:(NSString *)channelID completion:(ADNClientCompletionBlock)completionHandler;

@end
