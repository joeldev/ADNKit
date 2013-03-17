//
//  NSDictionary+ADNAdditions.m
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "NSDictionary+ANKAdditions.h"


@implementation NSDictionary (ANKAdditions)

- (NSDictionary *)ank_dictionaryByAppendingDictionary:(NSDictionary *)otherDictionary {
	NSMutableDictionary *mutableSelf = [self mutableCopy];
	[mutableSelf addEntriesFromDictionary:otherDictionary];
	return mutableSelf;
}


- (NSDictionary *)ank_inverseDictionary {
	NSMutableDictionary *inverse = [NSMutableDictionary dictionaryWithCapacity:self.count];
	for (id key in self) {
		id value = [self objectForKey:key];
		if ([value conformsToProtocol:@protocol(NSCopying)]) {
			inverse[value] = key;
		}
	}
	return inverse;
}


@end
