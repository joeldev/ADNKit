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


@end
