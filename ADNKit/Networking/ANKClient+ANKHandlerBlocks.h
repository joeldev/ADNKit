//
//  ADNClient+ADNHandlerBlocks.h
//  ADNKit
//
//  Created by Joel Levin on 3/8/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKClient.h"


typedef void (^AFNetworkingSuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^AFNetworkingFailureBlock)(AFHTTPRequestOperation *operation, NSError *error);
typedef void (^ANKClientCompletionBlock)(id responseObject, NSError *error);


@class ANKAPIResponse;

@interface ANKClient (ANKHandlerBlocks)

- (NSArray *)unboxCollectionResponse:(ANKAPIResponse *)response ofResourceClass:(Class)resourceClass;
- (AFNetworkingSuccessBlock)successHandlerForClientHandler:(ANKClientCompletionBlock)handler unboxBlock:(id (^)(ANKAPIResponse *response, NSError **error))unboxBlock;
- (AFNetworkingSuccessBlock)successHandlerForResourceClass:(Class)resourceClass clientHandler:(ANKClientCompletionBlock)handler;
- (AFNetworkingSuccessBlock)successHandlerForCollectionOfResourceClass:(Class)resourceClass clientHandler:(ANKClientCompletionBlock)handler;
- (AFNetworkingSuccessBlock)successHandlerForCollectionOfResourceClass:(Class)resourceClass clientHandler:(ANKClientCompletionBlock)handler mapBlock:(id (^)(id object))mapBlock;
- (AFNetworkingSuccessBlock)successHandlerForCollectionOfResourceClass:(Class)resourceClass clientHandler:(ANKClientCompletionBlock)handler filterBlock:(BOOL (^)(id object))filterBlock;
- (AFNetworkingSuccessBlock)successHandlerForPrimitiveResponseWithClientHandler:(ANKClientCompletionBlock)handler;

- (AFNetworkingFailureBlock)failureHandlerForClientHandler:(ANKClientCompletionBlock)handler;

@end
