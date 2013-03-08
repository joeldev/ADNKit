//
//  ADNFilterClause.m
//  ADNKit
//
//  Created by Joel Levin on 3/7/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNFilterClause.h"
#import "NSDictionary+ADNAdditions.h"


@implementation ADNFilterClause

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] adn_dictionaryByAppendingDictionary:@{@"object_type": @"objectType"}];
}


- (ADNFilterClauseOperator)clauseOperator {
	static NSDictionary *operatorMapping = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		operatorMapping = [@{@"equals": @(ADNFilterClauseOperatorEquals), @"matches": @(ADNFilterClauseOperatorMatches), @"lt": @(ADNFilterClauseOperatorLessThan), @"le": @(ADNFilterClauseOperatorLessThanOrEquals), @"gt": @(ADNFilterClauseOperatorGreaterThan), @"ge": @(ADNFilterClauseOperatorGreaterThanOrEquals), @"one_of": @(ADNFilterClauseOperatorOneOf)} copy];
	});
	return (ADNFilterClauseOperator)[operatorMapping[self.operatorString] unsignedIntegerValue];
}


@end
