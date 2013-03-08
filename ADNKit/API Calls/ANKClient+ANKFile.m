//
//  ADNClient+ADNFile.m
//  ADNKit
//
//  Created by Joel Levin on 3/5/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKClient+ANKFile.h"
#import "ANKFile.h"


@implementation ANKClient (ADNFile)

// http://developers.app.net/docs/resources/file/lookup/#retrieve-a-file

- (void)fetchFileWithID:(NSString *)fileID completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"files/%@", fileID]
	   parameters:nil
		  success:[self successHandlerForResourceClass:[ANKFile class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/file/lookup/#retrieve-multiple-files

- (void)fetchFilesWithIDs:(NSArray *)fileIDs completion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:[NSString stringWithFormat:@"files?ids=%@", [fileIDs componentsJoinedByString:@","]]
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKFile class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/file/lookup/#retrieve-my-files

- (void)fetchCurrentUserFilesWithCompletion:(ADNClientCompletionBlock)completionHandler {
	[self getPath:@"users/me/files"
	   parameters:nil
		  success:[self successHandlerForCollectionOfResourceClass:[ANKFile class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/file/content/#get-file-content

- (void)fetchContentsOfFile:(ANKFile *)file completion:(ADNClientCompletionBlock)completionHandler {
	[self fetchContentsOfFileWithID:file.fileID completion:completionHandler];
}


- (void)fetchContentsOfFileWithID:(NSString *)fileID completion:(ADNClientCompletionBlock)completionHandler {
	NSURLRequest *request = [self requestWithMethod:@"GET" path:[NSString stringWithFormat:@"files/%@/content", fileID] parameters:nil];
	AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
	[requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		if (completionHandler) {
			completionHandler(responseObject, nil);
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if (completionHandler) {
			completionHandler(nil, error);
		}
	}];
	[self enqueueHTTPRequestOperation:requestOperation];
}


// http://developers.app.net/docs/resources/file/lifecycle/#create-a-file

- (void)createFile:(ANKFile *)file withData:(NSData *)fileData completion:(ADNClientCompletionBlock)completionHandler {
	if (!fileData) {
		[self postPath:@"files"
			parameters:[file JSONDictionary]
			   success:[self successHandlerForResourceClass:[ANKFile class] clientHandler:completionHandler]
			   failure:[self failureHandlerForClientHandler:completionHandler]];
	} else {
		[self createFileWithData:fileData mimeType:file.mimeType filename:file.name fileURL:nil metadata:[file JSONDictionary] completion:completionHandler];
	}
}


- (void)createFileWithData:(NSData *)fileData mimeType:(NSString *)mimeType filename:(NSString *)filename metadata:(NSDictionary *)metadata completion:(ADNClientCompletionBlock)completionHandler {
	[self createFileWithData:fileData mimeType:mimeType filename:filename fileURL:nil metadata:metadata completion:completionHandler];
}


- (void)createFileWithContentsOfURL:(NSURL *)fileURL metadata:(NSDictionary *)metadata completion:(ADNClientCompletionBlock)completionHandler {
	[self createFileWithData:nil mimeType:nil filename:nil fileURL:fileURL metadata:metadata completion:completionHandler];
}


- (void)createFileWithData:(NSData *)fileData mimeType:(NSString *)mimeType filename:(NSString *)filename fileURL:(NSURL *)fileURL metadata:(NSDictionary *)metadata completion:(ADNClientCompletionBlock)completionHandler {
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
			completionHandler(nil, multipartEncodeError);
		}
		return;
	}
	
	AFHTTPRequestOperation *requestOperation = [self HTTPRequestOperationWithRequest:request
																			 success:[self successHandlerForResourceClass:[ANKFile class] clientHandler:completionHandler]
																			 failure:[self failureHandlerForClientHandler:completionHandler]];
	[self enqueueHTTPRequestOperation:requestOperation];
}


// http://developers.app.net/docs/resources/file/lifecycle/#update-a-file

- (void)updateFile:(ANKFile *)file completion:(ADNClientCompletionBlock)completionHandler {
	[self updateFileWithID:file.fileID name:file.name isPublic:file.isPublic completion:completionHandler];
}


- (void)updateFileWithID:(NSString *)fileID name:(NSString *)updatedName isPublic:(BOOL)updatedPublicFlag completion:(ADNClientCompletionBlock)completionHandler {
	[self putPath:[NSString stringWithFormat:@"files/%@", fileID]
	   parameters:@{@"name": updatedName, @"public": (updatedPublicFlag ? @"true" : @"false")}
		  success:[self successHandlerForResourceClass:[ANKFile class] clientHandler:completionHandler]
		  failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/file/lifecycle/#delete-a-file

- (void)deleteFile:(ANKFile *)file completion:(ADNClientCompletionBlock)completionHandler {
	[self deleteFileWithID:file.fileID completion:completionHandler];
}


- (void)deleteFileWithID:(NSString *)fileID completion:(ADNClientCompletionBlock)completionHandler {
	[self deletePath:[NSString stringWithFormat:@"files/%@", fileID]
		  parameters:nil
			 success:[self successHandlerForResourceClass:[ANKFile class] clientHandler:completionHandler]
			 failure:[self failureHandlerForClientHandler:completionHandler]];
}


// http://developers.app.net/docs/resources/file/content/#set-file-content

- (void)setContentOfFile:(ANKFile *)file fileData:(NSData *)fileData mimeType:(NSString *)mimeType completion:(ADNClientCompletionBlock)completionHandler {
	[self setContentOfFileWithID:file.fileID fileData:fileData mimeType:mimeType completion:completionHandler];
}


- (void)setContentOfFileWithID:(NSString *)fileID fileData:(NSData *)fileData mimeType:(NSString *)mimeType completion:(ADNClientCompletionBlock)completionHandler {
	NSMutableURLRequest *request = [self requestWithMethod:@"PUT" path:[NSString stringWithFormat:@"files/%@/content", fileID] parameters:nil];
	[request setValue:mimeType forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:fileData];
	
	AFHTTPRequestOperation *requestOperation = [self HTTPRequestOperationWithRequest:request
																			 success:[self successHandlerForResourceClass:[ANKFile class] clientHandler:completionHandler]
																			 failure:[self failureHandlerForClientHandler:completionHandler]];
	[self enqueueHTTPRequestOperation:requestOperation];
}


@end
