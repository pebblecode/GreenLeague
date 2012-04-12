//
//  NSNumber+Helper.m
//
//  Created by Tak Tran (Pebble Code - http://pebblecode.com)
//

#import "NSNumber+Helper.h"


@implementation NSNumber(Helper)

// Return the ordinal string eg, 1 returns '1st', 34 return '34th'
// Note: only works for integers
- (NSString *)ordinalString {
	int lastDigit = [self intValue] % 10;
	NSString *returnStr;
	
	if (lastDigit == 1) {
		returnStr = [NSString stringWithFormat:@"%dst", [self intValue]]; 
	} else if (lastDigit == 2) {
		returnStr = [NSString stringWithFormat:@"%dnd", [self intValue]]; 
	} else if (lastDigit == 3) {
		returnStr = [NSString stringWithFormat:@"%drd", [self intValue]]; 
	} else {
		returnStr = [NSString stringWithFormat:@"%dth", [self intValue]]; 
	}
	
	return returnStr;
}

@end
