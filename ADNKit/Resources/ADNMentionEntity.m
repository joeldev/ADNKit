//
//  ADNMentionEntity.m
//  ADNKit
//
//  Created by Joel Levin on 3/8/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNMentionEntity.h"
#import "NSDictionary+ADNAdditions.h"


@implementation ADNMentionEntity

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] adn_dictionaryByAppendingDictionary:@{@"name": @"username", @"id": @"userID"}];
}

@end
