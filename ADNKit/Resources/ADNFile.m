//
//  ADNFile.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNFile.h"
#import "NSDictionary+ADNAdditions.h"
#import "NSArray+ADNAdditions.h"


static NSString *const kADNFileAnnotationKey = @"+net.app.core.file";
static NSString *const kADNFileListAnnotationKey = @"+net.app.core.file_list";


@implementation ADNFile

+ (NSDictionary *)keyMapping {
	return [[super keyMapping] adn_dictionaryByAppendingDictionary:@{
			@"id": @"fileID",
			@"mime_type": @"mimeType",
			@"complete": @"isComplete",
			@"public": @"isPublic",
			@"sha1": @"sha1ContentHash",
			@"created_at": @"createdAt",
			@"size": @"sizeBytes",
			@"total_size": @"sizeBytesIncludingDerivedFiles",
			@"url": @"URL",
			@"url_expires": @"URLExpireDate",
			@"url_permanent": @"permanentURL",
			@"file_token": @"fileToken",
			@"file_token_read": @"readOnlyFileToken"}];
}


+ (NSDictionary *)fileListAnnotationValueForFiles:(NSArray *)files {
	return @{kADNFileListAnnotationKey: [files adn_map:^id(ADNFile *file) {
		return [file fileAnnotationValue];
	}]};
}


- (NSDictionary *)fileAnnotationValue {
	return @{kADNFileAnnotationKey: @{@"file_id": self.fileID, @"format": @"url", @"file_token": self.fileToken}};
}


@end
