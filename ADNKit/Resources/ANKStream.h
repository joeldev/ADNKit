//
//  ADNStream.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKResource.h"


@class ANKFilter;

@interface ANKStream : ANKResource

@property (strong) NSString *streamID;
@property (strong) NSString *endpoint;
@property (strong) ANKFilter *filter;
@property (strong) NSArray *objectTypes;
@property (strong) NSString *type;
@property (strong) NSString *key;

@end
