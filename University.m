// 
//  University.m
//  GreenLeague
//
//  Created by Tak Tran on 25/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "University.h"
#import "AwardClassHelper.h"
#import "NSString+Helper.h"

#define kUniversityEntityName "University"

// Index for the fields in the data source file
#define kDataFieldIndexRank2010 0
#define kDataFieldIndexUniversityName 1
#define kDataFieldIndexTotalScore 2
#define kDataFieldIndexAwardClass 3
#define kDataFieldIndexRank2009 5


// Private methods
@interface University()

- (int)awardClassIndex;

@end


@implementation University 

@dynamic performance11_1Data;
@dynamic performance8_2Score;
@dynamic rank2010;
@dynamic performance8_1Score;
@dynamic performance10_2Data;
@dynamic performance11_2Data;
@dynamic performanceScore;
@dynamic performance11Score;
@dynamic performance9_1Data;
@dynamic awardClass;
@dynamic performance9_2Score;
@dynamic policyScore;
@dynamic performance9_1Score;
@dynamic performance11_2Score;
@dynamic performance9_2Data;
@dynamic rank2009;
@dynamic performance11_1Score;
@dynamic performance10_2Score;
@dynamic name;
@dynamic sortName;
@dynamic performance10_1Score;
@dynamic totalScore;
@dynamic performance9Score;
@dynamic performance8Score;
@dynamic policy1Score;
@dynamic performance8_1Data;
@dynamic policy2Score;
@dynamic policy3Score;
@dynamic performance8_2Data;
@dynamic policy4Score;
@dynamic policy5Score;
@dynamic performance10Score;
@dynamic performance8_3Data;
@dynamic policy6Score;
@dynamic policy7Score;
@dynamic performance10_1Data;
@dynamic performance8_3Score;


#pragma mark -
#pragma mark === Convenience methods ===
#pragma mark

- (Boolean)isValidAwardClass {
	return ([self awardClassIndex] != NSNotFound);
}

// Returns nil, if the award class is invalid
- (NSString *)awardClassName {
	NSString *awardClassNameStr = nil;
	int awardClassNameIndex = [self awardClassIndex];
	if (awardClassNameIndex != NSNotFound) {	
		awardClassNameStr = [[AwardClassHelper awardClassNames] objectAtIndex:awardClassNameIndex];
	} else {
		NSLog(@"awardClassName: Could not find award class name for '%@' of award class '%@'", self.name, self.awardClass);
	}
	return awardClassNameStr;
}

- (UIColor *)awardClassBackgroundColour {	
	return [AwardClassHelper backgroundColourForAwardClassDBName:self.awardClass];
}

- (UIColor *)awardClassTextColour {
	return [AwardClassHelper textColourForAwardClassDBName:self.awardClass];	
}

#pragma mark -
#pragma mark === Helper methods ===
#pragma mark

// Get the award class index for award class arrays based on the database award class value
- (int)awardClassIndex {
	return [[AwardClassHelper awardClassDBNames] indexOfObject:self.awardClass];
}

#pragma mark -
#pragma mark === Class methods ===
#pragma mark

+ (NSString *)entityName {
	return [NSString stringWithString:@kUniversityEntityName];
}

// Sort name removes "University of" from the front of the name, and appends it to the back as '(University of)'
+ (NSString *)getSortName:(NSString *)aName {
	NSString *sortNameStr = aName;
	NSString *prefixToRemove = @"University of ";
	NSString *suffixToAppend = @" (University of)";
	
	int prefixSubstrIndex = [prefixToRemove length];
	if ([aName length] >= prefixSubstrIndex) {
		NSString *nameSubStr = [aName substringToIndex:prefixSubstrIndex];
		if ([nameSubStr isEqualToString:prefixToRemove]) {
			sortNameStr = [aName substringFromIndex:prefixSubstrIndex];
			sortNameStr = [sortNameStr stringByAppendingFormat:@"%@", suffixToAppend];
		}
	}
	
	return sortNameStr;
	
}

// Returns nil if there is no name
+ (void)addUniversityFromRowArray:(NSArray *)rowArray toDBWithManagedContext:(NSManagedObjectContext *)managedObjectContext {
	University *uni;
	
	//NSLog(@"csvLine: %@", csvLine);
	if ([rowArray count] > kDataFieldIndexUniversityName) {
		NSString *uniName = [[rowArray objectAtIndex:kDataFieldIndexUniversityName] stringByRemovingQuotationMarks];
		if (uniName.length > 0) {
			uni = (University *)[NSEntityDescription insertNewObjectForEntityForName:[University entityName] inManagedObjectContext:managedObjectContext];
			[uni setName:uniName];
			[uni setSortName:[University getSortName:uniName]];

			// Add other database fields
			if ([rowArray count] > kDataFieldIndexRank2010) [uni setRank2010:[[rowArray objectAtIndex:kDataFieldIndexRank2010] numberFromString]];
			if ([rowArray count] > kDataFieldIndexTotalScore) [uni setTotalScore:[[rowArray objectAtIndex:kDataFieldIndexTotalScore] numberFromString]];
			if ([rowArray count] > kDataFieldIndexAwardClass) [uni setAwardClass:[rowArray objectAtIndex:kDataFieldIndexAwardClass]];
			if ([rowArray count] > kDataFieldIndexRank2009) [uni setRank2009:[[rowArray objectAtIndex:kDataFieldIndexRank2009]numberFromString]];
			
			// ... TODO: add the rest
			// if ([rowArray count] > ) [uni set:[rowArray objectAtIndex:]];
			
			NSError *error;					
			if(![managedObjectContext save:&error]){  						
				//This is a serious error saying the record  
				//could not be saved. Advise the user to  
				//try again or restart the application.   
				NSLog(@"Error in saving the record: %@", error);
			}		
			
		} // Else, don't do anything - only valid university if it has a name
		
	}
}

@end
