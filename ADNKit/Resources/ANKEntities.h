//
//  ADNEntity.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/4/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKResource.h"


@class ANKEntity, ANKMentionEntity;

@interface ANKEntities : ANKResource

@property (strong) NSArray *mentions;
@property (strong) NSArray *hashtags;
@property (strong) NSArray *links;

- (ANKMentionEntity *)mentionForUsername:(NSString *)username;
- (BOOL)containsMentionForUsername:(NSString *)username;

- (NSAttributedString *)attributedStringForString:(NSString *)string withDefaultAttributes:(NSDictionary *)defaultAttributes mentionAttributes:(NSDictionary *)mentionAttributes hashtagAttributes:(NSDictionary *)hashtagAttributes linkAttributes:(NSDictionary *)linkAttributes attributeEncodeBlock:(void (^)(NSMutableDictionary *attributes, ANKEntity *entity))encodeBlock;

@end
