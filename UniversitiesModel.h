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

@interface UniversitiesModel : NSObject {
	NSMutableArray *sortedUniversities;	
	NSMutableArray *awardClasses;
    NSMutableArray *rankedUniversities;
    
	UILocalizedIndexedCollation *collation;
			
    NSManagedObjectContext *managedObjectContext;
    NSManagedObjectModel *managedObjectModel;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
}

@property (nonatomic, retain) NSMutableArray *sortedUniversities; // Alphabetically sorted list of universities, based on the sort name
@property (nonatomic, retain) NSMutableArray *awardClasses; // Ranked universities categorised into an array of award classes
@property (nonatomic, retain) NSMutableArray *rankedUniversities; // Rank sorted universities

@property (nonatomic, retain) UILocalizedIndexedCollation *collation;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (University *)topRankedUniversity;

@end
