//
//  ADNUser.h
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNResource.h"


@interface ADNUser : ADNResource

@property (strong) NSString *userID;
@property (strong) NSString *username;
@property (strong) NSString *name;

@end
