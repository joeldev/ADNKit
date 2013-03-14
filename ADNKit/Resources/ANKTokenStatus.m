//
//  ANKTokenStatus.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/14/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKTokenStatus.h"


@implementation ANKTokenStatus

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] ank_dictionaryByAppendingDictionary:@{@"client_id": @"clientID"}];
}

@end
