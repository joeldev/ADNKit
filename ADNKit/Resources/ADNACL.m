//
//  ADNACL.m
//  ADNKit
//
//  Created by Joel Levin on 3/7/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNACL.h"
#import "NSDictionary+ADNAdditions.h"


@implementation ADNACL

+ (NSDictionary *)keyMapping {
	return [[super keyMapping] adn_dictionaryByAppendingDictionary:@{
			@"user_ids": @"userIDs",
			@"any_user": @"canAnyUser",
			@"you": @"canCurrentUser",
			@"immutable": @"isImmutable",
			@"public": @"isPublic"}];
}

@end
