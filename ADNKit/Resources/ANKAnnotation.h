/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

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
