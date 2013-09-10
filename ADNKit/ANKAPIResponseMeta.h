/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ANKResource.h"


typedef NS_ENUM(NSUInteger, ANKErrorType) {
	ANKErrorTypeUnknown = 0,
	ANKErrorTypeInvalidToken,
	ANKErrorTypeNotAuthorized,
	ANKErrorTypeTokenExpired,
	ANKErrorTypeCodeUsed,
	ANKErrorTypeRedirectURIRequired
};


typedef NS_ENUM(NSUInteger, ANKHTTPStatus) {
	ANKHTTPStatusOK = 200,
	ANKHTTPStatusNoContent = 204,
	ANKHTTPStatusFound = 302,
	ANKHTTPStatusBadRequest = 400,
	ANKHTTPStatusUnauthorized = 401,
	ANKHTTPStatusForbidden = 403,
	ANKHTTPStatusNotFound = 404,
	ANKHTTPStatusMethodNotAllowed = 405,
	ANKHTTPStatusTooManyRequests = 429,
	ANKHTTPStatusInternalServerError = 500,
	ANKHTTPStatusInsufficientStorage = 507
};


static NSString *const kANKErrorDomain = @"ANKErrorDomain";
static NSString *const kANKErrorTypeKey = @"ANKErrorType";
static NSString *const kANKErrorIDKey = @"ANKErrorID";


@class ANKStreamMarker;

@interface ANKAPIResponseMeta : ANKResource

// standard properties
@property (assign) NSUInteger statusCode;
@property (strong) NSString *maxID;
@property (strong) NSString *minID;
@property (assign) BOOL moreDataAvailable;
@property (strong) ANKStreamMarker *marker;

// error properties
@property (strong) NSString *errorMessage;
@property (strong) NSString *errorSlug;
@property (strong) NSString *errorID;

@property (strong) NSString *rateLimitRemaining;
@property (strong) NSString *rateLimitLimit;
@property (strong) NSString *rateLimitReset;
@property (strong) NSString *rateLimitRetryAfter;


- (NSError *)error;
- (BOOL)isError;
- (ANKErrorType)errorType;

@end
