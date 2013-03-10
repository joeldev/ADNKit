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


- (NSAttributedString *)attributedStringForString:(NSString *)string withDefaultAttributes:(NSDictionary *)defaultAttributes mentionAttributes:(NSDictionary *)mentionAttributes hashtagAttributes:(NSDictionary *)hashtagAttributes linkAttributes:(NSDictionary *)linkAttributes {
	NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:defaultAttributes];
	
	NSArray *allEntities = [[(self.mentions ?: @[]) arrayByAddingObjectsFromArray:(self.hashtags ?: @[])] arrayByAddingObjectsFromArray:(self.links ?: @[])];
	NSDictionary *typeMap = @{NSStringFromClass([ANKMentionEntity class]): mentionAttributes, NSStringFromClass([ANKHashtagEntity class]): hashtagAttributes, NSStringFromClass([ANKLinkEntity class]): linkAttributes};
	
	for (ANKEntity *entity in allEntities) {
		[attributedString addAttributes:typeMap[NSStringFromClass([entity class])] range:entity.range];
	}
	
	return attributedString;
}


@end
