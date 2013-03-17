//
//  ADNFile.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKAnnotatableResource.h"


static NSString *const kANKFileAnnotationKey = @"+net.app.core.file";
static NSString *const kANKFileListAnnotationKey = @"+net.app.core.file_list";


@class ANKUser, ANKObjectSource;

@interface ANKFile : ANKAnnotatableResource <ANKAnnotationReplacement>

@property (strong) NSString *fileID;
@property (strong) NSString *kind;
@property (strong) NSString *mimeType;
@property (strong) NSString *name;
@property (assign) BOOL isComplete;
@property (assign) BOOL isPublic;
@property (strong) NSString *sha1ContentHash;
@property (strong) NSDate *createdAt;
@property (assign) NSUInteger sizeBytes;
@property (assign) NSUInteger sizeBytesIncludingDerivedFiles;
// TODO: @property (strong) NSDictionary *derivedFiles;
@property (strong) NSURL *URL;
@property (strong) NSDate *URLExpireDate;
@property (strong) NSURL *permanentURL;
@property (strong) NSString *fileToken;
@property (strong) NSString *readOnlyFileToken;
@property (strong) NSString *type;
@property (strong) ANKUser *user;
@property (strong) ANKObjectSource *source;

+ (NSDictionary *)fileListAnnotationValueForFiles:(NSArray *)files;

@end
