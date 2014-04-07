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
    return [super requestWithMethod:method
                          URLString:URLString
                         parameters:[parameters ?: @{} ank_dictionaryByAppendingDictionary:self.defaultParameters]
                              error:error];
}

@end
