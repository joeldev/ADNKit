//
//  ANKSearchQuery.h
//  ADNKit
//
//  Created by Kolin Krewinkel on 7/25/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

typedef enum {
    ANKSearchQueryIndexTypeComplete
} ANKSearchQueryIndexType;

typedef enum {
    ANKSearchQueryOrderTypeID,
    ANKSearchQueryOrderTypeScore
} ANKSearchQueryOrderType;

@interface ANKSearchQuery : NSObject

#pragma mark - 
#pragma mark General Parameters

@property (nonatomic) ANKSearchQueryIndexType indexType;
@property (nonatomic) ANKSearchQueryOrderType orderType;

#pragma mark -
#pragma mark Search Query Parameters

@property (nonatomic, copy) NSString *query;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSArray *hashtags;
@property (nonatomic, copy) NSArray *links;
@property (nonatomic, copy) NSArray *linkDomains;
@property (nonatomic, copy) NSArray *mentions;
@property (nonatomic, copy) NSArray *leadingMentions;

@end
