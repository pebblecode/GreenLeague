//
//  AwardClassHelper.m
//  GreenLeague
//
//  Created by Tak on 3/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AwardClassHelper.h"
#import "UIColor+Helper.h"

@implementation AwardClassHelper


+ (NSArray *)awardClassDBNames {
	static NSArray *dbNames = nil;
	
	if (!dbNames) {
		dbNames = [[NSArray alloc] initWithObjects:
					@"1st", 
					@"2:1", 
					@"2:2", 
					@"3rd", 
					@"Fail", 
					@"Did not sit exam", 
					nil];
	}
	
	return dbNames;
}

+ (NSArray *)awardClassIndexTitles {
	static NSArray *indexTitles = nil;

	if (!indexTitles) {
		indexTitles = [[NSArray alloc] initWithObjects:
					   @"1st", 
					   @"Upper 2nd", 
					   @"Lower 2nd", 
					   @"3rd", 
					   @"Failed", 
					   @"N/A", 
					   nil];		
	}
	
	return indexTitles;	
}

+ (NSArray *)awardClassNames {
	static NSArray *classNames = nil;
	
	if (!classNames) {
		classNames = [[NSArray alloc] initWithObjects:
					  @"1st Class award", 
					  @"Upper 2nd Class award", 
					  @"Lower 2nd Class award", 
					  @"3rd Class award", 
					  @"Failed. No award", 
					  @"Did not sit exam. No award", nil];
	}

	return classNames;
}

// Colour code university based on award class
+ (NSArray *)awardClassColours {
	static NSArray *colours = nil;
	
	if (!colours) {
		colours = [[NSArray alloc] initWithObjects:
						  [UIColor colorWithHexString:@"#DFFAD8"], // Light green
						  [UIColor colorWithHexString:@"#F8F8CF"], // Light yellow
						  [UIColor colorWithHexString:@"#FFEFDF"], // Light orange
						  [UIColor colorWithHexString:@"#F0E0E0"], // Pink
						  [UIColor colorWithHexString:@"#EEB8B8"], // Light Red
						  [UIColor colorWithHexString:@"#DDDDDD"], // Light gray
						  nil];
	}
	
	return colours;
}

// Find colour from awardClassColours. If not found, then use white.
+ (UIColor *)backgroundColourForAwardClassDBName:(NSString *)awardClassDBName {
	UIColor *colour = nil;
	
	int awardClassColourIndex = [[AwardClassHelper awardClassDBNames] indexOfObject:awardClassDBName];	
	if (awardClassColourIndex != NSNotFound) {
		colour = [[AwardClassHelper awardClassColours] objectAtIndex:awardClassColourIndex];
	} else {
		colour = [UIColor whiteColor]; // Default colour is white
	}
	return colour;
}

// Green for everything except for "Did not sit exam", which is black
+ (UIColor *)textColourForAwardClassDBName:(NSString *)awardClassDBName {
	UIColor *colour;
	if ([awardClassDBName isEqualToString:@"Did not sit exam"]) {
		colour = [UIColor colorWithHexString:@"#666666"]; // Black
	} else {
		colour = [UIColor colorWithHexString:@"#6F8A00"]; // Green
	}
	
	return colour;
}
 

@end
