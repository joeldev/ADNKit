//
//  ADNLinkEntity.h
//  ADNKit
//
//  Created by Joel Levin on 3/8/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKEntity.h"


@interface ANKLinkEntity : ANKEntity

@property (strong) NSString *text;
@property (strong) NSURL *URL;
@property (assign) NSUInteger amendedLength;

- (NSRange)amendedRange;

@end
