//
//  ANKOEmbed.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/17/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKOEmbed.h"


@implementation ANKOEmbed

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] ank_dictionaryByAppendingDictionary:@{
			@"url": @"URL",
			@"embeddable_url": @"embeddableURL",
			@"author_name": @"authorName",
			@"author_url": @"authorURL",
			@"provider_name": @"providerName",
			@"provider_url": @"providerURL",
			@"cache_age": @"cacheAge",
			@"thumbnail_url": @"thumbnailURL",
			@"thumbnail_width": @"thumbnailWidth",
			@"thumbnail_height": @"thumbnailHeight"}];
}

@end
