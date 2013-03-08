//
//  ADNPlace.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNResource.h"


@interface ADNPlace : ADNResource

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
