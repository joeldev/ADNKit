//
//  ADNClient+ADNHandlerBlocks.h
//  ADNKit
//
//  Created by Joel Levin on 3/8/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNClient.h"


typedef void (^AFNetworkingSuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^AFNetworkingFailureBlock)(AFHTTPRequestOperation *operation, NSError *error);
typedef void (^ADNClientCompletionBlock)(id responseObject, NSError *error);


@class ADNResponse;

@interface ADNClient (ADNHandlerBlocks)

- (NSArray *)unboxCollectionResponse:(ADNResponse *)response ofResourceClass:(Class)resourceClass;
- (AFNetworkingSuccessBlock)successHandlerForClientHandler:(ADNClientCompletionBlock)handler unboxBlock:(id (^)(ADNResponse *response, NSError **error))unboxBlock;
- (AFNetworkingSuccessBlock)successHandlerForResourceClass:(Class)resourceClass clientHandler:(ADNClientCompletionBlock)handler;
- (AFNetworkingSuccessBlock)successHandlerForCollectionOfResourceClass:(Class)resourceClass clientHandler:(ADNClientCompletionBlock)handler;
- (AFNetworkingSuccessBlock)successHandlerForCollectionOfResourceClass:(Class)resourceClass clientHandler:(ADNClientCompletionBlock)handler mapBlock:(id (^)(id object))mapBlock;
- (AFNetworkingSuccessBlock)successHandlerForCollectionOfResourceClass:(Class)resourceClass clientHandler:(ADNClientCompletionBlock)handler filterBlock:(BOOL (^)(id object))filterBlock;
- (AFNetworkingSuccessBlock)successHandlerForPrimitiveResponseWithClientHandler:(ADNClientCompletionBlock)handler;

- (AFNetworkingFailureBlock)failureHandlerForClientHandler:(ADNClientCompletionBlock)handler;

@end
