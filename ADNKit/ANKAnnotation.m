/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ANKAnnotation.h"
#import "ANKFile.h"
#import "ANKPlace.h"
#import "ANKChannel.h"
#import "ANKGeolocation.h"
#import "ANKOEmbed.h"


@interface ANKAnnotation ()

+ (instancetype)annotationWithType:(NSString *)type object:(ANKResource *)resource shouldUseReplacement:(BOOL)shouldUseReplacement;
- (ANKResource *)resourceOfClass:(Class)resourceClass forValue:(id)resourceValue;

@end


@implementation ANKAnnotation

+ (instancetype)annotationWithType:(NSString *)type value:(NSDictionary *)value {
	ANKAnnotation *annotation = [[ANKAnnotation alloc] init];
	annotation.type = type;
	annotation.value = value;
	return annotation;
}


+ (instancetype)annotationWithType:(NSString *)type object:(ANKResource *)resource {
	return [[self class] annotationWithType:type object:resource shouldUseReplacement:YES];
}


+ (instancetype)annotationWithType:(NSString *)type object:(ANKResource *)resource shouldUseReplacement:(BOOL)shouldUseReplacement {
	NSDictionary *value = nil;
	if ([resource conformsToProtocol:@protocol(ANKAnnotationReplacement)] && shouldUseReplacement) {
		ANKResource <ANKAnnotationReplacement> *replaceableResource = (ANKResource <ANKAnnotationReplacement> *)resource;
		value = [replaceableResource annotationValue];
	} else {
		value = [resource JSONDictionary];
	}
	return [[self class] annotationWithType:type value:value];
}


- (NSString *)description {
	return [NSString stringWithFormat:@"<%@ %p> - %@: %@", NSStringFromClass([self class]), self, self.type, self.value];
}


- (ANKResource *)resourceOfClassForValue:(Class)resourceClass {
	return [self resourceOfClass:resourceClass forValue:self.value];
}


- (ANKResource *)resourceOfClass:(Class)resourceClass forValueKeyPath:(NSString *)keyPath {
	return [self resourceOfClass:resourceClass forValue:[self.value valueForKeyPath:keyPath]];
}


- (ANKResource *)resourceOfClass:(Class)resourceClass forValue:(id)resourceValue {
	ANKResource *resource = nil;
	if ([resourceValue isKindOfClass:[NSDictionary class]] && [resourceClass isSubclassOfClass:[ANKResource class]]) {
		// value is a dictionary and resource is a valid resource class
		NSDictionary *JSONDictionary = resourceValue;
		if ([resourceClass conformsToProtocol:@protocol(ANKAnnotationReplacement)]) {
			// this is a replacement resource, so we need to unwrap it one level to get to the actual object
			JSONDictionary = [JSONDictionary objectForKey:[resourceClass annotationValueWrapperKey]];
		}
		resource = [resourceClass objectFromJSONDictionary:JSONDictionary];
	}
	return resource;
}


#pragma mark -
#pragma mark Core Annotation convenience methods

+ (instancetype)attachmentsAnnotationWithFiles:(NSArray *)files {
	return [[self class] annotationWithType:kANKCoreAnnotationAttachments value:[ANKFile fileListAnnotationValueForFiles:files]];
}


+ (instancetype)channelInviteAnnotationForChannel:(ANKChannel *)channel {
	return [[self class] annotationWithType:kANKCoreAnnotationChannelInvite value:@{[ANKChannel JSONKeyForLocalKey:@"channelID"]: channel.channelID}];
}


+ (instancetype)checkinAnnotationForPlace:(ANKPlace *)place {
	return [[self class] annotationWithType:kANKCoreAnnotationCheckin object:place];
}


+ (instancetype)externalCrosspostAnnotationWithURL:(NSURL *)canonicalURL {
	return [[self class] annotationWithType:kANKCoreAnnotationCrosspost value:@{@"canonical_url": [canonicalURL absoluteString]}];
}


+ (instancetype)userBlogAnnotationWithURL:(NSURL *)URL {
	return [[self class] annotationWithType:kANKCoreAnnotationBlogURL value:@{@"url": [URL absoluteString]}];
}


+ (instancetype)userFacebookIDAnnotationWithID:(NSString *)ID {
	return [[self class] annotationWithType:kANKCoreAnnotationFacebookID value:@{@"id": ID}];
}


+ (instancetype)userHomepageAnnotationWithURL:(NSURL *)URL {
	return [[self class] annotationWithType:kANKCoreAnnotationHomepage value:@{@"url": [URL absoluteString]}];
}


+ (instancetype)userTwitterAccountNameWithString:(NSString *)twitterName {
	return [[self class] annotationWithType:kANKCoreAnnotationTwitterUsername value:@{@"username": twitterName}];
}


+ (instancetype)fallbackURLAnnotationWithURL:(NSURL *)URL {
	return [[self class] annotationWithType:kANKCoreAnnotationFallbackURL value:@{@"url": [URL absoluteString]}];
}


+ (instancetype)geolocationAnnotationForGeolocation:(ANKGeolocation *)geolocation {
	return [[self class] annotationWithType:kANKCoreAnnotationGeolocation object:geolocation];
}


+ (instancetype)languageAnnotationForLanguageIdentifier:(NSString *)languageIdentifier {
	return [[self class] annotationWithType:kANKCoreAnnotationLanguage value:@{@"language": languageIdentifier}];
}


+ (instancetype)oembedAnnotationForOEmbed:(ANKOEmbed *)oembed {
	return [[self class] annotationWithType:kANKCoreAnnotationEmbeddedMedia object:oembed];
}


+ (instancetype)oembedAnnotationForFile:(ANKFile *)file {
	return [[self class] annotationWithType:kANKCoreAnnotationEmbeddedMedia value:[file oembedAnnotationValue]];
}


@end
