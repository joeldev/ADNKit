//
//  ADNInteraction.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKResource.h"


@interface ANKInteraction : ANKResource

@property (strong) NSString *actionString;
@property (strong) NSDate *eventDate;
@property (strong) NSArray *objects;
@property (strong) NSArray *users;

@end
