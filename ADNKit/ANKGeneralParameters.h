//
//  ANKGeneralParameters.h
//  ADNKit
//
//  Created by Joel Levin on 5/21/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKResource.h"


@interface ANKGeneralParameters : ANKResource

@property (assign) BOOL includeMuted;
@property (assign) BOOL includeDeleted;
@property (assign) BOOL includeDirectedPosts;
@property (assign) BOOL includeMachine;
@property (assign) BOOL includeStarredBy;
@property (assign) BOOL includeReposters;
@property (assign) BOOL includeAnnotations;
@property (assign) BOOL includePostAnnotations;
@property (assign) BOOL includeUserAnnotations;
@property (assign) BOOL includeHTML;

@end
