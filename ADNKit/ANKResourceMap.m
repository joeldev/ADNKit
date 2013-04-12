/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ANKResourceMap.h"
#import "ANKResource.h"


@interface ANKResourceMap ()

@property (strong) NSMutableDictionary *classMap;

+ (instancetype)resourceMap;

- (void)setCustomResourceClass:(Class)resourceClass forResourceClass:(Class)baseResourceClass;
- (Class)resourceClassForClass:(Class)resourceClass;

@end


@implementation ANKResourceMap

+ (instancetype)resourceMap {
	static ANKResourceMap *sharedResourceMap = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedResourceMap = [[ANKResourceMap alloc] init];
	});
	return sharedResourceMap;
}


- (id)init {
	if ((self = [super init])) {
		self.classMap = [NSMutableDictionary dictionary];
	}
	return self;
}


+ (void)setCustomResourceClass:(Class)resourceClass forResourceClass:(Class)baseResourceClass {
	[[self resourceMap] setCustomResourceClass:resourceClass forResourceClass:baseResourceClass];
}


+ (Class)resourceClassForClass:(Class)resourceClass {
	return [[self resourceMap] resourceClassForClass:resourceClass];
}


- (void)setCustomResourceClass:(Class)resourceClass forResourceClass:(Class)baseResourceClass {
	NSString *key = NSStringFromClass(baseResourceClass);
	if (resourceClass == nil) {
		[self.classMap removeObjectForKey:key];
	} else if ([resourceClass isSubclassOfClass:baseResourceClass]) {
		self.classMap[key] = resourceClass;
	}
}


- (Class)resourceClassForClass:(Class)resourceClass {
	return self.classMap[NSStringFromClass(resourceClass)] ?: resourceClass;
}


@end
