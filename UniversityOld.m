// 
//  University.m
//  GreenLeague
//
//  Created by Tak Tran on 25/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AwardClassHelper.h"
#import "NSString+Helper.h"

// Index for the fields in the data source file
#define kDataFieldIndexRank2010 0
#define kDataFieldIndexUniversityName 1
#define kDataFieldIndexTotalScore 2
#define kDataFieldIndexAwardClass 3
#define kDataFieldIndexRank2009 5

#define kDataFieldPolicyScore 7
#define kDataFieldPolicy1Score 10
#define kDataFieldPolicy2Score 11
#define kDataFieldPolicy3Score 12
#define kDataFieldPolicy4Score 13
#define kDataFieldPolicy5Score 14
#define kDataFieldPolicy6Score 15
#define kDataFieldPolicy7Score 16

#define kDataFieldPerformanceScore 8
#define kDataFieldPerformance8Score 18
#define kDataFieldPerformance8_1Data 23
#define kDataFieldPerformance8_1Score 24
#define kDataFieldPerformance8_2Data 25
#define kDataFieldPerformance8_2Score 26
#define kDataFieldPerformance8_3Data 27
#define kDataFieldPerformance8_3Score 28
#define kDataFieldPerformance9Score 19
#define kDataFieldPerformance9_1Data 29
#define kDataFieldPerformance9_1Score 30
#define kDataFieldPerformance9_2Data 31
#define kDataFieldPerformance9_2Score 32
#define kDataFieldPerformance10Score 20
#define kDataFieldPerformance10_1Data 33
#define kDataFieldPerformance10_1Score 34
#define kDataFieldPerformance10_2Data 35
#define kDataFieldPerformance10_2Score 36
#define kDataFieldPerformance11Score 21
#define kDataFieldPerformance11_1Data 37
#define kDataFieldPerformance11_1Score 38
#define kDataFieldPerformance11_2Data 39
#define kDataFieldPerformance11_2Score 40

static NSString *kUniversityEntityName = @"University";


// Private methods
@interface UniversityOld()

- (int)awardClassIndex;

@end


@implementation UniversityOld 

@dynamic name;
@dynamic sortName;
@dynamic rank2009;
@dynamic rank2010;
@dynamic awardClass;
@dynamic totalScore;

@dynamic policyScore;
@dynamic policy1Score;
@dynamic policy2Score;
@dynamic policy3Score;
@dynamic policy4Score;
@dynamic policy5Score;
@dynamic policy6Score;
@dynamic policy7Score;

@dynamic performanceScore;
@dynamic performance8Score;
@dynamic performance8_1Data;
@dynamic performance8_1Score;
@dynamic performance8_2Data;
@dynamic performance8_2Score;
@dynamic performance8_3Data;
@dynamic performance8_3Score;
@dynamic performance9Score;
@dynamic performance9_1Data;
@dynamic performance9_1Score;
@dynamic performance9_2Data;
@dynamic performance9_2Score;
@dynamic performance10Score;
@dynamic performance10_1Data;
@dynamic performance10_1Score;
@dynamic performance10_2Data;
@dynamic performance10_2Score;
@dynamic performance11Score;
@dynamic performance11_1Data;
@dynamic performance11_1Score;
@dynamic performance11_2Data;
@dynamic performance11_2Score;


#pragma mark -
#pragma mark === Init/Dealloc ===
#pragma mark

//- (id)init {
//	if (self = [super init]) {			
//
//	}
//	return self;
//}

// Is this needed?
//- (void)dealloc {
//	[name release];
//	[sortName release];
//	[rank2009 release];
//	[rank2010 release];
//	[awardClass release];
//	[totalScore release];
//	
//	[policyScore release];
//	[policy1Score release];
//	[policy2Score release];
//	[policy3Score release];
//	[policy4Score release];
//	[policy5Score release];
//	[policy6Score release];
//	[policy7Score release];
//	
//	[performanceScore release];
//	[performance8Score release];
//	[performance8_1Data release];
//	[performance8_1Score release];
//	[performance8_2Data release];
//	[performance8_2Score release];
//	[performance8_3Data release];
//	[performance8_3Score release];
//	[performance9Score release];
//	[performance9_1Data release];
//	[performance9_1Score release];
//	[performance9_2Data release];
//	[performance9_2Score release];
//	[performance10Score release];
//	[performance10_1Data release];
//	[performance10_1Score release];
//	[performance10_2Data release];
//	[performance10_2Score release];
//	[performance11Score release];
//	[performance11_1Data release];
//	[performance11_1Score release];
//	[performance11_2Data release];
//	[performance11_2Score release];	
//}

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
#pragma mark === Max score methods ===
#pragma mark

- (NSNumber *)policy1MaxScore {
    return [NSNumber numberWithInt:6];
}

- (NSNumber *)policy2MaxScore {
    return [NSNumber numberWithInt:8];    
}

- (NSNumber *)policy3MaxScore {
    return [NSNumber numberWithInt:8];
}

- (NSNumber *)policy4MaxScore {
    return [NSNumber numberWithInt:4];
}

- (NSNumber *)policy5MaxScore {
    return [NSNumber numberWithInt:8];
}

- (NSNumber *)policy6MaxScore {
    return [NSNumber numberWithInt:3];
}

- (NSNumber *)policy7MaxScore {
    return [NSNumber numberWithInt:3];
}

- (NSNumber *)performance8MaxScore {
    return [NSNumber numberWithInt:6];
}

- (NSNumber *)performance9MaxScore {
    return [NSNumber numberWithInt:8];
}

- (NSNumber *)performance10MaxScore {
    return [NSNumber numberWithInt:8];
}

- (NSNumber *)performance11MaxScore {
    return [NSNumber numberWithInt:8];
}

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
+ (void)addUniversityToDBWithManagedContext:(NSManagedObjectContext *)managedObjectContext fromRowArray:(NSArray *)rowArray {
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
			
			if ([rowArray count] > kDataFieldPolicyScore) [uni setPolicyScore:[[rowArray objectAtIndex:kDataFieldPolicyScore] numberFromString]];
			if ([rowArray count] > kDataFieldPolicy1Score) [uni setPolicy1Score:[[rowArray objectAtIndex:kDataFieldPolicy1Score] numberFromString]];
			if ([rowArray count] > kDataFieldPolicy2Score) [uni setPolicy2Score:[[rowArray objectAtIndex:kDataFieldPolicy2Score] numberFromString]];
			if ([rowArray count] > kDataFieldPolicy3Score) [uni setPolicy3Score:[[rowArray objectAtIndex:kDataFieldPolicy3Score] numberFromString]];
			if ([rowArray count] > kDataFieldPolicy4Score) [uni setPolicy4Score:[[rowArray objectAtIndex:kDataFieldPolicy4Score] numberFromString]];
			if ([rowArray count] > kDataFieldPolicy5Score) [uni setPolicy5Score:[[rowArray objectAtIndex:kDataFieldPolicy5Score] numberFromString]];
			if ([rowArray count] > kDataFieldPolicy6Score) [uni setPolicy6Score:[[rowArray objectAtIndex:kDataFieldPolicy6Score] numberFromString]];
			if ([rowArray count] > kDataFieldPolicy7Score) [uni setPolicy7Score:[[rowArray objectAtIndex:kDataFieldPolicy7Score] numberFromString]];
						
			if ([rowArray count] > kDataFieldPerformanceScore) [uni setPerformanceScore:[[rowArray objectAtIndex:kDataFieldPerformanceScore] numberFromString]];
			if ([rowArray count] > kDataFieldPerformance8Score) [uni setPerformance8Score:[[rowArray objectAtIndex:kDataFieldPerformance8Score] numberFromString]];
			if ([rowArray count] > kDataFieldPerformance8_1Data) [uni setPerformance8_1Data:[[rowArray objectAtIndex:kDataFieldPerformance8_1Data] numberFromString]];
			if ([rowArray count] > kDataFieldPerformance8_1Score) [uni setPerformance8_1Score:[[rowArray objectAtIndex:kDataFieldPerformance8_1Score] numberFromString]];
			if ([rowArray count] > kDataFieldPerformance8_2Data) [uni setPerformance8_2Data:[[rowArray objectAtIndex:kDataFieldPerformance8_2Data] numberFromString]];
			if ([rowArray count] > kDataFieldPerformance8_2Score) [uni setPerformance8_2Score:[[rowArray objectAtIndex:kDataFieldPerformance8_2Score] numberFromString]];
			if ([rowArray count] > kDataFieldPerformance8_3Data) [uni setPerformance8_3Data:[[rowArray objectAtIndex:kDataFieldPerformance8_3Data] numberFromString]];
			if ([rowArray count] > kDataFieldPerformance8_3Score) [uni setPerformance8_3Score:[[rowArray objectAtIndex:kDataFieldPerformance8_3Score] numberFromString]];
			if ([rowArray count] > kDataFieldPerformance9Score) [uni setPerformance9Score:[[rowArray objectAtIndex:kDataFieldPerformance9Score] numberFromString]];
			if ([rowArray count] > kDataFieldPerformance9_1Data) [uni setPerformance9_1Data:[[rowArray objectAtIndex:kDataFieldPerformance9_1Data] numberFromString]];
			if ([rowArray count] > kDataFieldPerformance9_1Score) [uni setPerformance9_1Score:[[rowArray objectAtIndex:kDataFieldPerformance9_1Score] numberFromString]];
			if ([rowArray count] > kDataFieldPerformance9_2Data) [uni setPerformance9_2Data:[[rowArray objectAtIndex:kDataFieldPerformance9_2Data] numberFromString]];
			if ([rowArray count] > kDataFieldPerformance9_2Score) [uni setPerformance9_2Score:[[rowArray objectAtIndex:kDataFieldPerformance9_2Score] numberFromString]];
			if ([rowArray count] > kDataFieldPerformance10Score) [uni setPerformance10Score:[[rowArray objectAtIndex:kDataFieldPerformance10Score] numberFromString]];
			if ([rowArray count] > kDataFieldPerformance10_1Data) [uni setPerformance10_1Data:[[rowArray objectAtIndex:kDataFieldPerformance10_1Data] numberFromString]];
			if ([rowArray count] > kDataFieldPerformance10_1Score) [uni setPerformance10_1Score:[[rowArray objectAtIndex:kDataFieldPerformance10_1Score] numberFromString]];
			if ([rowArray count] > kDataFieldPerformance10_2Data) [uni setPerformance10_2Data:[[rowArray objectAtIndex:kDataFieldPerformance10_2Data] numberFromString]];
			if ([rowArray count] > kDataFieldPerformance10_2Score) [uni setPerformance10_2Score:[[rowArray objectAtIndex:kDataFieldPerformance10_2Score] numberFromString]];
			if ([rowArray count] > kDataFieldPerformance11Score) [uni setPerformance11Score:[[rowArray objectAtIndex:kDataFieldPerformance11Score] numberFromString]];
			if ([rowArray count] > kDataFieldPerformance11_1Data) [uni setPerformance11_1Data:[[rowArray objectAtIndex:kDataFieldPerformance11_1Data] numberFromString]];
			if ([rowArray count] > kDataFieldPerformance11_1Score) [uni setPerformance11_1Score:[[rowArray objectAtIndex:kDataFieldPerformance11_1Score] numberFromString]];
			if ([rowArray count] > kDataFieldPerformance11_2Data) [uni setPerformance11_2Data:[[rowArray objectAtIndex:kDataFieldPerformance11_2Data] numberFromString]];
			if ([rowArray count] > kDataFieldPerformance11_2Score) [uni setPerformance11_2Score:[[rowArray objectAtIndex:kDataFieldPerformance11_2Score] numberFromString]];
			
			NSError *error;					
			if(![managedObjectContext save:&error]) {
				//This is a serious error saying the record  
				//could not be saved. Advise the user to  
				//try again or restart the application.   
				NSLog(@"Error in saving the record: %@", error);
			}		
			
		} // Else, don't do anything - only valid university if it has a name
		
	}
}

@end
