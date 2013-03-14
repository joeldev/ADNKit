//
//  ADNPost.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKAnnotatableResource.h"


// Descriptions for Post fields
// http://developers.app.net/docs/resources/post/#post-fields


@class ANKUser, ANKObjectSource, ANKEntities;

@interface ANKPost : ANKAnnotatableResource

@property (strong) NSString *postID;
@property (strong) ANKUser *user;
@property (strong) NSDate *createdAt;
@property (strong) NSString *text;
@property (strong) NSString *html;
@property (strong) ANKEntities *entities;
@property (strong) ANKObjectSource *source;
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
@property (assign) BOOL isRepostedByCurrentUser;
@property (strong) NSArray *reposters;
@property (strong) ANKPost *repostedPost;

// this does not come from the server, nor is it returned as a key in -JSONDictionary. It is meant for
// easy caching from the client to encourage not generating the attributed string more than once.
@property (strong) NSAttributedString *attributedText;

- (BOOL)containsMentionForUsername:(NSString *)username;

@end
