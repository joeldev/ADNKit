/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ANKClient+ANKHandlerBlocks.h"


@class ANKFile;

@interface ANKClient (ANKFile)

- (AFHTTPRequestOperation *)fetchFileWithID:(NSString *)fileID completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchFilesWithIDs:(NSArray *)fileIDs completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchCurrentUserFilesWithCompletion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchContentsOfFile:(ANKFile *)file completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchContentsOfFileWithID:(NSString *)fileID completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)fetchContentsOfFileWithID:(NSString *)fileID withReadToken:(NSString *)readToken completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)createFile:(ANKFile *)file withData:(NSData *)fileData completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)createFile:(ANKFile *)file withContentsOfURL:(NSURL *)fileURL progress:(ANKClientFileUploadProgressBlock)progressHandler completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)createFileWithData:(NSData *)fileData mimeType:(NSString *)mimeType filename:(NSString *)filename metadata:(NSDictionary *)metadata progress:(ANKClientFileUploadProgressBlock)progressHandler completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)createFileWithContentsOfURL:(NSURL *)fileURL metadata:(NSDictionary *)metadata progress:(ANKClientFileUploadProgressBlock)progressHandler completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)updateFile:(ANKFile *)file completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)updateFileWithID:(NSString *)fileID name:(NSString *)updatedName isPublic:(BOOL)updatedPublicFlag completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)deleteFile:(ANKFile *)file completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)deleteFileWithID:(NSString *)fileID completion:(ANKClientCompletionBlock)completionHandler;

- (AFHTTPRequestOperation *)setContentOfFile:(ANKFile *)file fileData:(NSData *)fileData mimeType:(NSString *)mimeType completion:(ANKClientCompletionBlock)completionHandler;
- (AFHTTPRequestOperation *)setContentOfFileWithID:(NSString *)fileID fileData:(NSData *)fileData mimeType:(NSString *)mimeType completion:(ANKClientCompletionBlock)completionHandler;

@end
