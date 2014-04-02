//
//  ANKTextConfiguration.m
//  ADNKit
//
//  Created by Rob Brambley on 4/2/14.
//  Copyright (c) 2014 Afterwork Studios. All rights reserved.
//

#import "ANKTextConfiguration.h"

@implementation ANKTextConfiguration

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] ank_dictionaryByAppendingDictionary:@{
            @"uri_template_length": @"URITemplateLength"}];
}

@end
