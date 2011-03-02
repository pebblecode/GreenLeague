//
//  UIColor+Helper.h
//  Adapted from: http://stackoverflow.com/questions/4265161/how-to-convert-hexadecimal-to-rgb/4266390#4266390
//
//  Created by Tak Tran on 02/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIColor(Helper) 

+ (UIColor *)colorWithHex:(UInt32)col;
+ (UIColor *)colorWithHexString:(NSString *)str;

@end
