//
//  ADNAnnotation.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNAnnotation.h"


@implementation ADNAnnotation

+ (instancetype)annotationWithType:(NSString *)type value:(NSDictionary *)value {
	ADNAnnotation *annotation = [[ADNAnnotation alloc] init];
	annotation.type = type;
	annotation.value = value;
	return annotation;
}


- (NSString *)description {
	return [NSString stringWithFormat:@"<%@ %p> - %@: %@", NSStringFromClass([self class]), self, self.type, self.value];
}


@end
