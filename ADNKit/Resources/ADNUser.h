//
//  ADNUser.h
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNAnnotatableResource.h"


@class ADNUserCounts, ADNImage;

@interface ADNUser : ADNAnnotatableResource

@property (strong) NSString *userID;
@property (strong) NSString *username;
@property (strong) NSString *name;
// TODO: description
@property (strong) NSString *timezone;
@property (strong) NSString *locale;
@property (strong) ADNImage *avatarImage;
@property (strong) ADNImage *coverImage;
@property (strong) NSString *type;
@property (strong) NSDate *createdAt;
@property (strong) ADNUserCounts *counts;
// TODO: follows_you
// TODO: you_follow
// TODO: you_muted
// TODO: you_can_subscribe

@end
