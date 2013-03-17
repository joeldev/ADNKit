/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ANKValueTransformations.h"


@implementation ANKValueTransformations

+ (instancetype)transformations {
	static ANKValueTransformations *transformations = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		transformations = [[ANKValueTransformations alloc] init];
	});
	return transformations;
}


- (NSDateFormatter *)dateFormatter {
	static NSDateFormatter *sharedDateFormatter = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedDateFormatter = [[NSDateFormatter alloc] init];
		sharedDateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
		sharedDateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
	});
	return sharedDateFormatter;
}


- (NSString *)NSStringFromNSConstantString:(NSString *)string {
	return string;
}


- (NSURL *)NSURLFromNSString:(NSString *)string {
	return [NSURL URLWithString:string];
}


- (NSDate *)NSDateFromNSString:(NSString *)string {
	return [[self dateFormatter] dateFromString:string];
}


- (NSArray *)NSArrayFrom__NSArrayI:(NSArray *)array {
	return array;
}


- (NSDictionary *)NSDictionaryFrom__NSDictionaryI:(NSDictionary *)dictionary {
	return dictionary;
}


- (id)JSONObjectFromNSURL:(NSURL *)URL {
	return [URL absoluteString];
}


- (id)JSONObjectFromNSDate:(NSDate *)date {
	return [[self dateFormatter] stringFromDate:date];
}


@end
