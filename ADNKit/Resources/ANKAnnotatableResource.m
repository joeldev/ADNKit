//
//  ADNAnnotatableResource.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKAnnotatableResource.h"
#import "ANKAnnotation.h"


@implementation ANKAnnotatableResource

+ (Class)annotationsCollectionObjectClass {
	return [ANKAnnotation class];
}

@end
