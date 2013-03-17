//
//  ADNFile.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKFile.h"


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
			@"file_token_read": @"readOnlyFileToken"}];
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
}


- (NSDictionary *)fileAnnotationValueWithWrapper:(BOOL)includeWrapper {
	NSDictionary *value = @{[[self class] JSONKeyForLocalKey:@"fileID"]: self.fileID, [[self class] JSONKeyForLocalKey:@"format"]: @"url", [[self class] JSONKeyForLocalKey:@"fileToken"]: self.fileToken};
	return (includeWrapper ? @{kANKFileAnnotationKey: value} : value);
}


- (NSString *)description {
	return [NSString stringWithFormat:@"<%@ %p> - %@ (%@)", NSStringFromClass([self class]), self, self.name, self.mimeType];
}


@end
