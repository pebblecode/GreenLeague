//
//  UIColor+Helper.m
//  Adapted from: http://stackoverflow.com/questions/4265161/how-to-convert-hexadecimal-to-rgb/4266390#4266390
//
//  Created by Tak Tran on 02/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIColor+Helper.h"


@implementation UIColor(Helper)

// takes @"#123456"
+ (UIColor *)colorWithHexString:(NSString *)str {
    const char *cStr = [str cStringUsingEncoding:NSASCIIStringEncoding];
    long x = strtol(cStr+1, NULL, 16);
    return [UIColor colorWithHex:x];
}

// takes 0x123456
+ (UIColor *)colorWithHex:(UInt32)col {
    unsigned char r, g, b;
    b = col & 0xFF;
    g = (col >> 8) & 0xFF;
    r = (col >> 16) & 0xFF;
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1];
}

@end
