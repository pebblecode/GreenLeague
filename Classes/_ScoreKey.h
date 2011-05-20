// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ScoreKey.h instead.

#import <CoreData/CoreData.h>


@class Score;





@interface ScoreKeyID : NSManagedObjectID {}
@end

@interface _ScoreKey : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ScoreKeyID*)objectID;



@property (nonatomic, retain) NSString *key;

//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *text;

//- (BOOL)validateText:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *maxScore;

@property short maxScoreValue;
- (short)maxScoreValue;
- (void)setMaxScoreValue:(short)value_;

//- (BOOL)validateMaxScore:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* score;
- (NSMutableSet*)scoreSet;




@end

@interface _ScoreKey (CoreDataGeneratedAccessors)

- (void)addScore:(NSSet*)value_;
- (void)removeScore:(NSSet*)value_;
- (void)addScoreObject:(Score*)value_;
- (void)removeScoreObject:(Score*)value_;

@end

@interface _ScoreKey (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveKey;
- (void)setPrimitiveKey:(NSString*)value;




- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;




- (NSNumber*)primitiveMaxScore;
- (void)setPrimitiveMaxScore:(NSNumber*)value;

- (short)primitiveMaxScoreValue;
- (void)setPrimitiveMaxScoreValue:(short)value_;





- (NSMutableSet*)primitiveScore;
- (void)setPrimitiveScore:(NSMutableSet*)value;


@end
