//
//  ADNJSONRequestOperation.m
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKJSONRequestOperation.h"
#import "ANKAPIResponse.h"
#import "ANKAPIResponseMeta.h"


@implementation ANKJSONRequestOperation

- (void)setCompletionBlockWithSuccess:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
	[super setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		ANKAPIResponse *response = [[ANKAPIResponse alloc] initWithResponseObject:responseObject];
		
		if (success) {
			success(operation, response);
		}
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		ANKAPIResponse *response = [[ANKAPIResponse alloc] initWithResponseObject:((AFJSONRequestOperation *)operation).responseJSON];
		
		NSMutableDictionary *modifiedUserInfo = [error.userInfo mutableCopy];
		modifiedUserInfo[kANKAPIResponseKey] = response;
		NSError *modifiedError = [NSError errorWithDomain:error.domain code:error.code userInfo:modifiedUserInfo];
		
		if (failure) {
			failure(operation, response.meta.isError ? response.meta.error : modifiedError);
		}
    }];
}

@end
