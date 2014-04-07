//
//  Created by Tony Arnold on 7/04/2014.
//

#import "ANKAPIResponseSerializer.h"
#import "ADNKit.h"

@implementation ANKAPIResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    id originalResponse = [super responseObjectForResponse:response data:data error:error];
    return [[ANKAPIResponse alloc] initWithResponseObject:originalResponse];
}

@end
