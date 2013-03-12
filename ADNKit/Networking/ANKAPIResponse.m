//
//  ADNResponse.m
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKAPIResponse.h"
#import "ANKAPIResponseMeta.h"


@interface ANKAPIResponse ()

@property (readwrite, strong) id data;
@property (readwrite, strong) ANKAPIResponseMeta *meta;

@end


@implementation ANKAPIResponse

- (id)initWithResponseObject:(id)responseObject {
	if ((self = [super init])) {
		if ([responseObject isKindOfClass:[NSDictionary class]]) {
			NSDictionary *responseDictionary = (NSDictionary *)responseObject;
			self.data = responseDictionary[@"data"];
			self.meta = [ANKAPIResponseMeta objectFromJSONDictionary:responseDictionary[@"meta"]];
		}
	}
	return self;
}

@end
