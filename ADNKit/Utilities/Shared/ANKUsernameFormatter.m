//
//  ANKUsernameFormatter.m
//  ADNKit
//
//  Created by Joel Levin on 3/9/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKUsernameFormatter.h"


@implementation ANKUsernameFormatter

- (NSString *)stringForObjectValue:(id)anObject {
	return anObject;
}


- (BOOL)getObjectValue:(id *)anObject forString:(NSString *)string errorDescription:(NSString **)error {
	*anObject = string;
	return YES;
}


- (BOOL)isPartialStringValid:(NSString **)partialStringPtr proposedSelectedRange:(NSRangePointer)proposedSelRangePtr originalString:(NSString *)origString originalSelectedRange:(NSRange)origSelRange errorDescription:(NSString **)error {
	NSString *partialString = *partialStringPtr;
	NSRange proposedRange = *proposedSelRangePtr;
	BOOL isValid = YES;
	
	if (![partialString hasPrefix:@"@"] && partialString.length > 0) {
		// if there is no @ prefix in the partial, but the string has other characters in it, tack @ on to the front
		*partialStringPtr = [@"@" stringByAppendingString:partialString];
		proposedRange = NSMakeRange(proposedRange.location + 1, proposedRange.length);
		*proposedSelRangePtr = proposedRange;
		isValid = NO;
	} else if ([origString hasPrefix:@"@"] && partialString.length == 1) {
		// otherwise if we just had the @ prefix and now the partial only has 1 character, delete the 1 character as well
		*partialStringPtr = @"";
		proposedRange = NSMakeRange(0, 1);
		*proposedSelRangePtr = proposedRange;
		isValid = NO;
	}
	
	return isValid;
}


@end
