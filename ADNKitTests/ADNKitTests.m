//
//  ADNKitTests.m
//  ADNKitTests
//
//  Created by Levin, Joel A on 3/22/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNKitTests.h"
#import <ADNKit/ADNKit.h>


@implementation ADNKitTests

- (void)testCopying {
	ANKUser *user = [[ANKUser alloc] init];
	user.userID = @"-1";
	user.username = @"joeldev";
	user.name = @"Joel Levin";
	
	ANKPost *post = [[ANKPost alloc] init];
	post.text = @"testing 123";
	post.repliedToPostID = @"123456";
	post.user = user;
	post.repliesCount = 10;
	post.isStarredByCurrentUser = YES;
	post.annotations = @[[ANKAnnotation annotationWithType:@"test" value:@{@"foo": @"bar"}]];
	
	ANKUser *userCopy = [user copy];
	ANKPost *postCopy = [post copy];
	
	STAssertEqualObjects(user.userID, userCopy.userID, @"Copy failed");
	STAssertEqualObjects(user.username, userCopy.username, @"Copy failed");
	STAssertEqualObjects(user.name, userCopy.name, @"Copy failed");
	
	STAssertEqualObjects(post.text, postCopy.text, @"Copy failed");
	STAssertEqualObjects(post.repliedToPostID, postCopy.repliedToPostID, @"Copy failed");
	STAssertEqualObjects(post.user, postCopy.user, @"Copy failed");
	
	STAssertEquals(post.repliesCount, postCopy.repliesCount, @"Copy failed");
	STAssertEquals(post.isStarredByCurrentUser, postCopy.isStarredByCurrentUser, @"Copy failed");
	
	STAssertEqualObjects(post.annotations[0], postCopy.annotations[0], @"Copy failed");
}


- (void)testCoding {
	ANKUser *user = [[ANKUser alloc] init];
	user.userID = @"-1";
	user.username = @"joeldev";
	user.name = @"Joel Levin";
	
	ANKPost *post = [[ANKPost alloc] init];
	post.text = @"testing 123";
	post.repliedToPostID = @"123456";
	post.user = user;
	post.repliesCount = 10;
	post.isStarredByCurrentUser = YES;
	post.annotations = @[[ANKAnnotation annotationWithType:@"test" value:@{@"foo": @"bar"}]];
	
	NSData *postData = [NSKeyedArchiver archivedDataWithRootObject:post];
	ANKPost *unarchivedData = [NSKeyedUnarchiver unarchiveObjectWithData:postData];
	
	STAssertEqualObjects(post.text, unarchivedData.text, @"Archiving failed");
	STAssertEqualObjects(post.repliedToPostID, unarchivedData.repliedToPostID, @"Archiving failed");
	STAssertEqualObjects(post.user.userID, unarchivedData.user.userID, @"Archiving failed");
	
	STAssertEquals(post.repliesCount, unarchivedData.repliesCount, @"Archiving failed");
	STAssertEquals(post.isStarredByCurrentUser, unarchivedData.isStarredByCurrentUser, @"Archiving failed");
	
	STAssertEqualObjects([(ANKAnnotation *)post.annotations[0] type], [(ANKAnnotation *)unarchivedData.annotations[0] type], @"Archiving failed");
}


@end
