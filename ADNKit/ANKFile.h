/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ANKAnnotatableResource.h"


static NSString *const kANKFileAnnotationKey = @"+net.app.core.file";
static NSString *const kANKFileListAnnotationKey = @"+net.app.core.file_list";
static NSString *const kANKFileKindImage = @"image";
static NSString *const kANKFileKIndOther = @"other";


@class ANKUser, ANKObjectSource, ANKImage;

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
@property (strong) NSDictionary *derivedFiles;
@property (strong) NSURL *URL;
@property (strong) NSDate *URLExpireDate;
@property (strong) NSURL *permanentURL;
@property (strong) NSString *fileToken;
@property (strong) NSString *readOnlyFileToken;
@property (strong) NSString *type;
@property (strong) ANKUser *user;
@property (strong) ANKObjectSource *source;
@property (strong) ANKImage *imageInfo;

+ (NSDictionary *)fileListAnnotationValueForFiles:(NSArray *)files;
- (BOOL)isImage;

@end
