//
//  NSString+Helper.m
//
//  Created by Tak Tran on 09/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSString+Helper.h"


@implementation NSString(Helper)

// Remove start and end quotation marks
- (NSString *)stringByRemovingQuotationMarks {
	NSString *newStr = [self copy];
	if (newStr.length > 0) {
		// Start quotation mark
		if ([newStr characterAtIndex:0] == '"') {
			newStr = [newStr substringFromIndex:1];
		}
		// End quotation mark		
		if ([newStr characterAtIndex:(newStr.length - 1)] == '"') {
			newStr = [newStr substringToIndex:(newStr.length - 1)];
		}
	}
	return newStr;
}

- (NSString *)stringByTrimmingSpaces {
	NSString *newStr = [self copy];
	if (newStr.length > 0) {
		newStr = [newStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	}
	return newStr;
}


- (NSNumber *)numberFromString {
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	NSNumber *num = [formatter numberFromString:self];
	[formatter release];
	
	return num;
	
}

@end
