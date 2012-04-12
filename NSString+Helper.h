//
//  NSString+Helper.h
//
//  Created by Tak Tran (Pebble Code - http://pebblecode.com)
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString(Helper)

// Remove start and end quotation marks
- (NSString *)stringByRemovingQuotationMarks;

- (NSString *)stringByTrimmingSpaces;

- (NSNumber *)numberFromString;
- (NSDecimalNumber *)decimalNumberFromString;

- (NSArray *)csvRows;

@end
