//
//  ADNClient+ADNHandlerBlocks.m
//  ADNKit
//
//  Created by Joel Levin on 3/8/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKClient+ANKHandlerBlocks.h"
#import "ANKAPIResponse.h"
#import "ANKResource.h"


@implementation ANKClient (ANKHandlerBlocks)

- (NSArray *)unboxCollectionResponse:(ANKAPIResponse *)response ofResourceClass:(Class)resourceClass {
	id unboxedObject = nil;
	if ([resourceClass isSubclassOfClass:[ANKResource class]] && [response.data isKindOfClass:[NSArray class]]) {
		unboxedObject = [resourceClass objectsFromJSONDictionaries:response.data];
	}
	return unboxedObject;
}


- (AFNetworkingSuccessBlock)successHandlerForClientHandler:(ANKClientCompletionBlock)handler unboxBlock:(id (^)(ANKAPIResponse *response, NSError **error))unboxBlock {
	return ^(AFHTTPRequestOperation *operation, ANKAPIResponse *responseWrapper) {
		id finalObject = responseWrapper.data;
		NSError *error = nil;
		
		if (unboxBlock) {
			finalObject = unboxBlock(responseWrapper, &error);
		}
		
		if (handler) {
			handler(finalObject, responseWrapper.meta, error);
		}
	};
}


- (AFNetworkingSuccessBlock)successHandlerForResourceClass:(Class)resourceClass clientHandler:(ANKClientCompletionBlock)handler {
	return [self successHandlerForClientHandler:handler unboxBlock:^id(ANKAPIResponse *response, NSError *__autoreleasing *error) {
		id unboxedObject = nil;
		if ([resourceClass isSubclassOfClass:[ANKResource class]] && [response.data isKindOfClass:[NSDictionary class]]) {
			unboxedObject = [resourceClass objectFromJSONDictionary:response.data];
		}
		return unboxedObject;
	}];
}


- (AFNetworkingSuccessBlock)successHandlerForCollectionOfResourceClass:(Class)resourceClass clientHandler:(ANKClientCompletionBlock)handler {
	return [self successHandlerForClientHandler:handler unboxBlock:^id(ANKAPIResponse *response, NSError *__autoreleasing *error) {
		return [self unboxCollectionResponse:response ofResourceClass:resourceClass];
	}];
}


- (AFNetworkingSuccessBlock)successHandlerForCollectionOfResourceClass:(Class)resourceClass clientHandler:(ANKClientCompletionBlock)handler mapBlock:(id (^)(id object))mapBlock {
	return [self successHandlerForClientHandler:handler unboxBlock:^id(ANKAPIResponse *response, NSError *__autoreleasing *error) {
		return [[self unboxCollectionResponse:response ofResourceClass:resourceClass] ank_map:mapBlock];
	}];
}


- (AFNetworkingSuccessBlock)successHandlerForCollectionOfResourceClass:(Class)resourceClass clientHandler:(ANKClientCompletionBlock)handler filterBlock:(BOOL (^)(id object))filterBlock {
	return [self successHandlerForClientHandler:handler unboxBlock:^id(ANKAPIResponse *response, NSError *__autoreleasing *error) {
		return [[self unboxCollectionResponse:response ofResourceClass:resourceClass] ank_filter:filterBlock];
	}];
}


- (AFNetworkingSuccessBlock)successHandlerForPrimitiveResponseWithClientHandler:(ANKClientCompletionBlock)handler {
	return ^(AFHTTPRequestOperation *operation, id responseObject) {
		ANKAPIResponse *response = (ANKAPIResponse *)responseObject;
		if (handler) {
			handler(response.data, response.meta, nil);
		}
	};
}


- (AFNetworkingFailureBlock)failureHandlerForClientHandler:(ANKClientCompletionBlock)handler {
	return ^(AFHTTPRequestOperation *operation, NSError *error) {
		if (handler) {
			handler(nil, nil, error);
		}
	};
}


@end
