//
//  ANKPaginatableResource.h
//  ADNKit
//
//  Created by Bryan Berg on 10/25/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKResource.h"


@interface ANKPaginatableResource : ANKResource

@property (strong) NSString *paginationID;
@property (strong, readonly) NSString *uniqueID;

@end
