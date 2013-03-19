/*
 Copyright (c) 2013, Joel Levin
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of ADNKit nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ANKUsernameFormatter.h"


@implementation ANKUsernameFormatter

- (NSString *)stringForObjectValue:(id)anObject {
	return anObject;
}


- (BOOL)getObjectValue:(id *)anObject forString:(NSString *)string errorDescription:(NSString **)error {
	if (![string hasPrefix:@"@"] && string.length > 0) {
		*anObject = [@"@" stringByAppendingString:string];
	} else if ([string isEqualToString:@"@"]) {
		*anObject = @"";
	} else {
		*anObject = string;
	}
	
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
