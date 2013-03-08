//
//  ADNChannel.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNChannel.h"
#import "ADNACL.h"
#import "NSDictionary+ADNAdditions.h"


@implementation ADNChannel

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
	return self.isCurrentUserSubscribed && !self.readers.canAnyUser && !self.readers.isPublic && !self.writers.canAnyUser && !self.writers.isPublic;
}


@end
