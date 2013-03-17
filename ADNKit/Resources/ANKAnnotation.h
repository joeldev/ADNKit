//
//  ADNAnnotation.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKResource.h"


// core annotations -- see convenience methods below
static NSString *const kANKCoreAnnotationAttachments = @"net.app.core.attachments";
static NSString *const kANKCoreAnnotationChannelInvite = @"net.app.core.channel.invite";
static NSString *const kANKCoreAnnotationCheckin = @"net.app.core.checkin";
static NSString *const kANKCoreAnnotationCrosspost = @"net.app.core.crosspost";
static NSString *const kANKCoreAnnotationBlogURL = @"net.app.core.directory.blog";
static NSString *const kANKCoreAnnotationFacebookID = @"net.app.core.directory.facebook";
static NSString *const kANKCoreAnnotationHomepage = @"net.app.core.directory.homepage";
static NSString *const kANKCoreAnnotationTwitterUsername = @"net.app.core.directory.twitter";
static NSString *const kANKCoreAnnotationFallbackURL = @"net.app.core.fallback_url";
static NSString *const kANKCoreAnnotationGeolocation = @"net.app.core.geolocation";
static NSString *const kANKCoreAnnotationLanguage = @"net.app.core.language";
static NSString *const kANKCoreAnnotationEmbeddedMedia = @"net.app.core.oembed";


@class ANKChannel, ANKPlace, ANKGeolocation, ANKOEmbed;

@interface ANKAnnotation : ANKResource

@property (strong) NSString *type;
@property (strong) NSDictionary *value;

+ (instancetype)annotationWithType:(NSString *)type value:(NSDictionary *)value;
+ (instancetype)annotationWithType:(NSString *)type object:(ANKResource *)resource;

// core annotation convenience methods
// http://developers.app.net/docs/meta/annotations/#core-annotations

+ (instancetype)attachmentsAnnotationWithFiles:(NSArray *)files;
+ (instancetype)channelInviteAnnotationForChannel:(ANKChannel *)channel;
+ (instancetype)checkinAnnotationForPlace:(ANKPlace *)place;
+ (instancetype)externalCrosspostAnnotationWithURL:(NSURL *)canonicalURL;
+ (instancetype)userBlogAnnotationWithURL:(NSURL *)URL;
+ (instancetype)userFacebookIDAnnotationWithID:(NSString *)ID;
+ (instancetype)userHomepageAnnotationWithURL:(NSURL *)URL;
+ (instancetype)userTwitterAccountNameWithString:(NSString *)twitterName;
+ (instancetype)fallbackURLAnnotationWithURL:(NSURL *)URL;
+ (instancetype)geolocationAnnotationForGeolocation:(ANKGeolocation *)geolocation;
+ (instancetype)languageAnnotationForLanguageIdentifier:(NSString *)languageIdentifier;
+ (instancetype)oembedAnnotationForOEmbed:(ANKOEmbed *)oembed;

- (ANKResource *)resourceOfClassForValue:(Class)resourceClass;
- (ANKResource *)resourceOfClass:(Class)resourceClass forValueKeyPath:(NSString *)keyPath;

@end
