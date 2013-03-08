//
//  ADNLinkEntity.m
//  ADNKit
//
//  Created by Joel Levin on 3/8/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNLinkEntity.h"
#import "NSDictionary+ADNAdditions.h"


@implementation ADNLinkEntity

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] adn_dictionaryByAppendingDictionary:@{@"url": @"URL", @"amended_len": @"amendedLength"}];
}


- (NSRange)amendedRange {
	return NSMakeRange(self.position, self.amendedLength);
}


@end
