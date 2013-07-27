//
//  ANKStreamContext.h
//  ADNKit
//
//  Created by Kolin Krewinkel on 6/8/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

@class KATSocketShuttle;

@interface ANKStreamContext : NSObject

#pragma mark - Designated Initializer

+ (instancetype)streamContextWithOperation:(ANKJSONRequestOperation *)operation identifier:(NSString *)identifier delegate:(id<ANKStreamingDelegate>)delegate;
- (instancetype)initWithOperation:(ANKJSONRequestOperation *)operation identifier:(NSString *)identifier delegate:(id<ANKStreamingDelegate>)delegate;

#pragma mark - Internal

@property (nonatomic, weak, readonly) id<ANKStreamingDelegate> delegate;
@property (nonatomic, strong, readonly) ANKJSONRequestOperation *operation;

#pragma mark - API Level

@property (nonatomic, copy) NSString *identifier;

@end
