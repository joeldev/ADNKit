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
    NSError *responseError;

    id originalResponse = [super responseObjectForResponse:response data:data error:&responseError];

    NSDictionary* headers = [(NSHTTPURLResponse *)response allHeaderFields];
    ANKAPIResponse *apiResponse = [[ANKAPIResponse alloc] initWithResponseObject:originalResponse andHeaders:headers];

    if (responseError) {
        NSMutableDictionary *modifiedUserInfo = [responseError.userInfo mutableCopy];
        modifiedUserInfo[kANKAPIResponseKey] = apiResponse;
        responseError = [NSError errorWithDomain:responseError.domain code:responseError.code userInfo:modifiedUserInfo];
    }

    if (error && responseError) {
        *error = responseError;
    }
    
    return apiResponse;
}

@end
