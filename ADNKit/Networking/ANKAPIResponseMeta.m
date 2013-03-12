//
//  ANKAPIResponseMeta.m
//  ADNKit
//
//  Created by Joel Levin on 3/12/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

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
	return [NSError errorWithDomain:kANKErrorDomain code:(self.errorID ? [self.errorID integerValue] : 0) userInfo:@{NSLocalizedDescriptionKey: self.errorMessage, kANKErrorTypeKey: @(self.errorType)}];
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
