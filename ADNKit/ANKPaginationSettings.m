/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ANKPaginationSettings.h"

static const NSInteger kANKPaginationSettingsUndefinedCount = NSIntegerMax;

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


+ (instancetype)defaultSettings {
	return [[[self class] alloc] init];
}


+ (instancetype)settingsWithCount:(NSUInteger)count {
	return [[self class] settingsWithSinceID:nil beforeID:nil count:count];
}


+ (instancetype)settingsWithSinceID:(NSString *)sinceID beforeID:(NSString *)beforeID count:(NSInteger)count {
	ANKPaginationSettings *settings = [[[self class] alloc] init];
	settings.sinceID = sinceID;
	settings.beforeID = beforeID;
	settings.count = count;
	return settings;
}


+ (instancetype)settingsWithLastReadID:(NSString *)lastReadID markerID:(NSString *)markerID count:(NSInteger)count {
	ANKPaginationSettings *settings = [[[self class] alloc] init];
	settings.lastReadID = lastReadID;
	settings.markerID = markerID;
	settings.count = count;
	return settings;
}


+ (instancetype)settingsWithLastReadIDInclusive:(NSString *)lastReadIDInclusive markerIDInclusive:(NSString *)markerIDInclusive count:(NSInteger)count {
	ANKPaginationSettings *settings = [[[self class] alloc] init];
	settings.lastReadIDInclusive = lastReadIDInclusive;
	settings.markerIDInclusive = markerIDInclusive;
	settings.count = count;
	return settings;
}

- (instancetype)init {
    if ((self = [super init])) {
        self.count = kANKPaginationSettingsUndefinedCount;
    }

    return self;
}

- (NSDictionary *)JSONDictionary {
	NSDictionary *dictionary = [super JSONDictionary];
	
	if ([dictionary[@"count"] integerValue] == kANKPaginationSettingsUndefinedCount) {
		NSMutableDictionary *modifiedDictionary = [dictionary mutableCopy];
		[modifiedDictionary removeObjectForKey:@"count"];
		dictionary = modifiedDictionary;
	}
	
	return dictionary;
}


@end
