//
//  FindViewController.h
//  GreenLeague
//
//  Created by Tak Tran on 23/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>


@interface FindViewController : UITableViewController {
	NSMutableArray *universities; // For sorting by university
	NSMutableArray *sortedUniversities;
	
	NSMutableArray *awardClasses;
	NSMutableArray *awardClassIndexTitles;
	NSMutableArray *awardClassDBNames;
	
	UILocalizedIndexedCollation *collation;
	
	NSMutableArray *awardClassNames;
	
    NSManagedObjectContext *managedObjectContext;
    NSManagedObjectModel *managedObjectModel;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
	
	UISegmentedControl *sortControl;
	
	int universitySortIndex;	
}

@property (nonatomic, retain) NSMutableArray *universities;
@property (nonatomic, retain) NSMutableArray *sortedUniversities;

@property (nonatomic, retain) NSMutableArray *awardClasses;
@property (nonatomic, retain) NSMutableArray *awardClassNames;
@property (nonatomic, retain) NSMutableArray *awardClassIndexTitles;
@property (nonatomic, retain) NSMutableArray *awardClassDBNames;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) UISegmentedControl *sortControl;

//- (void)fetchRankedUniversitiesSortBy:(NSString *)sortField;
- (NSString *)applicationDocumentsDirectory;

@end
