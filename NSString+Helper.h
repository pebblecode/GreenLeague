//
//  NSString+Helper.h
//
//  Created by Tak Tran on 09/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString(Helper)

// Remove start and end quotation marks
- (NSString *)stringByRemovingQuotationMarks;

- (NSString *)stringByTrimmingSpaces;

- (NSNumber *)numberFromString;

@end
