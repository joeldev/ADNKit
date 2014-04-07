//
//  Created by Tony Arnold on 7/04/2014.
//

#import "ANKAPIRequestSerializer.h"
#import "ADNKit.h"

@implementation ANKAPIRequestSerializer

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(id)parameters
                                     error:(NSError * __autoreleasing *)error
{
    NSMutableDictionary *modifiedParameters = [NSMutableDictionary new];

    if ([parameters isKindOfClass:[NSDictionary class]]) {
        [modifiedParameters addEntriesFromDictionary:parameters];
    }

    if ([self.defaultParameters count] > 0) {
        [modifiedParameters addEntriesFromDictionary:self.defaultParameters];
    }

    return [super requestWithMethod:method
                          URLString:URLString
                         parameters:modifiedParameters
                              error:error];
}

@end
