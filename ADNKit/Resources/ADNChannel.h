//
//  ADNChannel.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNAnnotatableResource.h"


@class ADNUser, ADNChannelCounts, ADNMessage, ADNStreamMarker, ADNACL;

@interface ADNChannel : ADNAnnotatableResource

@property (strong) NSString *channelID;
@property (strong) NSString *type;
@property (strong) ADNUser *owner;
@property (strong) ADNChannelCounts *counts;
@property (strong) NSString *latestMessageID;
@property (strong) ADNMessage *latestMessage;
@property (strong) ADNStreamMarker *marker;
@property (strong) ADNACL *readers;
@property (strong) ADNACL *writers;
@property (assign) BOOL isCurrentUserSubscribed;
@property (assign) BOOL isEditableByCurrentUser;
@property (assign) BOOL hasUnreadMessages;

@end
