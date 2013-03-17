//
//  ANKGeolocation.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/17/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import <ADNKit/ADNKit.h>


@interface ANKGeolocation : ANKResource

@property (assign) double latitude;
@property (assign) double longitude;
@property (assign) NSInteger altitude;
@property (assign) NSUInteger horizontalAccuracy;
@property (assign) NSUInteger verticalAccuracy;

@end
