/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

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

- (void)fetchMutedChannelsForCurrentUserWithCompletion:(ANKClientCompletionBlock)completionHandler;

- (void)createChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (void)createChannelWithType:(NSString *)type readers:(ANKACL *)readersACL writers:(ANKACL *)writersACL completion:(ANKClientCompletionBlock)completionHandler;

- (void)updateChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (void)updateChannelWithID:(NSString *)channelID readers:(ANKACL *)readersACL writers:(ANKACL *)writersACL completion:(ANKClientCompletionBlock)completionHandler;

- (void)subscribeToChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (void)subscribeToChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;
- (void)unsubscribeToChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (void)unsubscribeToChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;

- (void)muteChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (void)muteChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;
- (void)unmuteChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (void)unmuteChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;

@end
