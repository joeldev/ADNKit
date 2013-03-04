//
//  ADNResource.m
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNResource.h"
#import "NSArray+ADNAdditions.h"


@implementation ADNResource

+ (NSDictionary *)keyMapping {
	return nil;
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
	
}


- (NSDictionary *)JSONDictionary {
	
}


@end
