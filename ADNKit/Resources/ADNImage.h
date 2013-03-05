//
//  ADNImage.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNResource.h"


@interface ADNImage : ADNResource

@property (strong) NSNumber *width;
@property (strong) NSNumber *height;
@property (strong) NSURL *URL;
@property (assign) BOOL isDefault;

- (CGSize)size;

@end
