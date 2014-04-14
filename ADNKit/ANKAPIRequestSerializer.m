//
//  Created by Tony Arnold on 7/04/2014.
//

#import "ANKAPIRequestSerializer.h"
#import "ADNKit.h"

@implementation ANKAPIRequestSerializer

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(id)parameters
                                     error:(NSError *__autoreleasing *)error
{
    if ((self.defaultParameters.count > 0) && [parameters isKindOfClass:[NSDictionary class]]) {
        parameters = [(NSDictionary *)parameters ank_dictionaryByAppendingDictionary : self.defaultParameters];
    }

    NSMutableString *modifiedURLString = [URLString mutableCopy];

    [self.defaultParameters enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL *stop) {
                                NSString *delimiter = (NSNotFound == [modifiedURLString rangeOfString:@"?"].location) ? @"?" : @"&";
                                [modifiedURLString appendFormat:@"%@%@=%@", delimiter, key, obj];
                            }];

    return [super requestWithMethod:method
                          URLString:modifiedURLString
                         parameters:parameters
                              error:error];
}

@end
