//
//  ADNChannel.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKChannel.h"
#import "ANKACL.h"


@implementation ANKChannel

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] adn_dictionaryByAppendingDictionary:@{
			@"id": @"channelID",
			@"you_subscribed": @"isCurrentUserSubscribed",
			@"you_can_edit": @"isEditableByCurrentUser",
			@"has_unread": @"hasUnreadMessages",
			@"recent_message_id": @"latestMessageID",
			@"recent_message": @"latestMessage"}];
}


- (BOOL)isPrivateMessageChannel {
	return [self.type isEqualToString:@"net.app.core.pm"];
}


@end
