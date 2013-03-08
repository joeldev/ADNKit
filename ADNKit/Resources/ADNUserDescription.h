//
//  ADNUserDescription.h
//  ADNKit
//
//  Created by Joel Levin on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNResource.h"


@class ADNEntities;

@interface ADNUserDescription : ADNResource

@property (strong) NSString *text;
@property (strong) NSString *html;
@property (strong) ADNEntities *entities;

@end
