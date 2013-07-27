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

- (ANKJSONRequestOperation *)fetchCurrentUserSubscribedChannelsWithCompletion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)fetchCurrentUserSubscribedChannelsWithTypes:(NSArray *)types completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)fetchCurrentUserPrivateMessageChannelsWithCompletion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)fetchCurrentUserCreatedChannelsWithCompletion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)fetchUnreadPMChannelsCountWithCompletion:(ANKClientCompletionBlock)completionHandler;

- (ANKJSONRequestOperation *)fetchChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)fetchChannelsWithIDs:(NSArray *)channelIDs completion:(ANKClientCompletionBlock)completionHandler;

- (ANKJSONRequestOperation *)fetchUsersSubscribedToChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)fetchUsersSubscribedToChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)fetchUserIDsSubscribedToChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)fetchUserIDsSubscribedToChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)fetchUserIDsSubscribedToChannelIDs:(NSArray *)channelIDs completion:(ANKClientCompletionBlock)completionHandler;

- (ANKJSONRequestOperation *)fetchMutedChannelsForCurrentUserWithCompletion:(ANKClientCompletionBlock)completionHandler;

- (ANKJSONRequestOperation *)createChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)createChannelWithType:(NSString *)type readers:(ANKACL *)readersACL writers:(ANKACL *)writersACL completion:(ANKClientCompletionBlock)completionHandler;

- (ANKJSONRequestOperation *)updateChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)updateChannelWithID:(NSString *)channelID readers:(ANKACL *)readersACL writers:(ANKACL *)writersACL completion:(ANKClientCompletionBlock)completionHandler;

- (ANKJSONRequestOperation *)subscribeToChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)subscribeToChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)unsubscribeToChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)unsubscribeToChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;

- (ANKJSONRequestOperation *)muteChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)muteChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)unmuteChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (ANKJSONRequestOperation *)unmuteChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;

@end
