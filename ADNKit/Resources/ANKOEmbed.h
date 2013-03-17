//
//  ANKOEmbed.h
//  ADNKit
//
//  Created by Levin, Joel A on 3/17/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import <ADNKit/ADNKit.h>


@interface ANKOEmbed : ANKResource

@property (strong) NSString *type;
@property (strong) NSString *version;
@property (assign) NSUInteger width;
@property (assign) NSUInteger height;
@property (strong) NSURL *URL;
@property (strong) NSString *html;
@property (strong) NSURL *embeddableURL;
@property (strong) NSString *title;
@property (strong) NSString *authorName;
@property (strong) NSURL *authorURL;
@property (strong) NSString *providerName;
@property (strong) NSURL *providerURL;
@property (assign) NSUInteger cacheAge;
@property (strong) NSURL *thumbnailURL;
@property (assign) NSUInteger thumbnailWidth;
@property (assign) NSUInteger thumbnailHeight;

@end
