/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ANKClient+ANKFile.h"
#import "ANKFile.h"


@implementation ANKClient (ANKFile)

// http://developers.app.net/docs/resources/file/lookup/#retrieve-a-file

- (void)fetchFileWithID:(NSString *)fileID completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"files/%@", fileID]
	   parameters:nil
		  success:[self successHandlerForResourceClass:[ANKFile class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/file/lookup/#retrieve-multiple-files

- (void)fetchFilesWithIDs:(NSArray *)fileIDs completion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"files?ids=%@", [fileIDs componentsJoinedByString:@","]]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKFile class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/file/lookup/#retrieve-my-files

- (void)fetchCurrentUserFilesWithCompletion:(ANKClientCompletionBlock)completionHandler {
	[self getPath:@"users/me/files"
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKFile class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/file/content/#get-file-content

- (void)fetchContentsOfFile:(ANKFile *)file completion:(ANKClientCompletionBlock)completionHandler {
	[self fetchContentsOfFileWithID:file.fileID completion:completionHandler];
}


- (void)fetchContentsOfFileWithID:(NSString *)fileID completion:(ANKClientCompletionBlock)completionHandler {
	NSURLRequest *request = [self requestWithMethod:@"GET" path:[NSString stringWithFormat:@"files/%@/content", fileID] parameters:nil];
	AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
	[requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		if (completionHandler) {
			completionHandler(responseObject, nil, nil);
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if (completionHandler) {
			completionHandler(nil, nil, error);
		}
	}];
	[self enqueueHTTPRequestOperation:requestOperation];
}


// http://developers.app.net/docs/resources/file/lifecycle/#create-a-file

- (void)createFile:(ANKFile *)file withData:(NSData *)fileData completion:(ANKClientCompletionBlock)completionHandler {
	if (!fileData) {
		[self postPath:@"files"
			parameters:[file JSONDictionary]
			   success:[self successHandlerForResourceClass:[ANKFile class] clientHandler:completionHandler]
			   failure:[self failureHandlerForClientHandler:completionHandler]];
	} else {
		[self createFileWithData:fileData mimeType:file.mimeType filename:file.name fileURL:nil metadata:[file JSONDictionary] progress:nil completion:completionHandler];
	}
}


- (void)createFileWithData:(NSData *)fileData mimeType:(NSString *)mimeType filename:(NSString *)filename metadata:(NSDictionary *)metadata progress:(ANKClientFileUploadProgressBlock)progressHandler completion:(ANKClientCompletionBlock)completionHandler {
	[self createFileWithData:fileData mimeType:mimeType filename:filename fileURL:nil metadata:metadata progress:progressHandler completion:completionHandler];
}


- (void)createFileWithContentsOfURL:(NSURL *)fileURL metadata:(NSDictionary *)metadata progress:(ANKClientFileUploadProgressBlock)progressHandler completion:(ANKClientCompletionBlock)completionHandler {
	[self createFileWithData:nil mimeType:nil filename:nil fileURL:fileURL metadata:metadata progress:progressHandler completion:completionHandler];
}


- (void)createFileWithData:(NSData *)fileData
                  mimeType:(NSString *)mimeType
                  filename:(NSString *)filename
                   fileURL:(NSURL *)fileURL
                  metadata:(NSDictionary *)metadata
                  progress:(ANKClientFileUploadProgressBlock)progressHandler
                completion:(ANKClientCompletionBlock)completionHandler {
	__block NSError *multipartEncodeError = nil;
	NSMutableURLRequest *request = [self multipartFormRequestWithMethod:@"POST" path:@"files" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
		if (fileURL) {
			[formData appendPartWithFileURL:fileURL name:@"content" error:&multipartEncodeError];
		} else {
			[formData appendPartWithFileData:fileData name:@"content" fileName:filename mimeType:mimeType];
		}
		
		if (metadata.count > 0) {
			[formData appendPartWithFileData:[NSJSONSerialization dataWithJSONObject:metadata options:0 error:&multipartEncodeError] name:@"metadata" fileName:@"metadata.json" mimeType:@"application/json"];
		}
	}];
	
	if (multipartEncodeError) {
		if (completionHandler) {
			completionHandler(nil, nil, multipartEncodeError);
		}
		return;
	}
	
	AFHTTPRequestOperation *requestOperation = [self HTTPRequestOperationWithRequest:request
																			 success:[self successHandlerForResourceClass:[ANKFile class] clientHandler:completionHandler]
																			 failure:[self failureHandlerForClientHandler:completionHandler]];
    [requestOperation setUploadProgressBlock:progressHandler];
	[self enqueueHTTPRequestOperation:requestOperation];
}


// http://developers.app.net/docs/resources/file/lifecycle/#update-a-file

- (void)updateFile:(ANKFile *)file completion:(ANKClientCompletionBlock)completionHandler {
	[self updateFileWithID:file.fileID name:file.name isPublic:file.isPublic completion:completionHandler];
}


- (void)updateFileWithID:(NSString *)fileID name:(NSString *)updatedName isPublic:(BOOL)updatedPublicFlag completion:(ANKClientCompletionBlock)completionHandler {
	[self putPath:[NSString stringWithFormat:@"files/%@", fileID]
	   parameters:@{@"name": updatedName, @"public": (updatedPublicFlag ? @"true" : @"false")}
		  success:[self successHandlerForResourceClass:[ANKFile class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/file/lifecycle/#delete-a-file

- (void)deleteFile:(ANKFile *)file completion:(ANKClientCompletionBlock)completionHandler {
	[self deleteFileWithID:file.fileID completion:completionHandler];
}


- (void)deleteFileWithID:(NSString *)fileID completion:(ANKClientCompletionBlock)completionHandler {
	[self deletePath:[NSString stringWithFormat:@"files/%@", fileID]
		  parameters:nil
			 success:[self successHandlerForResourceClass:[ANKFile class] clientHandler:completionHandler]
			 failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/file/content/#set-file-content

- (void)setContentOfFile:(ANKFile *)file fileData:(NSData *)fileData mimeType:(NSString *)mimeType completion:(ANKClientCompletionBlock)completionHandler {
	[self setContentOfFileWithID:file.fileID fileData:fileData mimeType:mimeType completion:completionHandler];
}


- (void)setContentOfFileWithID:(NSString *)fileID fileData:(NSData *)fileData mimeType:(NSString *)mimeType completion:(ANKClientCompletionBlock)completionHandler {
	NSMutableURLRequest *request = [self requestWithMethod:@"PUT" path:[NSString stringWithFormat:@"files/%@/content", fileID] parameters:nil];
	[request setValue:mimeType forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:fileData];
	
	AFHTTPRequestOperation *requestOperation = [self HTTPRequestOperationWithRequest:request
																			 success:[self successHandlerForResourceClass:[ANKFile class] clientHandler:completionHandler]
																			 failure:[self failureHandlerForClientHandler:completionHandler]];
	[self enqueueHTTPRequestOperation:requestOperation];
}


@end
