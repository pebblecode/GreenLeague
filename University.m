//
//  University.m
//  GreenLeague
//
//  Created by Tak Tran on 16/05/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "University.h"
#import "Data.h"
#import "MetaData.h"
#import "AwardClassHelper.h"

#define kDataFieldIndexRank2010 0
#define kDataFieldIndexUniversityName 1

static NSString *kUniversityEntityName = @"University";

@implementation University
@dynamic name;
@dynamic sortName;
@dynamic dataItem;
@dynamic metaDataItem;

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
// Assume database to be in the format:
//
// Organisation, key0, key1, ...
// University of Somewhere, key0value, key1value, ...
+ (void)addUniversityToDBWithManagedContext:(NSManagedObjectContext *)managedObjectContext fromRowArray:(NSArray *)rowArray headerRowArray:(NSArray *)headerRowArray {
	
    University *uni;
	
	if ([rowArray count] > kDataFieldIndexUniversityName) {
		NSString *uniName = [rowArray objectAtIndex:kDataFieldIndexUniversityName];
		if (uniName.length > 0) {
			uni = (University *)[NSEntityDescription insertNewObjectForEntityForName:[University entityName] inManagedObjectContext:managedObjectContext];
			[uni setName:uniName];
			[uni setSortName:[University getSortName:uniName]];
            
            // Store all other data fields
            int startingIndex = 1; // Ignore university
            for (int i = startingIndex; i < [rowArray count]; i++) {
                
                Data *data = (Data *)[NSEntityDescription insertNewObjectForEntityForName:[Data entityName] inManagedObjectContext:managedObjectContext];                
                [data setValue:[rowArray objectAtIndex:i]];
                [data setCriteriaKey:[headerRowArray objectAtIndex:i]];
            }
        }
    }
}

#pragma mark -
#pragma mark === Convenience methods ===
#pragma mark

- (Boolean)isValidAwardClass {
    NSLog(@"TODO: isValidAwardClass");
	//return ([self awardClassIndex] != NSNotFound);
    return false;
}

// Returns nil, if the award class is invalid
- (NSString *)awardClassName {
//	NSString *awardClassNameStr = nil;
//	int awardClassNameIndex = [self awardClassIndex];
//	if (awardClassNameIndex != NSNotFound) {	
//		awardClassNameStr = [[AwardClassHelper awardClassNames] objectAtIndex:awardClassNameIndex];
//	} else {
//		NSLog(@"awardClassName: Could not find award class name for '%@' of award class '%@'", self.name, self.awardClass);
//	}
//	return awardClassNameStr;
    
    NSLog(@"TODO: awardClassName");
    return @"TODO";
}

- (UIColor *)awardClassBackgroundColour {	
//	return [AwardClassHelper backgroundColourForAwardClassDBName:self.awardClass];
    NSLog(@"TODO: awardClassBackgroundColour");
    return [UIColor blueColor];    
}

- (UIColor *)awardClassTextColour {
//	return [AwardClassHelper textColourForAwardClassDBName:self.awardClass];	
    NSLog(@"TODO: awardClassTextColour");
    return [UIColor blueColor];        
}

#pragma mark -
#pragma mark === Helper methods ===
#pragma mark

// Get the award class index for award class arrays based on the database award class value
- (int)awardClassIndex {
//	return [[AwardClassHelper awardClassDBNames] indexOfObject:self.awardClass];
    NSLog(@"TODO: awardClassIndex");
    return 0;            
}

@end
