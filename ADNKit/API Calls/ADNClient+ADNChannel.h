//
//  ADNClient+ADNChannel.h
//  ADNKit
//
//  Created by Joel Levin on 3/7/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNClient+ADNHandlerBlocks.h"


@class ADNChannel, ADNACL, ADNUser;

@interface ADNClient (ADNChannel)

- (void)fetchCurrentUserSubscribedChannelsWithCompletion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchCurrentUserPrivateMessageChannelsWithCompletion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchCurrentUserCreatedChannelsWithCompletion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUnreadPMChannelsCountWithCompletion:(ADNClientCompletionBlock)completionHandler;

- (void)fetchChannelWithID:(NSString *)channelID completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchChannelsWithIDs:(NSArray *)channelIDs completion:(ADNClientCompletionBlock)completionHandler;

- (void)fetchUsersSubscribedToChannel:(ADNChannel *)channel completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUsersSubscribedToChannelWithID:(NSString *)channelID completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUserIDsSubscribedToChannel:(ADNChannel *)channel completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUserIDsSubscribedToChannelWithID:(NSString *)channelID completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUserIDsSubscribedToChannelIDs:(NSArray *)channelIDs completion:(ADNClientCompletionBlock)completionHandler;

- (void)createChannel:(ADNChannel *)channel completion:(ADNClientCompletionBlock)completionHandler;
- (void)createChannelWithType:(NSString *)type readers:(ADNACL *)readersACL writers:(ADNACL *)writersACL completion:(ADNClientCompletionBlock)completionHandler;

- (void)updateChannel:(ADNChannel *)channel completion:(ADNClientCompletionBlock)completionHandler;
- (void)updateChannelWithID:(NSString *)channelID readers:(ADNACL *)readersACL writers:(ADNACL *)writersACL completion:(ADNClientCompletionBlock)completionHandler;

- (void)subscribeToChannel:(ADNChannel *)channel completion:(ADNClientCompletionBlock)completionHandler;
- (void)subscribeToChannelWithID:(NSString *)channelID completion:(ADNClientCompletionBlock)completionHandler;
- (void)unsubscribeToChannel:(ADNChannel *)channel completion:(ADNClientCompletionBlock)completionHandler;
- (void)unsubscribeToChannelWithID:(NSString *)channelID completion:(ADNClientCompletionBlock)completionHandler;

@end
