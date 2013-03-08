//
//  ADNHashtagEntity.m
//  ADNKit
//
//  Created by Joel Levin on 3/8/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKHashtagEntity.h"


@implementation ANKHashtagEntity

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] ank_dictionaryByAppendingDictionary:@{@"name": @"hashtag"}];
}

@end
