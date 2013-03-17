//
//  ADNAnnotation.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKResource.h"


@interface ANKAnnotation : ANKResource

@property (strong) NSString *type;
@property (strong) NSDictionary *value;

+ (instancetype)annotationWithType:(NSString *)type value:(NSDictionary *)value;
+ (instancetype)annotationWithType:(NSString *)type object:(ANKResource *)resource;

- (ANKResource *)resourceOfClassForValue:(Class)resourceClass;
- (ANKResource *)resourceOfClass:(Class)resourceClass forValueKeyPath:(NSString *)keyPath;

@end
