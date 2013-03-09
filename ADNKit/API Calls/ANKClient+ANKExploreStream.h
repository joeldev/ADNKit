//
//  ANKClient+ANKExploreStream.h
//  ADNKit
//
//  Created by Joel Levin on 3/8/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKClient+ANKHandlerBlocks.h"


@class ANKExploreStream;

@interface ANKClient (ANKExploreStream)

- (void)fetchExploreStreamsWithCompletion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchExploreStreamWithSlug:(NSString *)slug completion:(ANKClientCompletionBlock)completionHandler;

@end
