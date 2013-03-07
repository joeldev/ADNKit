//
//  ADNMessage.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNAnnotatableResource.h"


@class ADNUser, ADNObjectSource;

@interface ADNMessage : ADNAnnotatableResource

@property (strong) NSString *messageID;
@property (strong) NSString *channelID;
@property (strong) ADNUser *user;
@property (strong) NSDate *createdAt;
@property (strong) NSString *text;
@property (strong) NSString *html;
// TODO: entities
@property (strong) ADNObjectSource *source;
@property (strong) NSString *inReplyToMessageID;
@property (strong) NSString *threadID;
@property (assign) NSUInteger repliesCount;
@property (assign) BOOL isDeleted;
@property (assign) BOOL isMachineOnly;

@end
