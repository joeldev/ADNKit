//
//  ANKStreamContext.m
//  ADNKit
//
//  Created by Kolin Krewinkel on 6/8/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKStreamContext.h"

@interface ANKStreamContext ()

@property (nonatomic, weak) id<ANKStreamingDelegate> delegate;
@property (nonatomic, strong) ANKJSONRequestOperation *operation;

@end

@implementation ANKStreamContext

#pragma mark -
#pragma mark Designated Initializer

+ (instancetype)streamContextWithOperation:(ANKJSONRequestOperation *)operation identifier:(NSString *)identifier delegate:(id<ANKStreamingDelegate>)delegate {
    return [[[self class] alloc] initWithOperation:operation identifier:identifier delegate:delegate];
}

- (instancetype)initWithOperation:(ANKJSONRequestOperation *)operation identifier:(NSString *)identifier delegate:(id<ANKStreamingDelegate>)delegate {
    if ((self = [super init])) {
        self.operation = operation;
        self.identifier = identifier;
        self.delegate = delegate;
    }

    return self;
}

@end
