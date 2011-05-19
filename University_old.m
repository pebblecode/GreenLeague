//
//  University.m
//  GreenLeague
//
//  Created by Tak Tran on 16/05/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "University.h"
#import "Score.h"
#import "ScoreKey.h"
#import "AwardClassHelper.h"
#import "NSString+Helper.h"

#define kUniversityNameHeaderFieldIndex 0

static NSString *kRankHeaderField = @"gl11_rank/quantity";
static NSString *kRankLastYearHeaderField = @"gl11_last_year_rank/quantity";

static NSString *kTotalScoreHeaderField = @"gl11_total_score/quantity";
static NSString *kAwardClassHeaderField = @"gl11_class/singleChoice";

static NSString *kUniversityEntityName = @"University";


// Private methods
@interface University()

- (int)awardClassIndex;

@end

@implementation University
@dynamic name;
@dynamic sortName;
@dynamic rank;
@dynamic rankLastYear;
@dynamic awardClass;
@dynamic totalScore;
@dynamic score;

#pragma mark -
#pragma mark === Class methods ===
#pragma mark

+ (NSString *)entityName {
	return [NSString stringWithString:kUniversityEntityName];
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
//
// Assume csv to be in the format:
//
// Organisation, data keys, ..., meta data keys ...
// University of Somewhere, data values, ..., meta data values ...
//
+ (void)addUniversityToDBWithManagedContext:(NSManagedObjectContext *)managedObjectContext fromRowArray:(NSArray *)rowArray headerRowArray:(NSArray *)headerRowArray {
	
    University *uni = (University *)[NSEntityDescription insertNewObjectForEntityForName:[University entityName] inManagedObjectContext:managedObjectContext];
    
    // Handle university name field    
    NSString *uniName = [rowArray objectAtIndex:kUniversityNameHeaderFieldIndex];
    if ([uniName length] > 0) {
        
        [uni setName:uniName];
        [uni setSortName:[University getSortName:uniName]];        
        NSLog(@"Adding: %@", uniName);
        
        // Handle the rest of the fields for fields after the university name field
        for (int i = (kUniversityNameHeaderFieldIndex + 1); i < [rowArray count]; i++) {
            
            // Use header value to determine what column it is
            ScoreKey *headerValue = [headerRowArray objectAtIndex:i];
            if (![headerValue isKindOfClass:[NSNull class]]) { // Not null
                NSString *scoreKeyString = headerValue.key;
                NSString *rowValue = [rowArray objectAtIndex:i];
                
                if ([scoreKeyString isEqualToString:kRankHeaderField]) {
                    
                    [uni setRank:[rowValue numberFromString]];             
                    
                } else if ([scoreKeyString isEqualToString:kRankLastYearHeaderField]) {
                    
                    [uni setRankLastYear:[rowValue numberFromString]];             
                    
                } else if ([scoreKeyString isEqualToString:kTotalScoreHeaderField]) {            
                    
                    [uni setTotalScore:[rowValue numberFromString]];             
                    
                } else if ([scoreKeyString isEqualToString:kAwardClassHeaderField]) { 
                    
                    [uni setAwardClass:rowValue];
                } else {
                    // Store as score with the header value
                    Score *score = (Score *)[NSEntityDescription insertNewObjectForEntityForName:[Score entityName] inManagedObjectContext:managedObjectContext];
                    [score setKey:headerValue];            
                    [score setValue:rowValue];
                    [score setUniversity:uni];
                }
            } else {
                NSLog(@"Header value is null at index: %d", i);
            }
            
            // Save data
            NSError *error;					
            if(![managedObjectContext save:&error]) {
                //This is a serious error saying the record  
                //could not be saved. Advise the user to  
                //try again or restart the application.   
                NSLog(@"Error in saving the record: %@", error);
            }       
        }
    }
    
}

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

@end
