//
//  ANKPaginationSettings.h
//  ADNKit
//
//  Created by Joel Levin on 3/12/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKResource.h"


@class ANKStreamMarker;

@interface ANKPaginationSettings : ANKResource

@property (strong) NSString *sinceID;
@property (strong) NSString *beforeID;
@property (assign) NSUInteger count;

// stream marker
@property (strong) NSString *lastReadID;
@property (strong) NSString *lastReadIDInclusive;
@property (strong) NSString *markerID;
@property (strong) NSString *markerIDInclusive;

+ (instancetype)defaultSettings;
+ (instancetype)settingsWithCount:(NSUInteger)count;
+ (instancetype)settingsWithSinceID:(NSString *)sinceID beforeID:(NSString *)beforeID count:(NSUInteger)count;
+ (instancetype)settingsWithLastReadID:(NSString *)lastReadID markerID:(NSString *)markerID count:(NSUInteger)count;
+ (instancetype)settingsWithLastReadIDInclusive:(NSString *)lastReadIDInclusive markerIDInclusive:(NSString *)markerIDInclusive count:(NSUInteger)count;

@end
