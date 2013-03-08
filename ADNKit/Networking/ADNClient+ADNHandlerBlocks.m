//
//  ADNClient+ADNHandlerBlocks.m
//  ADNKit
//
//  Created by Joel Levin on 3/8/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNClient+ADNHandlerBlocks.h"
#import "ADNResponse.h"
#import "ADNResource.h"


@implementation ADNClient (ADNHandlerBlocks)

- (NSArray *)unboxCollectionResponse:(ADNResponse *)response ofResourceClass:(Class)resourceClass {
	id unboxedObject = nil;
	if ([resourceClass isSubclassOfClass:[ADNResource class]] && [response.data isKindOfClass:[NSDictionary class]]) {
		unboxedObject = [resourceClass objectFromJSONDictionary:response.data];
	}
	return unboxedObject;
}


- (AFNetworkingSuccessBlock)successHandlerForClientHandler:(ADNClientCompletionBlock)handler unboxBlock:(id (^)(ADNResponse *response, NSError **error))unboxBlock {
	return ^(AFHTTPRequestOperation *operation, ADNResponse *responseWrapper) {
		id finalObject = responseWrapper.data;
		NSError *error = nil;
		
		if (unboxBlock) {
			finalObject = unboxBlock(responseWrapper, &error);
		}
		
		if (handler) {
			handler(finalObject, error);
		}
	};
}


- (AFNetworkingSuccessBlock)successHandlerForResourceClass:(Class)resourceClass clientHandler:(ADNClientCompletionBlock)handler {
	return [self successHandlerForClientHandler:handler unboxBlock:^id(ADNResponse *response, NSError *__autoreleasing *error) {
		id unboxedObject = nil;
		if ([resourceClass isSubclassOfClass:[ADNResource class]] && [response.data isKindOfClass:[NSDictionary class]]) {
			unboxedObject = [resourceClass objectFromJSONDictionary:response.data];
		}
		return unboxedObject;
	}];
}


- (AFNetworkingSuccessBlock)successHandlerForCollectionOfResourceClass:(Class)resourceClass clientHandler:(ADNClientCompletionBlock)handler {
	return [self successHandlerForClientHandler:handler unboxBlock:^id(ADNResponse *response, NSError *__autoreleasing *error) {
		return [self unboxCollectionResponse:response ofResourceClass:resourceClass];
	}];
}


- (AFNetworkingSuccessBlock)successHandlerForCollectionOfResourceClass:(Class)resourceClass clientHandler:(ADNClientCompletionBlock)handler mapBlock:(id (^)(id object))mapBlock {
	return [self successHandlerForClientHandler:handler unboxBlock:^id(ADNResponse *response, NSError *__autoreleasing *error) {
		return [[self unboxCollectionResponse:response ofResourceClass:resourceClass] adn_map:mapBlock];
	}];
}


- (AFNetworkingSuccessBlock)successHandlerForCollectionOfResourceClass:(Class)resourceClass clientHandler:(ADNClientCompletionBlock)handler filterBlock:(BOOL (^)(id object))filterBlock {
	return [self successHandlerForClientHandler:handler unboxBlock:^id(ADNResponse *response, NSError *__autoreleasing *error) {
		return [[self unboxCollectionResponse:response ofResourceClass:resourceClass] adn_filter:filterBlock];
	}];
}


- (AFNetworkingSuccessBlock)successHandlerForPrimitiveResponseWithClientHandler:(ADNClientCompletionBlock)handler {
	return ^(AFHTTPRequestOperation *operation, id responseObject) {
		if (handler) {
			handler(((ADNResponse *)responseObject).data, nil);
		}
	};
}


- (AFNetworkingFailureBlock)failureHandlerForClientHandler:(ADNClientCompletionBlock)handler {
	return ^(AFHTTPRequestOperation *operation, NSError *error) {
		if (handler) {
			handler(nil, error);
		}
	};
}


@end
