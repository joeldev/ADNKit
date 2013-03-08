//
//  ADNImage.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKResource.h"


@interface ANKImage : ANKResource

@property (assign) NSUInteger width;
@property (assign) NSUInteger height;
@property (strong) NSURL *URL;
@property (assign) BOOL isDefault;

- (CGSize)size;

@end
