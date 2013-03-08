//
//  ADNEntity.m
//  ADNKit
//
//  Created by Joel Levin on 3/8/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNEntity.h"
#import "NSDictionary+ADNAdditions.h"


@implementation ADNEntity

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] adn_dictionaryByAppendingDictionary:@{@"pos": @"position", @"len": @"length"}];
}


- (NSRange)range {
	return NSMakeRange(self.position, self.length);
}


@end
