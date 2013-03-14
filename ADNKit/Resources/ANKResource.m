//
//  ADNResource.m
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKResource.h"
#import "ANKValueTransformations.h"
#import <objc/runtime.h>


static NSMutableDictionary *propertiesMap = nil;
static dispatch_once_t propertiesMapOnceToken;


// internal class representing a single property for a class
@interface ANKResourceProperty : NSObject

@property (strong) NSString *name;
@property (assign) Class objectType;
@property (assign) BOOL isPrimitive;
@property (assign) BOOL isModelObject;
@property (assign) BOOL isCollection;

- (id)initWithName:(NSString *)name attributesString:(NSString *)attributesString forParentClass:(Class)parentClass;

@end


@implementation ANKResourceProperty

- (id)initWithName:(NSString *)name attributesString:(NSString *)attributesString forParentClass:(Class)parentClass {
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
			
			self.isModelObject = [self.objectType isSubclassOfClass:[ANKResource class]];
			if (self.objectType == [NSArray class]) {
				SEL collectionObjectClass = NSSelectorFromString([NSString stringWithFormat:@"%@CollectionObjectClass", self.name]);
				if ([parentClass respondsToSelector:collectionObjectClass]) {
					#pragma clang diagnostic push
					#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
					self.objectType = [parentClass performSelector:collectionObjectClass];
					#pragma clang diagnostic pop
					
					// this is only marked as a collection if its a collection of model objects
					self.isCollection = [self.objectType isSubclassOfClass:[ANKResource class]];
				}
			}
		} else {
			// primitive
			self.isPrimitive = YES;
		}
	}
	return self;
}

@end


@interface ANKResource ()

+ (NSDictionary *)inverseKeyMapping;

- (void)updateObjectFromJSONDictionary:(NSDictionary *)JSONDictionary forClass:(Class)class;
- (NSDictionary *)JSONDictionaryForClass:(Class)class;

@end


@implementation ANKResource

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
		ANKResourceProperty *propertyObject = [[ANKResourceProperty alloc] initWithName:[NSString stringWithUTF8String:property_getName(property)] attributesString:[NSString stringWithUTF8String:property_getAttributes(property)] forParentClass:[self class]];
		propertiesForClass[propertyObject.name] = propertyObject;
	}
	
	free(propertiesList);
}


+ (NSDictionary *)JSONToLocalKeyMapping {
	return @{};
}


+ (NSDictionary *)inverseKeyMapping {
	static NSMutableDictionary *inverseKeyMap = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		inverseKeyMap = [[NSMutableDictionary alloc] init];
		NSDictionary *regularKeyMapping = [self JSONToLocalKeyMapping];
		for (NSString *serverKey in regularKeyMapping) {
			NSString *localKey = regularKeyMapping[serverKey];
			inverseKeyMap[localKey] = serverKey;
		}
	});	
	return inverseKeyMap;
}


+ (NSString *)JSONKeyForLocalKey:(NSString *)localKey {
	return [[self class] inverseKeyMapping][localKey] ?: localKey;
}


+ (NSString *)localKeyForJSONKey:(NSString *)JSONKey {
	return [[self class] JSONToLocalKeyMapping][JSONKey] ?: JSONKey;
}


+ (NSSet *)localKeysExcludedFromJSONOutput {
	return nil;
}


+ (instancetype)objectFromJSONDictionary:(NSDictionary *)dictionary {
	return [[[self class] alloc] initWithJSONDictionary:dictionary];
}


+ (NSArray *)objectsFromJSONDictionaries:(NSArray *)dictionaries {
	return [dictionaries ank_map:^id(id object) {
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
	[self updateObjectFromJSONDictionary:JSONDictionary forClass:[self class]];
}


- (void)updateObjectFromJSONDictionary:(NSDictionary *)JSONDictionary forClass:(Class)class {
	for (NSString *JSONKey in JSONDictionary) {
		// first, see if there's a mapped key to use here
		NSString *localKey = [class JSONToLocalKeyMapping][JSONKey] ?: JSONKey;
		
		// next, pull out the value and class of the value
		id value = JSONDictionary[JSONKey];
		Class valueClass = [value class];
		NSString *valueClassString = NSStringFromClass(valueClass);
		
		// convert things like __NSCFString to NSString, and __NSCFDictionary to NSDictionary
		if ([valueClassString hasPrefix:@"__NSCF"]) {
			NSString *publicClassType = [NSString stringWithFormat:@"NS%@", [valueClassString substringFromIndex:[@"__NSCF" length]]];
			Class publicClass = NSClassFromString(publicClassType);
			if (publicClass) {
				valueClass = publicClass;
			}
		}
		
		// look up info about the local property
		ANKResourceProperty *property = propertiesMap[NSStringFromClass(class)][localKey];
		
		// if we couldn't find the property, walk up until we either do or run out of superclasses
		Class superclass = class_getSuperclass(class);
		while (!property) {
			if (![superclass isSubclassOfClass:[ANKResource class]]) {
				break;
			}
			property = propertiesMap[NSStringFromClass(superclass)][localKey];
			superclass = class_getSuperclass(superclass);
		}
		
		if (property) {
			if (valueClass != property.objectType && !property.isPrimitive) {
				if (property.isCollection && [value isKindOfClass:[NSArray class]]) {
					// property is a collection, so unpack the collection
					value = [property.objectType objectsFromJSONDictionaries:value];
				} else if (property.isModelObject && [value isKindOfClass:[NSDictionary class]]) {
					// property is an ADNResource, unpack it
					value = [property.objectType objectFromJSONDictionary:value];
				} else {
					// see if there's an existing transformation that we can run
					SEL transformSelector = NSSelectorFromString([NSString stringWithFormat:@"%@From%@:", property.objectType, valueClass]);
					if ([[ANKValueTransformations transformations] respondsToSelector:transformSelector]) {
						#pragma clang diagnostic push
						#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
						value = [[ANKValueTransformations transformations] performSelector:transformSelector withObject:value];
						#pragma clang diagnostic pop
					} else {
						NSLog(@"could not find a method to convert %@ of class %@ to class %@ (%@)", value, valueClass, property.objectType, NSStringFromSelector(transformSelector));
					}
				}
			}
			
			[self setValue:value forKey:localKey];
		}
	}
}


- (void)objectDidUpdate {
	// override me!
}


- (NSDictionary *)JSONDictionary {
	return [self JSONDictionaryForClass:[self class]];
}


- (NSDictionary *)JSONDictionaryForClass:(Class)class {
	NSMutableDictionary *JSONDictionary = [NSMutableDictionary dictionary];
	NSDictionary *propertiesForClass = propertiesMap[NSStringFromClass(class)];
	
	// if we have properties for the superclass, add those in too (which will walk the tree up until we hit ADNResource and won't go higher
	Class superclass = class_getSuperclass(class);
	if (propertiesMap[NSStringFromClass(superclass)]) {
		[JSONDictionary addEntriesFromDictionary:[self JSONDictionaryForClass:superclass]];
	}
	
	for (NSString *localKey in propertiesForClass) {
		if ([[[self class] localKeysExcludedFromJSONOutput] containsObject:localKey]) {
			// skip this key, it is marked as excluded
			continue;
		}
		
		ANKResourceProperty *property = propertiesForClass[localKey];
		
		// figure out the JSON key
		NSString *remoteKey = [class inverseKeyMapping][localKey] ?: localKey;
		
		// grab the value and transform it if necessary
		id value = [self valueForKey:localKey];
		
		// if the property is a model object, convert it to a JSON dictionary
		if (property.isModelObject) {
			value = [(ANKResource *)value JSONDictionary];
		} else if (property.isCollection) {
			value = [(NSArray *)value ank_map:^id(ANKResource *resource) {
				return [resource JSONDictionary];
			}];
		} else {
			// otherwise, see if it needs to be transformed in order to be JSON compatible
			SEL transformSelector = NSSelectorFromString([NSString stringWithFormat:@"JSONObjectFrom%@:", NSStringFromClass([value class])]);
			if ([[ANKValueTransformations transformations] respondsToSelector:transformSelector]) {
				#pragma clang diagnostic push
				#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
				value = [[ANKValueTransformations transformations] performSelector:transformSelector withObject:value];
				#pragma clang diagnostic pop
			}
		}
		
		if (value) {
			JSONDictionary[remoteKey] = value;
		}
	}
	
	return JSONDictionary;
}


@end
