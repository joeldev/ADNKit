//
//  ADNInteraction.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKInteraction.h"


@implementation ANKInteraction

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] ank_dictionaryByAppendingDictionary:@{@"action": @"actionString", @"event_date": @"eventDate"}];
}

@end
