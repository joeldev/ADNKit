/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ANKResource.h"
#import <CoreLocation/CoreLocation.h>


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

- (CLLocationCoordinate2D)location;

@end
