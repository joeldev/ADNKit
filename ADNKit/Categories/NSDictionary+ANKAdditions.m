/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

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


- (NSDictionary *)ank_mapValues:(id (^)(id key, id value))block {
	NSMutableDictionary *processedDictionary = [NSMutableDictionary dictionary];
	for (id key in self) {
		id value = [self objectForKey:key];
		id mappedValue = block(key, value);
		if (mappedValue) {
			processedDictionary[key] = mappedValue;
		}
	}
	return processedDictionary;
}


@end
