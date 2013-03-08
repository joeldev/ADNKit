//
//  ADNResponse.h
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import <Foundation/Foundation.h>


static NSString *const kANKAPIResponseKey = @"ANKAPIResponse";


@interface ANKAPIResponse : NSObject

@property (readonly, strong) id data;

- (id)initWithResponseObject:(id)responseObject;

@end
