//
//  University.h
//  GreenLeague
//
//  Created by Tak Tran on 19/05/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Score;

@interface University : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * rankLastYear;
@property (nonatomic, retain) NSString * awardClass;
@property (nonatomic, retain) NSNumber * totalScore;
@property (nonatomic, retain) NSNumber * rank;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * sortName;
@property (nonatomic, retain) NSSet* scores;

+ (NSString *)entityName;
+ (NSString *)getSortName:(NSString *)aName;
+ (void)addUniversityToDBWithManagedContext:(NSManagedObjectContext *)managedObjectContext fromRowArray:(NSArray *)rowArray headerRowArray:(NSArray *)headerRowArray;


// Convenience methods
- (Boolean)isValidAwardClass;
- (NSString *)awardClassName;

- (UIColor *)awardClassBackgroundColour;
- (UIColor *)awardClassTextColour;

@end
