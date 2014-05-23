//
//  ADNKitTests.m
//  ADNKitTests
//
//  Created by Levin, Joel A on 3/22/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ADNKitTests.h"
#import "CustomPost.h"
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
	
	XCTAssertEqualObjects(user.userID, userCopy.userID, @"Copy failed");
	XCTAssertEqualObjects(user.username, userCopy.username, @"Copy failed");
	XCTAssertEqualObjects(user.name, userCopy.name, @"Copy failed");
	
	XCTAssertEqualObjects(post.text, postCopy.text, @"Copy failed");
	XCTAssertEqualObjects(post.repliedToPostID, postCopy.repliedToPostID, @"Copy failed");
	XCTAssertEqualObjects(post.user, postCopy.user, @"Copy failed");
	
	XCTAssertEqual(post.repliesCount, postCopy.repliesCount, @"Copy failed");
	XCTAssertEqual(post.isStarredByCurrentUser, postCopy.isStarredByCurrentUser, @"Copy failed");
	
	XCTAssertEqualObjects(post.annotations[0], postCopy.annotations[0], @"Copy failed");
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
	
	XCTAssertEqualObjects(post.text, unarchivedData.text, @"Archiving failed");
	XCTAssertEqualObjects(post.repliedToPostID, unarchivedData.repliedToPostID, @"Archiving failed");
	XCTAssertEqualObjects(post.user.userID, unarchivedData.user.userID, @"Archiving failed");
	
	XCTAssertEqual(post.repliesCount, unarchivedData.repliesCount, @"Archiving failed");
	XCTAssertEqual(post.isStarredByCurrentUser, unarchivedData.isStarredByCurrentUser, @"Archiving failed");
	
	XCTAssertEqualObjects([(ANKAnnotation *)post.annotations[0] type], [(ANKAnnotation *)unarchivedData.annotations[0] type], @"Archiving failed");
}


- (void)testResourceReplacement {
	[ANKResourceMap setCustomResourceClass:[CustomPost class] forResourceClass:[ANKPost class]];
	XCTAssertEqual(ANKResolve([ANKPost class]), [CustomPost class], @"Setting custom resource class failed");
	
	[ANKResourceMap setCustomResourceClass:nil forResourceClass:[ANKPost class]];
	XCTAssertEqual(ANKResolve([ANKPost class]), [ANKPost class], @"Removing custom resource class failed");
}


@end
