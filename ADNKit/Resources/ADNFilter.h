//
//  ADNFilter.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNResource.h"


typedef NS_ENUM(NSUInteger, ADNFilterMatchPolicy) {
	ADNFilterMatchPolicyIncludeAny = 0,
	ADNFilterMatchPolicyIncludeAll,
	ADNFilterMatchPolicyExcludeAny,
	ADNFilterMatchPolicyExcludeAll
};


@interface ADNFilter : ADNResource

@property (strong) NSString *filterID;
@property (strong) NSString *name;
@property (strong) NSArray *clauses;
@property (strong) NSString *matchPolicyString;

- (ADNFilterMatchPolicy)matchPolicy;

@end
