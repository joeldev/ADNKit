//
//  ADNResource.h
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ADNResource : NSObject

+ (NSDictionary *)keyMapping;

+ (instancetype)objectFromJSONDictionary:(NSDictionary *)dictionary;
+ (NSArray *)objectsFromJSONDictionaries:(NSArray *)dictionaries;

- (id)initWithJSONDictionary:(NSDictionary *)JSONDictionay;
- (void)updateObjectFromJSONDictionary:(NSDictionary *)JSONDictionary;
- (NSDictionary *)JSONDictionary;

@end
