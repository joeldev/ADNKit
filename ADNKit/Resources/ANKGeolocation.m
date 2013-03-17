//
//  ANKGeolocation.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/17/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKGeolocation.h"


@implementation ANKGeolocation

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] ank_dictionaryByAppendingDictionary:@{@"horizontal_accuracy": @"horizontalAccuracy", @"vertical_accuracy": @"verticalAccuracy"}];
}

@end
