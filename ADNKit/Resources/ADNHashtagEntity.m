//
//  ADNHashtagEntity.m
//  ADNKit
//
//  Created by Joel Levin on 3/8/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNHashtagEntity.h"
#import "NSDictionary+ADNAdditions.h"


@implementation ADNHashtagEntity

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] adn_dictionaryByAppendingDictionary:@{@"name": @"hashtag"}];
}

@end
