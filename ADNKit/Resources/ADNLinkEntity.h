//
//  ADNLinkEntity.h
//  ADNKit
//
//  Created by Joel Levin on 3/8/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNEntity.h"


@interface ADNLinkEntity : ADNEntity

@property (strong) NSString *text;
@property (strong) NSURL *URL;
@property (assign) NSUInteger amendedLength;

- (NSRange)amendedRange;

@end
