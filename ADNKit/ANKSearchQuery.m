//
//  ANKSearchQuery.m
//  ADNKit
//
//  Created by Kolin Krewinkel on 7/25/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKSearchQuery.h"

@implementation ANKSearchQuery

#pragma mark -
#pragma mark ANKResource

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] ank_dictionaryByAppendingDictionary:@{
			@"index": @"indexType",
			@"order": @"orderType",
            @"query": @"query",
            @"text": @"text",
            @"hashtags": @"hashtags",
            @"links": @"links",
            @"link_domains" : @"linkDomains",
            @"mentions": @"mentions",
            @"leading_mentions": @"leadingMentions",
            @"annotation_types": @"annotationTypes",
            @"attachment_types": @"attachmentTypes",
            @"crosspost_url": @"crosspostURL",
            @"crosspost_domain": @"crosspostDomain",
            @"place_id": @"placeID",
            @"is_reply": @"isReply",
            @"is_directed": @"isDirected",
            @"has_location": @"hasLocation",
            @"has_checkin": @"hasCheckin",
            @"is_crosspost": @"isCrosspost",
            @"has_attachment": @"hasAttachment",
            @"has_oembed_photo": @"hasOEmbedPhoto",
            @"has_oembed_video": @"hasOEmbedVideo",
            @"has_oembed_html5video": @"hasOEmbedHTML5Video",
            @"has_oembed_rich": @"hasOEmbedRich",
            @"language": @"language",
            @"client_id": @"clientID",
            @"creator_id": @"creatorID",
            @"reply_to": @"replyTo",
            @"thread_id": @"threadID"}];
}

#pragma mark -
#pragma mark Initialization


- (id)init
{
    if ((self = [super init])) {
 
    }

    return self;
}

@end
