//
//  ADNPlace.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKResource.h"


static NSString *const kADNPlaceAnnotationKey = @"+net.app.core.place";

static NSString *const kADNPlaceSearchParamLatitude = @"latitude";
static NSString *const kADNPlaceSearchParamLongitude = @"longitude";
static NSString *const kADNPlaceSearchParamQuery = @"q";
static NSString *const kADNPlaceSearchParamRadius = @"radius";
static NSString *const kADNPlaceSearchParamCount = @"count";
static NSString *const kADNPlaceSearchParamAltitude = @"altitude";
static NSString *const kADNPlaceSearchParamHorizontalAccuracy = @"horizontal_accuracy";
static NSString *const kADNPlaceSearchParamVerticalAccuracy = @"vertical_accuracy";


@interface ANKPlace : ANKResource

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

- (NSDictionary *)placeAnnotationValue;

@end
