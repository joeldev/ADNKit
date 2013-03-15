//
//  ADNClient+ADNFile.h
//  ADNKit
//
//  Created by Joel Levin on 3/5/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKClient+ANKHandlerBlocks.h"


@class ANKFile;

@interface ANKClient (ANKFile)

- (void)fetchFileWithID:(NSString *)fileID completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchFilesWithIDs:(NSArray *)fileIDs completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchCurrentUserFilesWithCompletion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchContentsOfFile:(ANKFile *)file completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchContentsOfFileWithID:(NSString *)fileID completion:(ANKClientCompletionBlock)completionHandler;

- (void)createFile:(ANKFile *)file withData:(NSData *)fileData completion:(ANKClientCompletionBlock)completionHandler;
- (void)createFileWithData:(NSData *)fileData mimeType:(NSString *)mimeType filename:(NSString *)filename metadata:(NSDictionary *)metadata progress:(ANKClientProgressBlock)progressHandler completion:(ANKClientCompletionBlock)completionHandler;
- (void)createFileWithContentsOfURL:(NSURL *)fileURL metadata:(NSDictionary *)metadata progress:(ANKClientProgressBlock)progressHandler completion:(ANKClientCompletionBlock)completionHandler;

- (void)updateFile:(ANKFile *)file completion:(ANKClientCompletionBlock)completionHandler;
- (void)updateFileWithID:(NSString *)fileID name:(NSString *)updatedName isPublic:(BOOL)updatedPublicFlag completion:(ANKClientCompletionBlock)completionHandler;

- (void)deleteFile:(ANKFile *)file completion:(ANKClientCompletionBlock)completionHandler;
- (void)deleteFileWithID:(NSString *)fileID completion:(ANKClientCompletionBlock)completionHandler;

- (void)setContentOfFile:(ANKFile *)file fileData:(NSData *)fileData mimeType:(NSString *)mimeType completion:(ANKClientCompletionBlock)completionHandler;
- (void)setContentOfFileWithID:(NSString *)fileID fileData:(NSData *)fileData mimeType:(NSString *)mimeType completion:(ANKClientCompletionBlock)completionHandler;

@end
