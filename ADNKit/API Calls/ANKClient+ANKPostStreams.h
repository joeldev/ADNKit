//
//  ADNClient+ADNPostStreams.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/5/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKClient+ANKHandlerBlocks.h"


@class ANKPost, ANKUser;

@interface ANKClient (ANKPostStreams)

- (void)fetchGlobalStreamWithCompletion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchPostsWithHashtag:(NSString *)hashtag completion:(ADNClientCompletionBlock)completionHandler;

- (void)fetchPostsCreatedByUser:(ANKUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchPostsCreatedByUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

- (void)fetchPostsMentioningUser:(ANKUser *)user completion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchPostsMentioningUserWithID:(NSString *)userID completion:(ADNClientCompletionBlock)completionHandler;

- (void)fetchStreamForCurrentUserWithCompletion:(ADNClientCompletionBlock)completionHandler;
- (void)fetchUnifiedStreamForCurrentUserWithCompletion:(ADNClientCompletionBlock)completionHandler;

@end
