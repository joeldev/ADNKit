//
//  ADNFilterClause.h
//  ADNKit
//
//  Created by Joel Levin on 3/7/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNResource.h"


typedef NS_ENUM(NSUInteger, ADNFilterClauseOperator) {
	ADNFilterClauseOperatorEquals = 0,
	ADNFilterClauseOperatorMatches,
	ADNFilterClauseOperatorLessThan,
	ADNFilterClauseOperatorLessThanOrEquals,
	ADNFilterClauseOperatorGreaterThan,
	ADNFilterClauseOperatorGreaterThanOrEquals,
	ADNFilterClauseOperatorOneOf
};


@interface ADNFilterClause : ADNResource

@property (strong) NSString *objectType;
@property (strong) NSString *operatorString;
@property (strong) NSString *field;
@property (strong) id value;

- (ADNFilterClauseOperator)clauseOperator;

@end
