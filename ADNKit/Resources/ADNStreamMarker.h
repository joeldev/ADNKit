//
//  ADNStreamMarker.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNResource.h"


@interface ADNStreamMarker : ADNResource

@property (strong) NSString *identifier;
@property (strong) NSString *topPostID;
@property (strong) NSString *lastReadPostID;
@property (strong) NSString *streamName;
@property (assign) NSUInteger percentage;
@property (strong) NSDate *updatedAt;

@end
