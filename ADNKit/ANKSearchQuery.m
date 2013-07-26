//
//  ANKSearchQuery.m
//  ADNKit
//
//  Created by Kolin Krewinkel on 7/25/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKSearchQuery.h"

@implementation ANKSearchQuery

#pragma mark -
#pragma mark ANKResource

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] ank_dictionaryByAppendingDictionary:@{
			@"index": @"indexType",
			@"order": @"orderType"}];
}

#pragma mark -
#pragma mark Initialization


- (id)init
{
    if ((self = [super init])) {
 
    }

    return self;
}

@end
