//
//  ADNResource.m
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNResource.h"
#import "NSArray+ADNAdditions.h"
#import "ADNValueTransformations.h"
#import <objc/runtime.h>


static NSMutableDictionary *propertiesMap = nil;
static dispatch_once_t propertiesMapOnceToken;


// internal class representing a single property for a class
@interface ADNResourceProperty : NSObject

@property (strong) NSString *name;
@property (assign) Class objectType;
@property (strong) NSString *primitiveTypeName;

- (id)initWithName:(NSString *)name attributesString:(NSString *)attributesString;

@end


@implementation ADNResourceProperty

- (id)initWithName:(NSString *)name attributesString:(NSString *)attributesString {
	if ((self = [super init])) {
		self.name = name;
		
		NSScanner *scanner = [NSScanner scannerWithString:attributesString];
		[scanner scanUpToString:@"T" intoString:nil];
		[scanner setScanLocation:[scanner scanLocation] + 1]; // advance past 'T'
		
		NSString *propertyType = nil;
		
		if ([scanner scanString:@"@\"" intoString:&propertyType]) {
			// this is a class
			[scanner scanCharactersFromSet:[NSCharacterSet alphanumericCharacterSet] intoString:&propertyType];
			self.objectType = NSClassFromString(propertyType);
		} else {
			// primitive
			[scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@","] intoString:&propertyType];
			self.primitiveTypeName = propertyType;
		}
	}
	return self;
}

@end


@interface ADNResource ()

+ (NSDictionary *)inverseKeyMapping;

@end


@implementation ADNResource

+ (void)initialize {
	dispatch_once(&propertiesMapOnceToken, ^{
		propertiesMap = [[NSMutableDictionary alloc] init];
	});
	
	NSMutableDictionary *propertiesForClass = [NSMutableDictionary dictionary];
	propertiesMap[NSStringFromClass([self class])] = propertiesForClass;
	
	unsigned int propertyCount = 0;
	objc_property_t *propertiesList = class_copyPropertyList([self class], &propertyCount);
	for (unsigned int i = 0; i < propertyCount; i++) {
		objc_property_t property = propertiesList[i];
		ADNResourceProperty *propertyObject = [[ADNResourceProperty alloc] initWithName:[NSString stringWithUTF8String:property_getName(property)] attributesString:[NSString stringWithUTF8String:property_getAttributes(property)]];
		propertiesForClass[propertyObject.name] = propertyObject;
	}
	
	free(propertiesList);
}


+ (NSDictionary *)keyMapping {
	return @{};
}


+ (NSDictionary *)inverseKeyMapping {
	static NSMutableDictionary *inverseKeyMap = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		inverseKeyMap = [[NSMutableDictionary alloc] init];
		NSDictionary *regularKeyMapping = [self keyMapping];
		for (NSString *serverKey in regularKeyMapping) {
			NSString *localKey = regularKeyMapping[serverKey];
			inverseKeyMap[localKey] = serverKey;
		}
	});	
	return inverseKeyMap;
}


+ (instancetype)objectFromJSONDictionary:(NSDictionary *)dictionary {
	return [[[self class] alloc] initWithJSONDictionary:dictionary];
}


+ (NSArray *)objectsFromJSONDictionaries:(NSArray *)dictionaries {
	return [dictionaries adn_map:^id(id object) {
		return [self objectFromJSONDictionary:object];
	}];
}


- (id)initWithJSONDictionary:(NSDictionary *)JSONDictionay {
	if ((self = [super init])) {
		[self updateObjectFromJSONDictionary:JSONDictionay];
	}
	return self;
}


- (void)updateObjectFromJSONDictionary:(NSDictionary *)JSONDictionary {
	NSString *className = NSStringFromClass([self class]);
	
	for (NSString *JSONKey in JSONDictionary) {
		// first, see if there's a mapped key to use here
		NSString *localKey = [[self class] keyMapping][JSONKey] ?: JSONKey;
		
		// next, pull out the value and class of the value
		id value = JSONDictionary[JSONKey];
		
		// look up info about the local property
		ADNResourceProperty *property = propertiesMap[className][localKey];
		if (property) {
			if (![[value class] isKindOfClass:property.objectType]) {
				SEL transformSelector = NSSelectorFromString([NSString stringWithFormat:@"%@From%@", property.objectType, [value class]]);
				if ([ADNValueTransformations respondsToSelector:transformSelector]) {
					value = [ADNValueTransformations performSelector:transformSelector];
				} else {
					NSLog(@"could not find a method to convert %@ of class %@ to class %@ (%@)", value, [value class], property.objectType, NSStringFromSelector(transformSelector));
				}
			}
			
			[self setValue:value forKey:localKey];
		}
	}
}


- (NSDictionary *)JSONDictionary {
	// TODO
	return nil;
}


@end
