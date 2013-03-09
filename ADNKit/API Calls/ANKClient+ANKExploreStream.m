//
//  ANKClient+ANKExploreStream.m
//  ADNKit
//
//  Created by Joel Levin on 3/8/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKClient+ANKExploreStream.h"
#import "ANKExploreStream.h"


@implementation ANKClient (ANKExploreStream)

// http://developers.app.net/docs/resources/explore/#retrieve-all-explore-streams

- (void)fetchExploreStreamsWithCompletion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:@"posts/stream/explore"
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKExploreStream class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/explore/#retrieve-an-explore-stream

- (void)fetchExploreStreamWithSlug:(NSString *)slug completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"posts/stream/explore/%@", slug]
	   parameters:nil
		  success:[self successHandlerForResourceClass:[ANKExploreStream class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


@end
