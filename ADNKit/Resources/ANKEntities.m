//
//  ADNEntity.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

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
	return self.mentionMap[username];
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
