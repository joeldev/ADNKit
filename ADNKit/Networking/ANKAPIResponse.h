//
//  ADNResponse.h
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import <Foundation/Foundation.h>


static NSString *const kANKAPIResponseKey = @"ANKAPIResponse";


@class ANKAPIResponseMeta;

@interface ANKAPIResponse : NSObject

@property (readonly, strong) id data;
@property (readonly, strong) ANKAPIResponseMeta *meta;

- (id)initWithResponseObject:(id)responseObject;

@end
