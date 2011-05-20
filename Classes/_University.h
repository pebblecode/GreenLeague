// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to University.h instead.

#import <CoreData/CoreData.h>


@class Score;








@interface UniversityID : NSManagedObjectID {}
@end

@interface _University : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (UniversityID*)objectID;



@property (nonatomic, retain) NSNumber *rank;

@property short rankValue;
- (short)rankValue;
- (void)setRankValue:(short)value_;

//- (BOOL)validateRank:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *awardClass;

//- (BOOL)validateAwardClass:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *rankLastYear;

@property short rankLastYearValue;
- (short)rankLastYearValue;
- (void)setRankLastYearValue:(short)value_;

//- (BOOL)validateRankLastYear:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *totalScore;

@property short totalScoreValue;
- (short)totalScoreValue;
- (void)setTotalScoreValue:(short)value_;

//- (BOOL)validateTotalScore:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *sortName;

//- (BOOL)validateSortName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* scores;
- (NSMutableSet*)scoresSet;




@end

@interface _University (CoreDataGeneratedAccessors)

- (void)addScores:(NSSet*)value_;
- (void)removeScores:(NSSet*)value_;
- (void)addScoresObject:(Score*)value_;
- (void)removeScoresObject:(Score*)value_;

@end

@interface _University (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveRank;
- (void)setPrimitiveRank:(NSNumber*)value;

- (short)primitiveRankValue;
- (void)setPrimitiveRankValue:(short)value_;




- (NSString*)primitiveAwardClass;
- (void)setPrimitiveAwardClass:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveRankLastYear;
- (void)setPrimitiveRankLastYear:(NSNumber*)value;

- (short)primitiveRankLastYearValue;
- (void)setPrimitiveRankLastYearValue:(short)value_;




- (NSNumber*)primitiveTotalScore;
- (void)setPrimitiveTotalScore:(NSNumber*)value;

- (short)primitiveTotalScoreValue;
- (void)setPrimitiveTotalScoreValue:(short)value_;




- (NSString*)primitiveSortName;
- (void)setPrimitiveSortName:(NSString*)value;





- (NSMutableSet*)primitiveScores;
- (void)setPrimitiveScores:(NSMutableSet*)value;


@end
