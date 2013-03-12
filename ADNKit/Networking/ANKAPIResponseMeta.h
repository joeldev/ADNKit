//
//  ANKAPIResponseMeta.h
//  ADNKit
//
//  Created by Joel Levin on 3/12/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKResource.h"


typedef NS_ENUM(NSUInteger, ANKErrorType) {
	ANKErrorTypeUnknown = 0,
	ANKErrorTypeInvalidToken,
	ANKErrorTypeNotAuthorized,
	ANKErrorTypeTokenExpired,
	ANKErrorTypeCodeUsed,
	ANKErrorTypeRedirectURIRequired
};


static NSString *const kANKErrorDomain = @"ANKErrorDomain";
static NSString *const kANKErrorTypeKey = @"ANKErrorType";


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

- (NSError *)error;
- (BOOL)isError;
- (ANKErrorType)errorType;

@end
