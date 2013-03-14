//
//  ANKClient+ANKTokenStatus.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/14/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKClient.h"


@interface ANKClient (ANKTokenStatus)

- (void)fetchTokenStatusForCurrentUserWithCompletion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchTokenStatusesForAuthorizedUsersWithCompletion:(ANKClientCompletionBlock)completionHandler;
- (void)fetchAuthorizedUserIDsWithCompletion:(ANKClientCompletionBlock)completionHandler;

@end
