//
//  ANKSearchQuery.m
//  ADNKit
//
//  Created by Kolin Krewinkel on 7/25/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKSearchQuery.h"

@implementation ANKSearchQuery

#pragma mark -
#pragma mark ANKResource

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] ank_dictionaryByAppendingDictionary:@{
			@"index": @"indexType",
			@"order": @"orderType"}];
}

#pragma mark -
#pragma mark Initialization


- (id)init
{
    if ((self = [super init])) {
        [self setDefaultFilterInclusionTypes];
    }

    return self;
}

- (void)setDefaultFilterInclusionTypes
{
    self.isReply = ANKSearchQueryInclusionTypeUnspecified;
    self.isDirected = ANKSearchQueryInclusionTypeUnspecified;
    self.hasLocation = ANKSearchQueryInclusionTypeUnspecified;
    self.hasCheckin = ANKSearchQueryInclusionTypeUnspecified;
    self.isCrosspost = ANKSearchQueryInclusionTypeUnspecified;
    self.hasAttachment = ANKSearchQueryInclusionTypeUnspecified;
    self.hasOEmbedPhoto = ANKSearchQueryInclusionTypeUnspecified;
    self.hasOEmbedVideo = ANKSearchQueryInclusionTypeUnspecified;
    self.hasOEmbedHTML5Video = ANKSearchQueryInclusionTypeUnspecified;
    self.hasOEmbedRich = ANKSearchQueryInclusionTypeUnspecified;
}

@end
