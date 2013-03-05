//
//  ADNUserCounts.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNResource.h"


@interface ADNUserCounts : ADNResource

@property (strong) NSNumber *following;
@property (strong) NSNumber *followers;
@property (strong) NSNumber *posts;
@property (strong) NSNumber *stars;

@end
