//
//  ANKGeneralParameters.m
//  ADNKit
//
//  Created by Joel Levin on 5/21/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKGeneralParameters.h"


@implementation ANKGeneralParameters

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] ank_dictionaryByAppendingDictionary:@{
			@"include_muted": @"includeMuted",
			@"include_deleted": @"includeDeleted",
			@"include_directed_posts": @"includeDirectedPosts",
			@"include_machine": @"includeMachine",
			@"include_starred_by": @"includeStarredBy",
			@"include_reposters": @"includeReposters",
			@"include_annotations": @"includeAnnotations",
			@"include_post_annotations": @"includePostAnnotations",
			@"include_user_annotations": @"includeUserAnnotations",
			@"include_html": @"includeHTML"}];
}

@end
