//
//  ADNStream.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNResource.h"


@class ADNFilter;

@interface ADNStream : ADNResource

@property (strong) NSString *streamID;
@property (strong) NSString *endpoint;
@property (strong) ADNFilter *filter;
@property (strong) NSArray *objectTypes;
@property (strong) NSString *type;
@property (strong) NSString *key;

@end
