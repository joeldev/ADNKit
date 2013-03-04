//
//  ADNResponse.m
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNResponse.h"


@interface ADNResponse ()

@property (readwrite, strong) id data;

@end


@implementation ADNResponse

- (id)initWithResponseObject:(id)responseObject {
	if ((self = [super init])) {
		if ([responseObject isKindOfClass:[NSDictionary class]]) {
			NSDictionary *responseDictionary = (NSDictionary *)responseObject;
			self.data = responseDictionary[@"data"];
			// TODO: deal with meta
			// TODO: look for and expose errors and error codes
		}
	}
	return self;
}

@end
