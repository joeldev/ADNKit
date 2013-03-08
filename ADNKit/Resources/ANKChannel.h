//
//  ADNChannel.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKAnnotatableResource.h"


@class ANKUser, ANKChannelCounts, ANKMessage, ANKStreamMarker, ANKACL;

@interface ANKChannel : ANKAnnotatableResource

@property (strong) NSString *channelID;
@property (strong) NSString *type;
@property (strong) ANKUser *owner;
@property (strong) ANKChannelCounts *counts;
@property (strong) NSString *latestMessageID;
@property (strong) ANKMessage *latestMessage;
@property (strong) ANKStreamMarker *marker;
@property (strong) ANKACL *readers;
@property (strong) ANKACL *writers;
@property (assign) BOOL isCurrentUserSubscribed;
@property (assign) BOOL isEditableByCurrentUser;
@property (assign) BOOL hasUnreadMessages;

- (BOOL)isPrivateMessageChannel;

@end
