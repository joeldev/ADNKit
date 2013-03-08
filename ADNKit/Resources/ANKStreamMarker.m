//
//  ADNStreamMarker.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKStreamMarker.h"


@implementation ANKStreamMarker

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] adn_dictionaryByAppendingDictionary:@{
			@"version": @"identifier",
			@"id": @"topPostID",
			@"last_read_id": @"lastReadPostID",
			@"name": @"streamName",
			@"updated_at": @"updatedAt"}];
}

@end
