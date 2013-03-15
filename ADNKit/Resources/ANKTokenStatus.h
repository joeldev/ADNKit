//
//  ANKTokenStatus.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/14/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKResource.h"


@class ANKObjectSource, ANKUser, ANKStorage;

@interface ANKTokenStatus : ANKResource

@property (strong) NSString *clientID;
@property (strong) ANKObjectSource *app;
@property (strong) NSArray *scopes;
@property (strong) ANKUser *user;
@property (strong) ANKStorage *storage;

@end
