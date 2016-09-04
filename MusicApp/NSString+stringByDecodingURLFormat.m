//
//  NSString+stringByDecodingURLFormat.m
//  MusicApp
//
//  Created by sujian on 16/9/4.
//  Copyright © 2016年 sujian. All rights reserved.
//

#import "NSString+stringByDecodingURLFormat.h"

@implementation NSString (stringByDecodingURLFormat)
- (NSString *)stringByDecodingURLFormat{
    NSString *result = [(NSString *)self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}
@end
