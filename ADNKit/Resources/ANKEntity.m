//
//  ADNEntity.m
//  ADNKit
//
//  Created by Joel Levin on 3/8/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKEntity.h"


@implementation ANKEntity

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] ank_dictionaryByAppendingDictionary:@{@"pos": @"position", @"len": @"length"}];
}


- (NSRange)range {
	return NSMakeRange(self.position, self.length);
}


@end
