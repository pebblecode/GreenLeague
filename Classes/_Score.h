// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Score.h instead.

#import <CoreData/CoreData.h>


@class ScoreKey;
@class University;



@interface ScoreID : NSManagedObjectID {}
@end

@interface _Score : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ScoreID*)objectID;



@property (nonatomic, retain) NSString *value;

//- (BOOL)validateValue:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) ScoreKey* key;
//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) University* university;
//- (BOOL)validateUniversity:(id*)value_ error:(NSError**)error_;




@end

@interface _Score (CoreDataGeneratedAccessors)

@end

@interface _Score (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveValue;
- (void)setPrimitiveValue:(NSString*)value;





- (ScoreKey*)primitiveKey;
- (void)setPrimitiveKey:(ScoreKey*)value;



- (University*)primitiveUniversity;
- (void)setPrimitiveUniversity:(University*)value;


@end
