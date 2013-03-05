//
//  ADNPost.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNAnnotatableResource.h"


// Descriptions for Post fields
// http://developers.app.net/docs/resources/post/#post-fields


@class ADNUser, ADNObjectSource;

@interface ADNPost : ADNAnnotatableResource

@property (strong) NSString *postID;
@property (strong) ADNUser *user;
@property (strong) NSDate *createdAt;
@property (strong) NSString *text;
@property (strong) NSString *html;
// TODO: entities
@property (strong) ADNObjectSource *source;
@property (strong) NSString *repliedToPostID;
@property (strong) NSURL *canonicalURL;
@property (strong) NSString *threadID;
@property (assign) NSUInteger repliesCount;
@property (assign) NSUInteger starsCount;
@property (assign) NSUInteger repostsCount;
@property (assign) BOOL isDeleted;
@property (assign) BOOL isMachineOnly;
@property (assign) BOOL isStarredByCurrentUser;
@property (strong) NSArray *starredByUsers;
@property (assign) BOOL repostedByCurrentUser;
@property (strong) NSArray *reposters;
@property (strong) ADNPost *repostedPost;

@end
