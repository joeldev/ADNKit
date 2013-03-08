//
//  ADNChannelCounts.m
//  ADNKit
//
//  Created by Joel Levin on 3/7/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNChannelCounts.h"
#import "NSDictionary+ADNAdditions.h"


@implementation ADNChannelCounts

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] adn_dictionaryByAppendingDictionary:@{@"messages": @"messagesCount"}];
}

@end
