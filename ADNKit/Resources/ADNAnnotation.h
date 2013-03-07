//
//  ADNAnnotation.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNResource.h"


@interface ADNAnnotation : ADNResource

@property (strong) NSString *type;
@property (strong) NSDictionary *value;

+ (instancetype)annotationWithType:(NSString *)type value:(NSDictionary *)value;

@end
