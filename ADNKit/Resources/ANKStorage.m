//
//  ANKStorage.m
//  ADNKit
//
//  Created by Levin, Joel A on 3/14/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKStorage.h"


static NSByteCountFormatter *sharedByteFormatter;
static dispatch_once_t byteFormatterOnceToken;

@implementation ANKStorage

- (NSString *)formattedAvailableStorage {
	dispatch_once(&byteFormatterOnceToken, ^{
		sharedByteFormatter = [[NSByteCountFormatter alloc] init];
	});
	return [sharedByteFormatter stringFromByteCount:self.available];
}


- (NSString *)formattedUsedStorage {
	dispatch_once(&byteFormatterOnceToken, ^{
		sharedByteFormatter = [[NSByteCountFormatter alloc] init];
	});
	return [sharedByteFormatter stringFromByteCount:self.used];
}


@end
