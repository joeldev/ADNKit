/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ANKAPIResponseMeta.h"


@implementation ANKAPIResponseMeta

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] ank_dictionaryByAppendingDictionary:@{
			@"code": @"statusCode",
			@"max_id": @"maxID",
			@"min_id": @"minID",
			@"more": @"moreDataAvailable",
			@"error_message": @"errorMessage",
			@"error_slug": @"errorSlug",
			@"error_id": @"errorID"}];
}


- (NSError *)error {
	NSError *error = nil;
	
	if (self.isError) {
		error = [NSError errorWithDomain:kANKErrorDomain code:self.statusCode userInfo:@{NSLocalizedDescriptionKey: self.errorMessage, kANKErrorTypeKey: @(self.errorType), kANKErrorIDKey: self.errorID}];
	}
	
	return error;
}


- (BOOL)isError {
	return self.statusCode != 200;
}


- (ANKErrorType)errorType {
	static NSDictionary *errorTypeMap = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		errorTypeMap = @{@"invalid-token": @(ANKErrorTypeInvalidToken), @"not-authorized": @(ANKErrorTypeNotAuthorized), @"token-expired": @(ANKErrorTypeTokenExpired), @"code-used": @(ANKErrorTypeCodeUsed), @"redirect-uri-required": @(ANKErrorTypeRedirectURIRequired)};
	});
	return (ANKErrorType)[[errorTypeMap objectForKey:self.errorSlug] integerValue];
}


@end
