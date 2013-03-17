//
//  ADNAnnotation.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKAnnotation.h"


@interface ANKAnnotation ()

- (ANKResource *)resourceOfClass:(Class)resourceClass forValue:(id)resourceValue;

@end


@implementation ANKAnnotation

+ (instancetype)annotationWithType:(NSString *)type value:(NSDictionary *)value {
	ANKAnnotation *annotation = [[ANKAnnotation alloc] init];
	annotation.type = type;
	annotation.value = value;
	return annotation;
}


+ (instancetype)annotationWithType:(NSString *)type object:(ANKResource *)resource {
	NSDictionary *value = nil;
	if ([resource conformsToProtocol:@protocol(ANKAnnotationReplacement)]) {
		ANKResource <ANKAnnotationReplacement> *replaceableResource = (ANKResource <ANKAnnotationReplacement> *)resource;
		value = [replaceableResource annotationValue];
	} else {
		value = [resource JSONDictionary];
	}
	return [[self class] annotationWithType:type value:value];
}


- (NSString *)description {
	return [NSString stringWithFormat:@"<%@ %p> - %@: %@", NSStringFromClass([self class]), self, self.type, self.value];
}


- (ANKResource *)resourceOfClassForValue:(Class)resourceClass {
	return [self resourceOfClass:resourceClass forValue:self.value];
}


- (ANKResource *)resourceOfClass:(Class)resourceClass forValueKeyPath:(NSString *)keyPath {
	return [self resourceOfClass:resourceClass forValue:[self.value valueForKeyPath:keyPath]];
}


- (ANKResource *)resourceOfClass:(Class)resourceClass forValue:(id)resourceValue {
	ANKResource *resource = nil;
	if ([resourceValue isKindOfClass:[NSDictionary class]] && [resourceClass isSubclassOfClass:[ANKResource class]]) {
		resource = [resourceClass objectFromJSONDictionary:resourceValue];
	}
	return resource;
}


@end
