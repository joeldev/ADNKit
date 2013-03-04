//
//  NSArray+ADNAdditions.h
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray (ADNAdditions)

- (NSArray *)adn_map:(id (^)(id object))mapBlock;

@end
