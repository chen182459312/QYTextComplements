//
//  NSString+ZZStringMD5.m
//  ZZImageDownloader
//
//  Created by leo on 2020/12/27.
//

#import "NSString+ZZStringMD5.h"
#import<CommonCrypto/CommonDigest.h>

@implementation NSString (ZZStringMD5)
- (NSString *) md5 {
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return  output;
}
@end
