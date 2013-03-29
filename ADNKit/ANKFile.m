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

- (NSDictionary *)fileAnnotationValueWithWrapper:(BOOL)includeWrapper;

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
			@"file_token": @"fileToken",
			@"file_token_read": @"readOnlyFileToken",
			@"image_info": @"imageInfo"}];
}


+ (NSSet *)localKeysExcludedFromJSONOutput {
	return [[NSSet setWithSet:[super localKeysExcludedFromJSONOutput]] setByAddingObjectsFromArray:@[@"derivedFiles"]];
}


+ (NSDictionary *)fileListAnnotationValueForFiles:(NSArray *)files {
	return @{kANKFileListAnnotationKey: [files ank_map:^id(ANKFile *file) {
		return [file fileAnnotationValueWithWrapper:NO];
	}]};
}


+ (NSString *)annotationValueWrapperKey {
	return kANKFileAnnotationKey;
}


- (NSDictionary *)annotationValue {
	return [self fileAnnotationValueWithWrapper:YES];
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
	
	if (self.imageInfo && !self.imageInfo.URL && [self.kind isEqualToString:kANKFileKindImage]) {
		self.imageInfo.URL = self.permanentURL ?: self.URL;
	}
}


- (NSDictionary *)fileAnnotationValueWithWrapper:(BOOL)includeWrapper {
	NSDictionary *value = @{[[self class] JSONKeyForLocalKey:@"fileID"]: self.fileID, [[self class] JSONKeyForLocalKey:@"format"]: @"url", [[self class] JSONKeyForLocalKey:@"fileToken"]: self.fileToken};
	return (includeWrapper ? @{kANKFileAnnotationKey: value} : value);
}


- (NSString *)description {
	return [NSString stringWithFormat:@"<%@ %p> - %@ (%@)", NSStringFromClass([self class]), self, self.name, self.mimeType];
}


@end
