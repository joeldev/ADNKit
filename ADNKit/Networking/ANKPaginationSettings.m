//
//  ANKPaginationSettings.m
//  ADNKit
//
//  Created by Joel Levin on 3/12/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKPaginationSettings.h"


@implementation ANKPaginationSettings

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] ank_dictionaryByAppendingDictionary:@{
			@"since_id": @"sinceID",
			@"before_id": @"beforeID",
			@"last_read": @"lastReadID",
			@"last_read_inclusive": @"lastReadIDInclusive",
			@"marker": @"markerID",
			@"marker_inclusive": @"markerIDInclusive"}];
}


+ (instancetype)settingsWithCount:(NSUInteger)count {
	return [[self class] settingsWithSinceID:nil beforeID:nil count:count];
}


+ (instancetype)settingsWithSinceID:(NSString *)sinceID beforeID:(NSString *)beforeID count:(NSUInteger)count {
	ANKPaginationSettings *settings = [[[self class] alloc] init];
	settings.sinceID = sinceID;
	settings.beforeID = beforeID;
	settings.count = count;
	return settings;
}


+ (instancetype)settingsWithLastReadID:(NSString *)lastReadID markerID:(NSString *)markerID count:(NSUInteger)count {
	ANKPaginationSettings *settings = [[[self class] alloc] init];
	settings.lastReadID = lastReadID;
	settings.markerID = markerID;
	settings.count = count;
	return settings;
}


+ (instancetype)settingsWithLastReadIDInclusive:(NSString *)lastReadIDInclusive markerIDInclusive:(NSString *)markerIDInclusive count:(NSUInteger)count {
	ANKPaginationSettings *settings = [[[self class] alloc] init];
	settings.lastReadIDInclusive = lastReadIDInclusive;
	settings.markerIDInclusive = markerIDInclusive;
	settings.count = count;
	return settings;
}


- (NSDictionary *)JSONDictionary {
	NSDictionary *dictionary = [super JSONDictionary];
	
	if ([dictionary[@"count"] integerValue] == 0) {
		NSMutableDictionary *modifiedDictionary = [dictionary mutableCopy];
		[modifiedDictionary removeObjectForKey:@"count"];
		dictionary = modifiedDictionary;
	}
	
	return dictionary;
}


@end
