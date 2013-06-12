//
//  ANKStreamContext.m
//  ADNKit
//
//  Created by Kolin Krewinkel on 6/8/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKStreamContext.h"

@implementation ANKStreamContext

#pragma mark - Designated Initializer

- (id)initWithIdentifier:(NSString *)identifier socketShuttle:(KATSocketShuttle *)socketShuttle streamingDelegate:(id<ANKStreamingDelegate>)streamingDelegate
    if ((self = [super init])) {
        self.identifier = identifier;
        self.socketShuttle = socketShuttle;
        self.streamingDelegate = streamingDelegate;
    }

    return self;
}

@end
