//
//  ADNPostSource.m
//  ADNKit
//
//  Created by Joel Levin on 3/5/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNObjectSource.h"
#import "NSDictionary+ADNAdditions.h"


@implementation ADNObjectSource

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] adn_dictionaryByAppendingDictionary:@{@"client_id": @"clientID"}];
}

@end
