//
//  UniversitiesModel.h
//  GreenLeague
//
//  Created by Tak Tran on 04/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
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
