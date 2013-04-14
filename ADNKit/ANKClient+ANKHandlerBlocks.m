/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ANKClient+ANKHandlerBlocks.h"
#import "ANKAPIResponse.h"
#import "ANKResource.h"
#import "ANKResourceMap.h"


@implementation ANKClient (ANKHandlerBlocks)

- (NSArray *)unboxCollectionResponse:(ANKAPIResponse *)response ofResourceClass:(Class)resourceClass {
	id unboxedObject = nil;
	if ([resourceClass isSubclassOfClass:[ANKResource class]] && [response.data isKindOfClass:[NSArray class]]) {
		unboxedObject = [ANKResolve(resourceClass) objectsFromJSONDictionaries:response.data];
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
			unboxedObject = [ANKResolve(resourceClass) objectFromJSONDictionary:response.data];
		}
		return unboxedObject;
	}];
}


- (AFNetworkingSuccessBlock)successHandlerForCollectionOfResourceClass:(Class)resourceClass clientHandler:(ANKClientCompletionBlock)handler {
	return [self successHandlerForClientHandler:handler unboxBlock:^id(ANKAPIResponse *response, NSError *__autoreleasing *error) {
		return [self unboxCollectionResponse:response ofResourceClass:resourceClass];
	}];
}


- (AFNetworkingSuccessBlock)successHandlerForCollectionOfResourceClass:(Class)resourceClass clientHandler:(ANKClientCompletionBlock)handler mappedWith:(id (^)(id object))mapBlock {
	return [self successHandlerForClientHandler:handler unboxBlock:^id(ANKAPIResponse *response, NSError *__autoreleasing *error) {
		return [[self unboxCollectionResponse:response ofResourceClass:resourceClass] ank_map:mapBlock];
	}];
}


- (AFNetworkingSuccessBlock)successHandlerForCollectionOfResourceClass:(Class)resourceClass clientHandler:(ANKClientCompletionBlock)handler filteredWith:(BOOL (^)(id object))filterBlock {
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
		ANKAPIResponse *response = error.userInfo[kANKAPIResponseKey];
		
		if (handler) {
			handler(nil, response.meta, error);
		}
	};
}


@end
