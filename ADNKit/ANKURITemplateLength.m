//
//  ANKURITemplateLength.m
//  ADNKit
//
//  Created by Rob Brambley on 4/2/14.
//  Copyright (c) 2014 Afterwork Studios. All rights reserved.
//

#import "ANKURITemplateLength.h"

@implementation ANKURITemplateLength

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] ank_dictionaryByAppendingDictionary:@{
            @"post_id": @"postID",
            @"message_id": @"messageID"}];
}

@end
