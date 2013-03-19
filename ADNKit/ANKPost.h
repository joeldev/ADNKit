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


// Descriptions for Post fields
// http://developers.app.net/docs/resources/post/#post-fields


@class ANKUser, ANKObjectSource, ANKEntities;

@interface ANKPost : ANKAnnotatableResource

@property (strong) NSString *postID;
@property (strong) ANKUser *user;
@property (strong) NSDate *createdAt;
@property (strong) NSString *text;
@property (strong) NSString *html;
@property (strong) ANKEntities *entities;
@property (strong) ANKObjectSource *source;
@property (strong) NSString *repliedToPostID;
@property (strong) NSURL *canonicalURL;
@property (strong) NSString *threadID;
@property (assign) NSUInteger repliesCount;
@property (assign) NSUInteger starsCount;
@property (assign) NSUInteger repostsCount;
@property (assign) BOOL isDeleted;
@property (assign) BOOL isMachineOnly;
@property (assign) BOOL isStarredByCurrentUser;
@property (strong) NSArray *starredByUsers;
@property (assign) BOOL isRepostedByCurrentUser;
@property (strong) NSArray *reposters;
@property (strong) ANKPost *repostedPost;

// this does not come from the server, nor is it returned as a key in -JSONDictionary. It is meant for
// easy caching from the client to encourage not generating the attributed string more than once.
@property (strong) NSAttributedString *attributedText;

- (BOOL)containsMentionForUsername:(NSString *)username;

@end
