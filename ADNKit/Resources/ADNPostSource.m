//
//  ADNPostSource.m
//  ADNKit
//
//  Created by Joel Levin on 3/5/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNPostSource.h"
#import "NSDictionary+ADNAdditions.h"


@implementation ADNPostSource

+ (NSDictionary *)keyMapping {
	return [[super keyMapping] adn_dictionaryByAppendingDictionary:@{@"client_id": @"clientID"}];
}

@end
