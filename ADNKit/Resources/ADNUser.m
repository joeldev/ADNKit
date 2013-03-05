//
//  ADNUser.m
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNUser.h"
#import "NSDictionary+ADNAdditions.h"


@implementation ADNUser

+ (NSDictionary *)keyMapping {
	return [[super keyMapping] adn_dictionaryByAppendingDictionary:
			@{@"id" : @"userID",
			@"created_at": @"createdAt",
			@"avatar_image": @"avatarImage",
			@"cover_image": @"coverImage",
			@"follows_you": @"followsYou",
			@"you_follow": @"youFollow",
			@"you_muted": @"youMuted",
			@"you_can_subscribe": @"youCanSubscribe"}];
}


- (NSString *)description {
	return [NSString stringWithFormat:@"<%@ %p> - %@ (@%@)", NSStringFromClass([self class]), self, self.name, self.username];
}


@end
