//
//  ANKStreamContext.m
//  ADNKit
//
//  Created by Kolin Krewinkel on 6/8/13.
//  Copyright (c) 2013 Afterwork Studios. All rights reserved.
//

#import "ANKStreamContext.h"

@implementation ANKStreamContext

#pragma mark -
#pragma mark Designated Initializer

- (id)initWithBaseOperation:(ANKJSONRequestOperation *)operation identifier:(NSString *)identifier socketShuttle:(KATSocketShuttle *)socketShuttle streamingDelegate:(id<ANKStreamingDelegate>)streamingDelegate {
    if ((self = [super init])) {
        self.baseOperation = operation;
        self.identifier = identifier;
        self.socketShuttle = socketShuttle;
        self.streamingDelegate = streamingDelegate;
    }

    return self;
}

#pragma mark -
#pragma mark Convenience

//- (NSURLRequest *)streamingOperationRequest
//{
//    NSMutableURLRequest *request = self.baseOperation.request.mutableCopy;
//    request.URL = [NSURL URLWithString:[[[[request.URL.absoluteString stringByAppendingFormat:@"&connection_id=%@", self.identifier] stringByReplacingOccurrencesOfString:request.URL.scheme withString:@"wss"] stringByReplacingOccurrencesOfString:request.URL.host withString:@"stream-channel.app.net"]]];
//
//    return request;
//}
//

@end
