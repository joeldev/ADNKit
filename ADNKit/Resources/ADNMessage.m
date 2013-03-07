//
//  ADNMessage.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNMessage.h"
#import "NSDictionary+ADNAdditions.h"


@implementation ADNMessage

+ (NSDictionary *)keyMapping {
	return [[super keyMapping] adn_dictionaryByAppendingDictionary:@{
			@"id": @"messageID",
			@"channel_id": @"channelID",
			@"created_at": @"createdAt",
			@"reply_to": @"inReplyToMessageID",
			@"thread_id": @"threadID",
			@"num_replies": @"repliesCount",
			@"is_deleted": @"isDeleted",
			@"machine_only": @"isMachineOnly"}];
}

@end
