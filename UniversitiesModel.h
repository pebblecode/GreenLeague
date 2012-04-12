//
//  UniversitiesModel.h
//  GreenLeague
//
//  Sets up the database. Loads data from the .csv file if required.
//  Uses the csv file from `kDataSourceFile`, and title/heading keys 
//  from `kScoreKeySourceFile`.
//
//  Created by Tak Tran (Pebble Code - http://pebblecode.com)
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "University.h"
#import "Score.h"
#import "ScoreKey.h"

@interface UniversitiesModel : NSObject {
	NSMutableArray *sortedUniversities;	
	NSMutableArray *awardClasses;
    NSMutableArray *questionScoreKeys;
	UILocalizedIndexedCollation *collation;
			
    NSManagedObjectContext *managedObjectContext;
    NSManagedObjectModel *managedObjectModel;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
}

@property (nonatomic, retain) NSMutableArray *sortedUniversities;
@property (nonatomic, retain) NSMutableArray *awardClasses;
@property (nonatomic, retain) NSMutableArray *questionScoreKeys;
@property (nonatomic, retain) UILocalizedIndexedCollation *collation;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (Score *)findScoreForUniversity:(University *)uni scoreKey:(ScoreKey *)scoreKey;
- (University *)topRankedUniversity;


@end
