//
//  ANKClient+ANKConfiguration.h
//  ADNKit
//
//  Created by Rob Brambley on 4/2/14.
//  Copyright (c) 2014 Afterwork Studios. All rights reserved.
//

@interface ANKClient (ANKConfiguration)

- (ANKJSONRequestOperation *)fetchConfigurationWithCompletion:(ANKClientCompletionBlock)completionHandler;

@end
