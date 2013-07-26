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

typedef enum {
    ANKSearchQueryInclusionTypeYes,
    ANKSearchQueryInclusionTypeNo,
    ANKSearchQueryInclusionTypeUnspecified
} ANKSearchQueryInclusionType;

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

#pragma mark -
#pragma mark Filter Parameters

@property (nonatomic, copy) NSArray *annotationTypes;
@property (nonatomic, copy) NSArray *attachmentTypes;
@property (nonatomic, copy) NSURL *crosspostURL;
@property (nonatomic, copy) NSURL *crosspostDomain;
@property (nonatomic, copy) NSString *placeID;
@property (nonatomic) ANKSearchQueryInclusionType isReply;
@property (nonatomic) ANKSearchQueryInclusionType isDirected;
@property (nonatomic) ANKSearchQueryInclusionType hasLocation;
@property (nonatomic) ANKSearchQueryInclusionType hasCheckin;
@property (nonatomic) ANKSearchQueryInclusionType isCrosspost;
@property (nonatomic) ANKSearchQueryInclusionType hasAttachment;
@property (nonatomic) ANKSearchQueryInclusionType hasOEmbedPhoto;
@property (nonatomic) ANKSearchQueryInclusionType hasOEmbedVideo;
@property (nonatomic) ANKSearchQueryInclusionType hasOEmbedHTML5Video;
@property (nonatomic) ANKSearchQueryInclusionType hasOEmbedRich;
@property (nonatomic, copy) NSString *language; // This could potentially be an NSLocale, but I'm not sure if people would want that.
@property (nonatomic, copy) NSString *clientID;
@property (nonatomic, copy) NSString *creatorID;
@property (nonatomic, copy) NSString *replyTo;
@property (nonatomic, copy) NSString *threadID;

@end
