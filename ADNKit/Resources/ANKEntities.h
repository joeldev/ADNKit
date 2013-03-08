//
//  ADNEntity.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKResource.h"


@interface ANKEntities : ANKResource

@property (strong) NSArray *mentions;
@property (strong) NSArray *hashtags;
@property (strong) NSArray *links;

@end
