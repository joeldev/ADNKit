//
//  ANKClient+ANKConfiguration.m
//  ADNKit
//
//  Created by Rob Brambley on 4/2/14.
//  Copyright (c) 2014 Afterwork Studios. All rights reserved.
//

#import "ANKClient+ANKConfiguration.h"
#import "ANKConfiguration.h"

@implementation ANKClient (ANKConfiguration)

- (ANKJSONRequestOperation *)fetchConfigurationWithCompletion:(ANKClientCompletionBlock)completionHandler {
    return [self enqueueGETPath:@"config"
					 parameters:nil
						success:[self successHandlerForResourceClass:[ANKConfiguration class] clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}

@end
