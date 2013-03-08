//
//  ADNUser.h
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKAnnotatableResource.h"


// Descriptions for User fields:
// http://developers.app.net/docs/resources/user/#user-fields


@class ANKUserCounts, ANKUserDescription, ANKImage;

@interface ANKUser : ANKAnnotatableResource

@property (strong) NSString *userID;
@property (strong) NSString *username;
@property (strong) NSString *name;
@property (strong) ANKUserDescription *bio;
@property (strong) NSString *timezone;
@property (strong) NSString *locale;
@property (strong) ANKImage *avatarImage;
@property (strong) ANKImage *coverImage;
@property (strong) NSString *type;
@property (strong) NSDate *createdAt;
@property (strong) ANKUserCounts *counts;
@property (assign) BOOL followsCurrentUser;
@property (assign) BOOL currentUserFollows;
@property (assign) BOOL currentUserMuted;
@property (assign) BOOL currentUserCanSubscribe;

@end
