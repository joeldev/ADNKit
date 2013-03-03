//
//  ADNJSONRequestOperation.m
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNJSONRequestOperation.h"
#import "ADNResponse.h"


@implementation ADNJSONRequestOperation

- (void)setCompletionBlockWithSuccess:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
	[super setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		ADNResponse *response = [[ADNResponse alloc] initWithResponseObject:responseObject];
		
		if (success) {
			success(operation, response);
		}
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		ADNResponse *response = [[ADNResponse alloc] initWithResponseObject:((AFJSONRequestOperation *)operation).responseJSON];
		
		NSMutableDictionary *modifiedUserInfo = [error.userInfo mutableCopy];
		modifiedUserInfo[kADNResponseKey] = response;
		NSError *modifiedError = [NSError errorWithDomain:error.domain code:error.code userInfo:modifiedUserInfo];
		
		if (failure) {
			failure(operation, modifiedError);
		}
    }];
}

@end
