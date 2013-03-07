//
//  ADNValueTransformations.h
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ADNValueTransformations : NSObject

+ (instancetype)transformations;

// forward transformations
- (NSString *)NSStringFromNSConstantString:(NSString *)string;
- (NSURL *)NSURLFromNSString:(NSString *)string;
- (NSDate *)NSDateFromNSString:(NSString *)string;

// reverse transformations
- (id)JSONObjectFromNSURL:(NSURL *)URL;
- (id)JSONObjectFromNSDate:(NSDate *)date;

// misc
- (NSDateFormatter *)dateFormatter;

@end
