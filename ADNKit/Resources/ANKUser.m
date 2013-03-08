//
//  ADNUser.m
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKUser.h"


@implementation ANKUser

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] adn_dictionaryByAppendingDictionary:
			@{@"id" : @"userID",
			@"description": @"bio",
			@"created_at": @"createdAt",
			@"avatar_image": @"avatarImage",
			@"cover_image": @"coverImage",
			@"follows_you": @"followsCurrentUser",
			@"you_follow": @"currentUserFollows",
			@"you_muted": @"currentUserMuted",
			@"you_can_subscribe": @"currentUserCanSubscribe"}];
}


- (NSString *)description {
	return [NSString stringWithFormat:@"<%@ %p> - %@ (@%@)", NSStringFromClass([self class]), self, self.name, self.username];
}


@end
