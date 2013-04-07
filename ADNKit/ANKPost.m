/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ANKPost.h"
#import "ANKUser.h"
#import "ANKEntities.h"


@implementation ANKPost

+ (NSDictionary *)JSONToLocalKeyMapping {
	return [[super JSONToLocalKeyMapping] ank_dictionaryByAppendingDictionary:@{
			@"id": @"postID",
			@"created_at": @"createdAt",
			@"reply_to": @"repliedToPostID",
			@"canonical_url": @"canonicalURL",
			@"thread_id": @"threadID",
			@"num_replies": @"repliesCount",
			@"num_stars": @"starsCount",
			@"num_reposts": @"repostsCount",
			@"is_deleted": @"isDeleted",
			@"machine_only": @"isMachineOnly",
			@"you_starred": @"isStarredByCurrentUser",
			@"starred_by": @"starredByUsers",
			@"you_reposted": @"isRepostedByCurrentUser",
			@"repost_of": @"repostedPost"}];
}


+ (NSSet *)localKeysExcludedFromJSONOutput {
	return [NSSet setWithObject:@"attributedText"];
}


+ (Class)starredByUsersCollectionObjectClass {
	return [ANKUser class];
}


+ (Class)repostersCollectionObjectClass {
	return [ANKUser class];
}


- (void)objectDidUpdate {
	[super objectDidUpdate];
	self.entities.text = self.text;
}


- (NSString *)description {
	return [NSString stringWithFormat:@"<%@ %p> - @%@: %@", NSStringFromClass([self class]), self, self.user.username, self.text];
}


- (BOOL)containsMentionForUsername:(NSString *)username {
	return [self.entities containsMentionForUsername:username];
}


@end
