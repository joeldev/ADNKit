//
//  ADNImage.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNImage.h"
#import "NSDictionary+ADNAdditions.h"


@implementation ADNImage

+ (NSDictionary *)keyMapping {
	return [[super keyMapping] adn_dictionaryByAppendingDictionary:@{@"url": @"URL", @"is_default": @"isDefault"}];
}


- (CGSize)size {
	return CGSizeMake(self.width, self.height);
}


@end
