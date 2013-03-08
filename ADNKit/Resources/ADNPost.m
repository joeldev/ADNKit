//
//  ADNPost.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNPost.h"
#import "ADNUser.h"
#import "NSDictionary+ADNAdditions.h"


@implementation ADNPost

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] adn_dictionaryByAppendingDictionary:@{
			@"id": @"postID",
			@"created_at": @"createdAt",
			@"reply_to": @"repliedToPostID",
			@"canonical_url": @"canonicalURL",
			@"thread_id": @"threadID",
			@"num_replies": @"repliesCount",
			@"num_stars": @"starsCount",
			@"num_reposts": @"repostsCount",
			@"is_deleted": @"isDeleted",
			@"machine_only": @"isMachineOnly",
			@"you_starred": @"isStarredByCurrentUser",
			@"starred_by": @"starredByUsers",
			@"you_reposted": @"isRepostedByCurrentUser",
			@"repost_of": @"repostedPost"}];
}


+ (Class)starredByUsersCollectionObjectClass {
	return [ADNUser class];
}


+ (Class)repostersCollectionObjectClass {
	return [ADNUser class];
}


- (NSString *)description {
	return [NSString stringWithFormat:@"<%@ %p> - @%@: %@", NSStringFromClass([self class]), self, self.user.username, self.text];
}


@end
