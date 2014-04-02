//
//  ANKResourceConfiguration.m
//  ADNKit
//
//  Created by Rob Brambley on 4/2/14.
//  Copyright (c) 2014 Afterwork Studios. All rights reserved.
//

#import "ANKResourceConfiguration.h"

@implementation ANKResourceConfiguration
+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] ank_dictionaryByAppendingDictionary:@{
            @"annotation_max_bytes": @"annotationMaxBytes",
            @"text_max_length": @"textMaxLength"}];
}

@end
