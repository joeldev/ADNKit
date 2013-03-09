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

- (void)fetchGlobalStreamWithCompletion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchPostsWithHashtag:(NSString *)hashtag completion:(ANKClientCompletionBlock)completionHandler;

- (void)fetchPostsCreatedByUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchPostsCreatedByUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;

- (void)fetchPostsMentioningUser:(ANKUser *)user completion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchPostsMentioningUserWithID:(NSString *)userID completion:(ANKClientCompletionBlock)completionHandler;

- (void)fetchStreamForCurrentUserWithCompletion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchUnifiedStreamForCurrentUserWithCompletion:(ANKClientCompletionBlock)completionHandler;

@end
