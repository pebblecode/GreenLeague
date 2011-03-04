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
//	NSMutableArray *sortedUniversities;
//	
//	NSMutableArray *awardClasses;
//	
//	UILocalizedIndexedCollation *collation;
//	
//
//	
//    NSManagedObjectContext *managedObjectContext;
//    NSManagedObjectModel *managedObjectModel;
//    NSPersistentStoreCoordinator *persistentStoreCoordinator;
	UniversitiesModel *universitiesModel;
	
	UISegmentedControl *sortControl;
	
	int universitySortIndex;	
}

//@property (nonatomic, retain) NSMutableArray *sortedUniversities;
//
//@property (nonatomic, retain) NSMutableArray *awardClasses;
//
//@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
//@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
//@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) UniversitiesModel *universitiesModel;
@property (nonatomic, retain) UISegmentedControl *sortControl;

//- (NSString *)applicationDocumentsDirectory;

- (id)initWithUniversitiesModel:(UniversitiesModel *)unisModel;

@end
