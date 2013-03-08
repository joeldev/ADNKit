//
//  ADNClient+ADNPlace.h
//  ADNKit
//
//  Created by Joel Levin on 3/7/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNClient+ADNHandlerBlocks.h"


@interface ADNClient (ADNPlace)

- (void)fetchPlaceWithFactualID:(NSString *)factualID completion:(ADNClientCompletionBlock)completionHandler;

// parameters contains keys located in ADNPlace.h
- (void)searchForPlacesWithParameters:(NSDictionary *)params completion:(ADNClientCompletionBlock)completionHandler;

@end
