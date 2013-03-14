//
//  ANKStorage.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/14/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKResource.h"


@interface ANKStorage : ANKResource

@property (assign) size_t available;
@property (assign) size_t used;

- (NSString *)formattedAvailableStorage;
- (NSString *)formattedUsedStorage;

@end
