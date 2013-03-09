//
//  ADNInteraction.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKInteraction.h"
#import "ANKUser.h"


@implementation ANKInteraction

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] ank_dictionaryByAppendingDictionary:@{@"action": @"actionString", @"event_date": @"eventDate"}];
}


+ (Class)usersCollectionObjectClass {
	return [ANKUser class];
}


@end
