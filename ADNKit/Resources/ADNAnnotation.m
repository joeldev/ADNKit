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


- (ADNResource *)resourceOfClass:(Class)resourceClass forValueKeyPath:(NSString *)keyPath {
	ADNResource *resource = nil;
	id resourceValue = [self.value valueForKeyPath:keyPath];
	if ([resourceValue isKindOfClass:[NSDictionary class]]) {
		resource = [resourceClass objectFromJSONDictionary:resourceValue];
	}
	return resource;
}


@end
