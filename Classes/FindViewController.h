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
	NSMutableArray *universities; 
	NSMutableArray *awardClasses;
	UILocalizedIndexedCollation *collation;
	
    NSManagedObjectContext *managedObjectContext;
    NSManagedObjectModel *managedObjectModel;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
	
	UISegmentedControl *sortControl;
}

@property (nonatomic, retain) NSMutableArray *universities;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain, readonly) UISegmentedControl *sortControl;

- (void)fetchRankedUniversitiesSortBy:(NSString *)sortField;
- (NSString *)applicationDocumentsDirectory;

@end
