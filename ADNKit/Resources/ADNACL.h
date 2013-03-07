//
//  ADNACL.h
//  ADNKit
//
//  Created by Joel Levin on 3/7/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNResource.h"


@interface ADNACL : ADNResource

@property (strong) NSArray *userIDs;
@property (assign) BOOL canAnyUser;
@property (assign) BOOL canCurrentUser;
@property (assign) BOOL isImmutable;
@property (assign) BOOL isPublic;

@end
