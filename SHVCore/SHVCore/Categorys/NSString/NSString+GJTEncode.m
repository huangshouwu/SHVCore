//
//  NSString+GJTEncode.m
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/7/31.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import "NSString+GJTEncode.h"

@implementation NSString (GJTEncode)

- (NSString *)encodedString{
//    NSString *encodedString = (NSString *)
//    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
//                                            (CFStringRef)self,
//                                            (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
//                                            NULL,
//                                            kCFStringEncodingUTF8);
    NSString *encodedString =(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                          (CFStringRef)self,NULL,
                                                                          (CFStringRef)@"!#$%&'()*+,/:;=?@[]",
                                                                          kCFStringEncodingUTF8));
    return encodedString;
}

- (NSString *)decodedString{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)self, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
//    NSString *decodedString = (NSString *)
//    CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapes(NULL, (CFStringRef)self, NULL));
    return decodedString;
}


@end
