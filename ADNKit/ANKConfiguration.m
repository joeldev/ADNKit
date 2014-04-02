//
//  ANKConfiguration.m
//  ADNKit
//
//  Created by Rob Brambley on 4/2/14.
//  Copyright (c) 2014 Afterwork Studios. All rights reserved.
//

#import "ANKConfiguration.h"

@implementation ANKConfiguration
+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] ank_dictionaryByAppendingDictionary:@{
            @"text": @"text",
            @"user": @"user",
            @"file": @"file",
            @"post": @"post",
            @"message": @"message",
            @"channel": @"channel"}];
}

@end
