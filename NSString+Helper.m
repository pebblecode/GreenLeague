//
//  NSString+Helper.m
//
//  Created by Tak Tran (Pebble Code - http://pebblecode.com)
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

- (NSDecimalNumber *)decimalNumberFromString {
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setGeneratesDecimalNumbers:YES];
    
	NSDecimalNumber *num = (NSDecimalNumber *)[formatter numberFromString:self];
	[formatter release];
	
	return num;
	
}

// Parse a string into rows and columns, under the assumption that it is in CSV format.
// From http://www.macresearch.org/cocoa-scientists-part-xxvi-parsing-csv-data
- (NSArray *)csvRows {
    NSMutableArray *rows = [NSMutableArray array];
	
    // Get newline character set
    NSMutableCharacterSet *newlineCharacterSet = (id)[NSMutableCharacterSet whitespaceAndNewlineCharacterSet];
    [newlineCharacterSet formIntersectionWithCharacterSet:[[NSCharacterSet whitespaceCharacterSet] invertedSet]];
	
    // Characters that are important to the parser
    NSMutableCharacterSet *importantCharactersSet = (id)[NSMutableCharacterSet characterSetWithCharactersInString:@",\""];
    [importantCharactersSet formUnionWithCharacterSet:newlineCharacterSet];
	
    // Create scanner, and scan string
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:nil];
    while ( ![scanner isAtEnd] ) {        
		NSAutoreleasePool * pool = [NSAutoreleasePool new];
		
        BOOL insideQuotes = NO;
        BOOL finishedRow = NO;
        NSMutableArray *columns = [NSMutableArray arrayWithCapacity:10];
        NSMutableString *currentColumn = [NSMutableString string];
        while ( !finishedRow ) {
            NSString *tempString;
            if ( [scanner scanUpToCharactersFromSet:importantCharactersSet intoString:&tempString] ) {
                [currentColumn appendString:tempString];
            }
			
            if ( [scanner isAtEnd] ) {
                if ( ![currentColumn isEqualToString:@""] ) [columns addObject:currentColumn];
                finishedRow = YES;
            }
            else if ( [scanner scanCharactersFromSet:newlineCharacterSet intoString:&tempString] ) {
                if ( insideQuotes ) {
                    // Add line break to column text
                    [currentColumn appendString:tempString];
                }
                else {
                    // End of row
                    if ( ![currentColumn isEqualToString:@""] ) [columns addObject:currentColumn];
                    finishedRow = YES;
                }
            }
            else if ( [scanner scanString:@"\"" intoString:NULL] ) {
                if ( insideQuotes && [scanner scanString:@"\"" intoString:NULL] ) {
                    // Replace double quotes with a single quote in the column string.
                    [currentColumn appendString:@"\""]; 
                }
                else {
                    // Start or end of a quoted string.
                    insideQuotes = !insideQuotes;
                }
            }
            else if ( [scanner scanString:@"," intoString:NULL] ) {  
                if ( insideQuotes ) {
                    [currentColumn appendString:@","];
                }
                else {
                    // This is a column separating comma
                    [columns addObject:currentColumn];
                    currentColumn = [NSMutableString string];
                    [scanner scanCharactersFromSet:[NSCharacterSet whitespaceCharacterSet] intoString:NULL];
                }
            }
        }
        if ( [columns count] > 0 ) [rows addObject:columns];
		
		[pool drain]; pool = nil;
    }
	
    return rows;
}

@end
