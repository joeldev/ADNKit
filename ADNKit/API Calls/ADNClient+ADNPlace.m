//
//  ADNClient+ADNPlace.m
//  ADNKit
//
//  Created by Joel Levin on 3/7/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNClient+ADNPlace.h"
#import "ADNPlace.h"


@implementation ADNClient (ADNPlace)

// http://developers.app.net/docs/resources/place/#retrieve-a-place

- (void)fetchPlaceWithFactualID:(NSString *)factualID completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"places/%@", factualID]
	   parameters:nil
		  success:[self successHandlerForResourceClass:[ADNPlace class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// parameters contains keys located in ADNPlace.h
// http://developers.app.net/docs/resources/place/#search-for-a-place

- (void)searchForPlacesWithParameters:(NSDictionary *)params completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:@"places/search"
	   parameters:params
		  success:[self successHandlerForCollectionOfResourceClass:[ADNPlace class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


@end
