//
//  ADNUserDescription.h
//  ADNKit
//
//  Created by Joel Levin on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKResource.h"


@class ANKEntities;

@interface ANKUserDescription : ANKResource

@property (strong) NSString *text;
@property (strong) NSString *html;
@property (strong) ANKEntities *entities;

@end
