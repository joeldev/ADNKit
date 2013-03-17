//
//  ADNPlace.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKResource.h"


static NSString *const kANKPlaceAnnotationKey = @"+net.app.core.place";

static NSString *const kANKPlaceSearchParamLatitude = @"latitude";
static NSString *const kANKPlaceSearchParamLongitude = @"longitude";
static NSString *const kANKPlaceSearchParamQuery = @"q";
static NSString *const kANKPlaceSearchParamRadius = @"radius";
static NSString *const kANKPlaceSearchParamCount = @"count";
static NSString *const kANKPlaceSearchParamAltitude = @"altitude";
static NSString *const kANKPlaceSearchParamHorizontalAccuracy = @"horizontal_accuracy";
static NSString *const kANKPlaceSearchParamVerticalAccuracy = @"vertical_accuracy";


@interface ANKPlace : ANKResource <ANKAnnotationReplacement>

@property (strong) NSString *factualID;
@property (strong) NSString *name;
@property (strong) NSString *address;
@property (strong) NSString *addressExtended;
@property (strong) NSString *locality;
@property (strong) NSString *region;
@property (strong) NSString *adminRegion;
@property (strong) NSString *postTown;
@property (strong) NSString *poBox;
@property (strong) NSString *postcode;
@property (strong) NSString *countryCode;
@property (assign) CGFloat latitude;
@property (assign) CGFloat longitude;
@property (assign) BOOL isOpen;
@property (strong) NSString *telephone;
@property (strong) NSString *fax;
@property (strong) NSURL *website;
@property (strong) NSArray *categories;

@end
