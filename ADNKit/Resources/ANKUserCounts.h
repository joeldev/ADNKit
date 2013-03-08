//
//  ADNUserCounts.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKResource.h"


@interface ANKUserCounts : ANKResource

@property (assign) NSUInteger following;
@property (assign) NSUInteger followers;
@property (assign) NSUInteger posts;
@property (assign) NSUInteger stars;

@end
