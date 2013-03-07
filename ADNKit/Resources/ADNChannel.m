//
//  ADNChannel.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNChannel.h"
#import "NSDictionary+ADNAdditions.h"


@implementation ADNChannel

+ (NSDictionary *)keyMapping {
	return [[super keyMapping] adn_dictionaryByAppendingDictionary:@{
			@"id": @"channelID",
			@"you_subscribed": @"isCurrentUserSubscribed",
			@"you_can_edit": @"isEditableByCurrentUser",
			@"has_unread": @"hasUnreadMessages",
			@"recent_message_id": @"latestMessageID",
			@"recent_message": @"latestMessage"}];
}

@end
