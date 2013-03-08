//
//  ADNPlace.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNPlace.h"
#import "ADNPlaceCategory.h"
#import "NSDictionary+ADNAdditions.h"


@implementation ADNPlace

+ (NSDictionary *)keyMapping {
	return [[super keyMapping] adn_dictionaryByAppendingDictionary:@{
			@"factual_id": @"factualID",
            @"address": @"address",
            @"address_extended": @"addressExtended",
			@"admin_region": @"adminRegion",
			@"post_town": @"postTown",
			@"po_box": @"poBox",
			@"country_code": @"countryCode",
			@"is_open": @"isOpen"}];
}


+ (Class)categoriesCollectionObjectClass {
	return [ADNPlaceCategory class];
}


- (NSDictionary *)placeAnnotationValue {
	return @{kADNPlaceAnnotationKey: self.factualID};
}


@end
