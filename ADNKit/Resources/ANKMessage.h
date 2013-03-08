//
//  ADNMessage.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKAnnotatableResource.h"


@class ANKUser, ANKObjectSource, ANKEntities;

@interface ANKMessage : ANKAnnotatableResource

@property (strong) NSString *messageID;
@property (strong) NSString *channelID;
@property (strong) NSArray *destinationUserIDs;
@property (strong) ANKUser *user;
@property (strong) NSDate *createdAt;
@property (strong) NSString *text;
@property (strong) NSString *html;
@property (strong) ANKEntities *entities;
@property (strong) ANKObjectSource *source;
@property (strong) NSString *inReplyToMessageID;
@property (strong) NSString *threadID;
@property (assign) NSUInteger repliesCount;
@property (assign) BOOL isDeleted;
@property (assign) BOOL isMachineOnly;

@end
