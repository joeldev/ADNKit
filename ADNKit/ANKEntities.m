/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ANKEntities.h"
#import "ANKMentionEntity.h"
#import "ANKHashtagEntity.h"
#import "ANKLinkEntity.h"


@interface ANKEntities ()

@property (strong) NSDictionary *mentionMap;

@end


@implementation ANKEntities

+ (Class)mentionsCollectionObjectClass {
	return [ANKMentionEntity class];
}


+ (Class)hashtagsCollectionObjectClass {
	return [ANKHashtagEntity class];
}


+ (Class)linksCollectionObjectClass {
	return [ANKLinkEntity class];
}


- (void)objectDidUpdate {
	self.mentionMap = [NSDictionary dictionaryWithObjects:self.mentions forKeys:[self.mentions valueForKeyPath:@"username"]];
}


- (ANKMentionEntity *)mentionForUsername:(NSString *)username {
	return self.mentionMap[([username hasPrefix:@"@"] ? [username substringFromIndex:1] : username)];
}


- (BOOL)containsMentionForUsername:(NSString *)username {
	return [self mentionForUsername:username] != nil;
}


- (NSAttributedString *)attributedStringForString:(NSString *)string withDefaultAttributes:(NSDictionary *)defaultAttributes mentionAttributes:(NSDictionary *)mentionAttributes hashtagAttributes:(NSDictionary *)hashtagAttributes linkAttributes:(NSDictionary *)linkAttributes attributeEncodeBlock:(void (^)(NSMutableDictionary *attributes, ANKEntity *entity))encodeBlock {
	NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:defaultAttributes];
	
	NSArray *allEntities = [[(self.mentions ?: @[]) arrayByAddingObjectsFromArray:(self.hashtags ?: @[])] arrayByAddingObjectsFromArray:(self.links ?: @[])];
	NSDictionary *typeMap = @{NSStringFromClass([ANKMentionEntity class]): mentionAttributes, NSStringFromClass([ANKHashtagEntity class]): hashtagAttributes, NSStringFromClass([ANKLinkEntity class]): linkAttributes};
	
	for (ANKEntity *entity in allEntities) {
		NSMutableDictionary *attributes = [typeMap[NSStringFromClass([entity class])] mutableCopy];
		if (encodeBlock) {
			encodeBlock(attributes, entity);
		}
		[attributedString addAttributes:attributes range:entity.range];
	}
	
	return attributedString;
}


@end
