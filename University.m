// 
//  University.m
//  GreenLeague
//
//  Created by Tak Tran on 25/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "University.h"
#import "NSString+Helper.h"

#define kUniversityEntityName "University"
#define kCSVDelimiter ","

// Index for the fields in the data source file
#define kDataFieldIndexRank2010 0
#define kDataFieldIndexUniversityName 1
#define kDataFieldIndexTotalScore 2
#define kDataFieldIndexAwardClass 3

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
#pragma mark === Class methods ===
#pragma mark

+ (NSString *)entityName {
	return [NSString stringWithString:@kUniversityEntityName];
}

// Returns nil if there is no name
+ (University *)universityFromCSVLine:(NSString *)csvLine withManagedContext:(NSManagedObjectContext *)managedObjectContext {
	University *uni;
	
	//NSLog(@"csvLine: %@", csvLine);
	NSArray *dataItem = [csvLine componentsSeparatedByString:@kCSVDelimiter];	
	if ([dataItem count] > kDataFieldIndexUniversityName) {
		NSString *uniName = [[dataItem objectAtIndex:kDataFieldIndexUniversityName] stringByRemovingQuotationMarks];
		if (uniName.length > 0) {
			uni = (University *)[NSEntityDescription insertNewObjectForEntityForName:[University entityName] inManagedObjectContext:managedObjectContext];
			[uni setName:uniName];			
			
			// Add other database fields
			if ([dataItem count] > kDataFieldIndexRank2010) [uni setRank2010:[dataItem objectAtIndex:kDataFieldIndexRank2010]];
			if ([dataItem count] > kDataFieldIndexTotalScore) [uni setTotalScore:[[dataItem objectAtIndex:kDataFieldIndexTotalScore] numberFromString]];
			if ([dataItem count] > kDataFieldIndexAwardClass) [uni setAwardClass:[dataItem objectAtIndex:kDataFieldIndexAwardClass]];
			
			// ... TODO
			
			NSError *error;					
			if(![managedObjectContext save:&error]){  						
				//This is a serious error saying the record  
				//could not be saved. Advise the user to  
				//try again or restart the application.   
				NSLog(@"Error in saving the record: %@", error);
			}		
			
		} // Else, don't do anything - only valid university if it has a name
		
	}
	//NSLog(@"universityFromCSVLine uni: %@", uni);
	return [uni autorelease];
}

@end
