/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ANKFile.h"
#import "ANKImage.h"


@interface ANKFile ()

- (NSDictionary *)fileAnnotationValueWithWrapper:(BOOL)includeWrapper isOEmbed:(BOOL)isOEmbed;

@end


@implementation ANKFile

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] ank_dictionaryByAppendingDictionary:@{
			@"id": @"fileID",
			@"mime_type": @"mimeType",
			@"complete": @"isComplete",
			@"public": @"isPublic",
			@"sha1": @"sha1ContentHash",
			@"created_at": @"createdAt",
			@"size": @"sizeBytes",
			@"total_size": @"sizeBytesIncludingDerivedFiles",
			@"derived_files": @"derivedFiles",
			@"url": @"URL",
			@"url_expires": @"URLExpireDate",
			@"url_permanent": @"permanentURL",
			@"url_short": @"shortURL",
			@"file_token": @"fileToken",
			@"file_token_read": @"readOnlyFileToken",
			@"image_info": @"imageInfo"}];
}


+ (NSSet *)localKeysExcludedFromJSONOutput {
	return [[NSSet setWithSet:[super localKeysExcludedFromJSONOutput]] setByAddingObjectsFromArray:@[@"derivedFiles"]];
}


+ (NSDictionary *)fileListAnnotationValueForFiles:(NSArray *)files {
	return @{kANKFileListAnnotationKey: [files ank_map:^id(ANKFile *file) {
		return [file fileAnnotationValueWithWrapper:NO isOEmbed:NO];
	}]};
}


+ (NSString *)annotationValueWrapperKey {
	return kANKFileAnnotationKey;
}


+ (instancetype)fileWithFileAtURL:(NSURL *)fileURL {
	NSString *UTI = (__bridge_transfer NSString *)UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[fileURL pathExtension], NULL);
	NSString *contentType = (__bridge_transfer NSString *)UTTypeCopyPreferredTagWithClass((__bridge CFStringRef)UTI, kUTTagClassMIMEType);
	
	ANKFile *file = [[ANKFile alloc] init];
	file.name = [fileURL lastPathComponent];
	file.mimeType = contentType ?: @"application/octet-stream";
	file.kind = [file.mimeType hasPrefix:@"image"] ? @"image" : @"other";
	
	return file;
}


- (NSDictionary *)annotationValue {
	return [self fileAnnotationValueWithWrapper:YES isOEmbed:NO];
}


- (NSDictionary *)oembedAnnotationValue {
	return [self fileAnnotationValueWithWrapper:YES isOEmbed:YES];
}


- (NSString *)uniqueID {
	return self.fileID;
}


- (void)updateObjectFromJSONDictionary:(NSDictionary *)JSONDictionary {
	NSMutableDictionary *mutableJSONDictionary = [NSMutableDictionary dictionaryWithDictionary:JSONDictionary];
	NSString *derivedFilesKey = [[self class] JSONKeyForLocalKey:@"derivedFiles"];
	
	if (mutableJSONDictionary[derivedFilesKey]) {
		NSDictionary *derivedFiles = mutableJSONDictionary[derivedFilesKey];
		mutableJSONDictionary[derivedFilesKey] = [derivedFiles ank_mapValues:^id(id key, id value) {
			return [ANKFile objectFromJSONDictionary:value];
		}];
	}
	
	[super updateObjectFromJSONDictionary:mutableJSONDictionary];
	
	if (self.imageInfo && !self.imageInfo.URL && [self isImage]) {
		self.imageInfo.URL = self.permanentURL ?: self.URL;
	}
}


- (NSDictionary *)fileAnnotationValueWithWrapper:(BOOL)includeWrapper isOEmbed:(BOOL)isOEmbed {
	NSDictionary *value = @{@"file_id": self.fileID, @"format": (isOEmbed ? @"oembed" : @"url"), [[self class] JSONKeyForLocalKey:@"fileToken"]: self.fileToken};
	return (includeWrapper ? @{kANKFileAnnotationKey: value} : value);
}


- (NSString *)description {
	return [NSString stringWithFormat:@"<%@ %p> - %@ (%@)", NSStringFromClass([self class]), self, self.name, self.mimeType];
}


- (BOOL)isImage {
	return [self.kind isEqualToString:kANKFileKindImage] || [self.mimeType hasPrefix:@"image"];
}


- (ANKFile *)smallImageThumbnailFile {
	return self.derivedFiles[@"image_thumb_200s"];
}


- (ANKFile *)mediumImageThumbnailFile {
	return self.derivedFiles[@"image_thumb_960r"];
}


@end
