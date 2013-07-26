//
//  ANKSearchQuery.h
//  ADNKit
//
//  Created by Kolin Krewinkel on 7/25/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

static NSString *const kANKSearchQueryIndexTypeComplete = @"complete";

static NSString *const kANKSearchQueryOrderTypeID = @"id";
static NSString *const kANKSearchQueryOrderTypeScore = @"score";

static NSString *const kANKSearchQueryMediaTypePhoto = @"photo";
static NSString *const kANKSearchQueryMediaTypeVideo = @"video";
static NSString *const kANKSearchQueryMediaTypeHTML5Video = @"HTML5Video";
static NSString *const kANKSearchQueryMediaTypeRich = @"rich";

@interface ANKSearchQuery : ANKResource

#pragma mark -
#pragma mark Initialization

+ (instancetype)searchQueryWithQuery:(NSString *)query;
+ (instancetype)searchQueryWithLinks:(NSArray *)links;
+ (instancetype)searchQueryForEmbeddedMediaOfTypes:(NSArray *)mediaTypes;
+ (instancetype)searchQueryForCreatorWithID:(NSString *)creatorID;
+ (instancetype)searchQueryForClient:(NSString *)clientID;
+ (instancetype)searchQueryForPostsInReplyTo:(NSString *)replyToID;
+ (instancetype)searchQueryForThread:(NSString *)threadID;

#pragma mark -
#pragma mark Convenience Methods

- (void)setCrosspostDomainFromURL:(NSURL *)crosspostURL;

#pragma mark -
#pragma mark General Parameters

@property (nonatomic, copy) NSString *indexType;
@property (nonatomic, copy) NSString *orderType;

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
@property (nonatomic, copy) NSString *crosspostDomain;
@property (nonatomic, copy) NSString *placeID;
@property (nonatomic) BOOL isReply;
@property (nonatomic) BOOL isDirected;
@property (nonatomic) BOOL hasLocation;
@property (nonatomic) BOOL hasCheckin;
@property (nonatomic) BOOL isCrosspost;
@property (nonatomic) BOOL hasAttachment;
@property (nonatomic) BOOL hasOEmbedPhoto;
@property (nonatomic) BOOL hasOEmbedVideo;
@property (nonatomic) BOOL hasOEmbedHTML5Video;
@property (nonatomic) BOOL hasOEmbedRich;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, copy) NSString *clientID;
@property (nonatomic, copy) NSString *creatorID;
@property (nonatomic, copy) NSString *replyTo;
@property (nonatomic, copy) NSString *threadID;

@end
