//
//  UIColor+Helper.h
//  Adapted from: http://stackoverflow.com/questions/4265161/how-to-convert-hexadecimal-to-rgb/4266390#4266390
//
//  Created by Tak Tran (Pebble Code - http://pebblecode.com)
//

#import <Foundation/Foundation.h>

@interface UIColor(Helper) 

+ (UIColor *)colorWithHex:(UInt32)col;
+ (UIColor *)colorWithHexString:(NSString *)str;

@end
