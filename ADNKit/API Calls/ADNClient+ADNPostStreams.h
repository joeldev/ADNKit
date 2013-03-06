//
//  ADNClient+ADNPostStreams.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/5/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNClient.h"


@class ADNPost, ADNUser;

@interface ADNClient (ADNPostStreams)

- (void)fetchGlobalStreamWithCompletion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchPostsWithHashtag:(NSString *)hashtag completion:(ADNClientCompletionBlock)completionHandler;

- (void)fetchPostsCreatedByUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchPostsCreatedByUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

- (void)fetchPostsMentioningUser:(ADNUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchPostsMentioningUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

- (void)fetchStreamForCurrentUserWithCompletion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUnifiedStreamForCurrentUserWithCompletion:(ADNClientCompletionBlock)completionHandler;

@end
