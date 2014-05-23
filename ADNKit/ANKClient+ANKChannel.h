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

- (AFHTTPRequestOperation *)fetchCurrentUserSubscribedChannelsWithCompletion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchCurrentUserSubscribedChannelsWithTypes:(NSArray *)types completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchCurrentUserPrivateMessageChannelsWithCompletion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchCurrentUserCreatedChannelsWithCompletion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchUnreadPMChannelsCountWithCompletion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)fetchChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchChannelsWithIDs:(NSArray *)channelIDs completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)fetchUsersSubscribedToChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchUsersSubscribedToChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchUserIDsSubscribedToChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchUserIDsSubscribedToChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchUserIDsSubscribedToChannelIDs:(NSArray *)channelIDs completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)fetchMutedChannelsForCurrentUserWithCompletion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)createChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)createChannelWithType:(NSString *)type readers:(ANKACL *)readersACL writers:(ANKACL *)writersACL completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)updateChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)updateChannelWithID:(NSString *)channelID readers:(ANKACL *)readersACL writers:(ANKACL *)writersACL completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)subscribeToChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)subscribeToChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)unsubscribeToChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)unsubscribeToChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)muteChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)muteChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)unmuteChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)unmuteChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)deactivateChannel:(ANKChannel *)channel completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)deactivateChannelWithID:(NSString *)channelID completion:(ANKClientCompletionBlock)completionHandler;

@end
