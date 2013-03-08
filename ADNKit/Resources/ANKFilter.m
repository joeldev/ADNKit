//
//  ADNFilter.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKFilter.h"
#import "ANKFilterClause.h"


@implementation ANKFilter

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] ank_dictionaryByAppendingDictionary:@{@"id": @"filterID", @"match_policy": @"matchPolicyString"}];
}


+ (Class)clausesCollectionObjectClass {
	return [ANKFilterClause class];
}


- (ADNFilterMatchPolicy)matchPolicy {
	static NSDictionary *matchPolicyStringMap = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		matchPolicyStringMap = [@{@"include_any": @(ADNFilterMatchPolicyIncludeAny), @"include_all": @(ADNFilterMatchPolicyIncludeAll), @"exclude_any": @(ADNFilterMatchPolicyExcludeAny), @"exclude_all": @(ADNFilterMatchPolicyExcludeAll)} copy];
	});
	return (ADNFilterMatchPolicy)[matchPolicyStringMap[self.matchPolicyString] unsignedIntegerValue];
}


@end
