//
//  ADNACL.m
//  ADNKit
//
//  Created by Joel Levin on 3/7/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKACL.h"


@implementation ANKACL

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] adn_dictionaryByAppendingDictionary:@{
			@"user_ids": @"userIDs",
			@"any_user": @"canAnyUser",
			@"you": @"canCurrentUser",
			@"immutable": @"isImmutable",
			@"public": @"isPublic"}];
}

@end
