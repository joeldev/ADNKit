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

@end
