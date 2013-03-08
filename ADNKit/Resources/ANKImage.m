//
//  ADNImage.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKImage.h"


@implementation ANKImage

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] ank_dictionaryByAppendingDictionary:@{@"url": @"URL", @"is_default": @"isDefault"}];
}


- (CGSize)size {
	return CGSizeMake(self.width, self.height);
}


@end
