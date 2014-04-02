//
//  ANKConfiguration.h
//  ADNKit
//
//  Created by Rob Brambley on 4/2/14.
//  Copyright (c) 2014 Afterwork Studios. All rights reserved.
//

@class ANKResourceConfiguration, ANKTextConfiguration;

@interface ANKConfiguration : ANKResource

@property ANKTextConfiguration *text;
@property ANKResourceConfiguration *user;
@property ANKResourceConfiguration *file;
@property ANKResourceConfiguration *post;
@property ANKResourceConfiguration *message;
@property ANKResourceConfiguration *channel;

@end
