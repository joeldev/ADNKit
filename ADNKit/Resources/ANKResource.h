//
//  ADNResource.h
//  ADNKit
//
//  Created by Joel Levin on 3/3/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ANKResource : NSObject

+ (NSDictionary *)JSONToLocalKeyMapping;
+ (NSString *)JSONKeyForLocalKey:(NSString *)localKey;
+ (NSString *)localKeyForJSONKey:(NSString *)JSONKey;
+ (NSSet *)localKeysExcludedFromJSONOutput;

+ (instancetype)objectFromJSONDictionary:(NSDictionary *)dictionary;
+ (NSArray *)objectsFromJSONDictionaries:(NSArray *)dictionaries;

- (id)initWithJSONDictionary:(NSDictionary *)JSONDictionay;
- (void)updateObjectFromJSONDictionary:(NSDictionary *)JSONDictionary;
- (void)objectDidUpdate;
- (NSDictionary *)JSONDictionary;

@end
