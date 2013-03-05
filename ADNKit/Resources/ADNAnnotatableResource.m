//
//  ADNAnnotatableResource.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNAnnotatableResource.h"
#import "ADNAnnotation.h"


@implementation ADNAnnotatableResource

+ (Class)annotationsCollectionObjectClass {
	return [ADNAnnotation class];
}

@end
