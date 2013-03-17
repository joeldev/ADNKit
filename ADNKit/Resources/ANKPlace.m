//
//  ADNPlace.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKPlace.h"
#import "ANKPlaceCategory.h"


@implementation ANKPlace

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] ank_dictionaryByAppendingDictionary:@{
			@"factual_id": @"factualID",
            @"address_extended": @"addressExtended",
			@"admin_region": @"adminRegion",
			@"post_town": @"postTown",
			@"po_box": @"poBox",
			@"country_code": @"countryCode",
			@"is_open": @"isOpen"}];
}


+ (Class)categoriesCollectionObjectClass {
	return [ANKPlaceCategory class];
}


- (NSDictionary *)annotationValue {
	return @{kADNPlaceAnnotationKey: @{[[self class] JSONKeyForLocalKey:@"factualID"]: self.factualID}};
}


@end
