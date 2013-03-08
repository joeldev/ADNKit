//
//  ADNMessage.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKMessage.h"


@implementation ANKMessage

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] ank_dictionaryByAppendingDictionary:@{
			@"id": @"messageID",
			@"channel_id": @"channelID",
			@"destinations": @"destinationUserIDs",
			@"created_at": @"createdAt",
			@"reply_to": @"inReplyToMessageID",
			@"thread_id": @"threadID",
			@"num_replies": @"repliesCount",
			@"is_deleted": @"isDeleted",
			@"machine_only": @"isMachineOnly"}];
}

@end
