//
//  ADNAnnotation.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNAnnotation.h"


@interface ADNAnnotation ()

- (ADNResource *)resourceOfClass:(Class)resourceClass forValue:(id)resourceValue;

@end


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


- (ADNResource *)resourceOfClassForValue:(Class)resourceClass {
	return [self resourceOfClass:resourceClass forValue:self.value];
}


- (ADNResource *)resourceOfClass:(Class)resourceClass forValueKeyPath:(NSString *)keyPath {
	return [self resourceOfClass:resourceClass forValue:[self.value valueForKeyPath:keyPath]];
}


- (ADNResource *)resourceOfClass:(Class)resourceClass forValue:(id)resourceValue {
	ADNResource *resource = nil;
	if ([resourceValue isKindOfClass:[NSDictionary class]] && [resourceClass isSubclassOfClass:[ADNResource class]]) {
		resource = [resourceClass objectFromJSONDictionary:resourceValue];
	}
	return resource;
}


@end
