//
//  UniversitiesModel.m
//  GreenLeague
//
//  Created by Tak Tran on 04/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UniversitiesModel.h"
#import "AwardClassHelper.h"
#import "NSString+Helper.h"
#import "ScoreKey.h"

// Data source file minus the file extension
static NSString *kDataSourceFile = @"gl11-export-filtered";
static NSString *kScoreKeySourceFile = @"gl11-export-draft-key";
static NSString *kDatabaseSqliteFile = @"green_league.sqlite";
#define kDataCSVRowsToIgnore 1

// Database field names
static NSString *kDBFieldRank = @"rank";
static NSString *kDBFieldName = @"name";
//static NSString *kDBFieldSortName = @"sortName";
//static NSString *kDBFieldScore = @"score";
static NSString *kDBFieldAwardClass = @"awardClass";

static NSString *kDBFieldScoreKey = @"key";
static NSString *kDBFieldScoreUniversity = @"university";

static NSString *kDBFieldQuestionSuffix = @"_subtotal";

@interface UniversitiesModel()

- (void)fetchUniversitiesFromDBSortedByRank;
- (void)fetchUniversitiesFromDBSortedByName;

- (void)loadGreenLeagueDataFromFileToDB;
- (void)loadKeysFromFileToDB;
- (void)loadDataFromFileToDB;

- (NSString *)dbPath;
- (Boolean)dbExists;
- (void)setupDB;
- (void)deleteDB;
- (NSString *)applicationDocumentsDirectory;

@end



@implementation UniversitiesModel

@synthesize sortedUniversities, awardClasses, questionScoreKeys, collation, managedObjectContext, managedObjectModel, persistentStoreCoordinator;

- (id)init {
	if ((self = [super init])) {			
		// --------------------------------------------------
		// To remove the db all the time (for debugging only)
		//[self deleteDB];		
		// --------------------------------------------------
		
		[self setupDB];
		
		// Get both types of sort for the time being
		// TODO: make this more elegant
		[self fetchUniversitiesFromDBSortedByRank];
		[self fetchUniversitiesFromDBSortedByName];
		
	}
	return self;		
}

- (void)dealloc {
	[sortedUniversities release];	
	[awardClasses release];
	[questionScoreKeys release];
    [collation release];
	
	[managedObjectContext release];
	[managedObjectModel release];
	[persistentStoreCoordinator release];	
	
    [super dealloc];
}

#pragma mark -
#pragma mark === Database methods ===
#pragma mark

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    
    if (managedObjectContext) {
        return managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel) {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator) {
        return persistentStoreCoordinator;
    }    
	
	// This is used to create the db in the application documents directory in the app - once it's created, it can be transferred to the Resources directory in xcode
    NSURL *storeUrl = [NSURL fileURLWithPath:[self dbPath]];
	
	// To load the db from the application directory (in Resources in xcode). For when the database has been created already. 
	//	NSString *dbFilePath = [[NSBundle mainBundle] pathForResource:@"random_db" ofType:@"sqlite"];
	//	NSLog(@"[NSBundle mainBundle] = %@", [NSBundle mainBundle]);
	//	NSLog(@"dbFilePath = %@", dbFilePath);
	//	NSURL *storeUrl = [NSURL fileURLWithPath:dbFilePath];	
	
	//NSLog(@"storeUrl(%@) exists = %@", storeUrl, ([[NSFileManager defaultManager] fileExistsAtPath:storeUrl.path] ? @"YES" : @"NO"));
    
    NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
	// Create file if it does not exist
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible
         * The schema for the persistent store is incompatible with current managed object model
         Check the error message to determine what the actual problem was.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
	
	NSLog(@"storeUrl(%@) exists? %@", storeUrl, ([[NSFileManager defaultManager] fileExistsAtPath:storeUrl.path] ? @"YES" : @"NO"));
	
    return persistentStoreCoordinator;
}

- (void)fetchUniversitiesFromDBSortedByRank {
	if ([self.awardClasses count] <= 0) {
		NSEntityDescription *entity = [NSEntityDescription entityForName:[University entityName] inManagedObjectContext:[self managedObjectContext]]; 	
		
		for (NSString *awardName in [AwardClassHelper awardClassDBNames]) {
			// Setup the fetch request
			NSFetchRequest *request = [[NSFetchRequest alloc] init];
			[request setEntity:entity]; 
			
			// Sort by given rank
			NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:kDBFieldRank ascending:YES];
			NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
			[request setSortDescriptors:sortDescriptors];
			[sortDescriptor release]; 
			
			// Set predicate of university award class
			NSString *predicate = [NSString stringWithFormat:@"%@ == '%@'", kDBFieldAwardClass, awardName]; // Doesn't work if it is put straight into predicateWithFormat for some reason
			NSPredicate *rankPredicate = [NSPredicate predicateWithFormat:predicate];
			[request setPredicate:rankPredicate];	
			
			// Fetch the records and handle an error
			NSError *error;
			NSMutableArray *mutableFetchResults = [[[self managedObjectContext] executeFetchRequest:request error:&error] mutableCopy]; 
			//NSLog(@"mutableFetchResults: %@", mutableFetchResults);
			
			if (!mutableFetchResults) {
				// Handle the error.
				// This is a serious error and should advise the user to restart the application
				NSLog(@"mutableFetchResults error: %@", error);
			} 
			
			// Save our fetched data to an array
			[self.awardClasses addObject:mutableFetchResults];		
			
			[mutableFetchResults release];
			[request release];
		}
	}	
}

- (void)fetchUniversitiesFromDBSortedByName {
	
	if ([self.sortedUniversities count] <= 0) {
		// ------------------------------------------------
		// Get all universities
		// ------------------------------------------------
		NSEntityDescription *entity = [NSEntityDescription entityForName:[University entityName] inManagedObjectContext:[self managedObjectContext]]; 	
		
		// Setup the fetch request
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		[request setEntity:entity]; 
		
		// Sort by given rank
		NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:kDBFieldName ascending:YES];
		NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
		[request setSortDescriptors:sortDescriptors];
		[sortDescriptor release];	
		
		// Fetch the records and handle an error
		NSError *error;
		NSMutableArray *universities = [[[self managedObjectContext] executeFetchRequest:request error:&error] mutableCopy];
		
		if (!universities) {
			// Handle the error.
			// This is a serious error and should advise the user to restart the application
			NSLog(@"mutableFetchResults error: %@", error);
		}
		
		[request release];
		
		// ------------------------------------------------
		// Sort universities using collation
		// ------------------------------------------------
		
		// Get the current collation and keep a reference to it.
		self.collation = [UILocalizedIndexedCollation currentCollation];
		
		NSInteger alphabetTitlesCount = [[collation sectionTitles] count];	
		NSMutableArray *newUniArray = [[NSMutableArray alloc] initWithCapacity:alphabetTitlesCount];
		
		// Set up the sorted university array with empty arrays
		for (int i = 0; i < alphabetTitlesCount; i++) {
			NSMutableArray *array = [[NSMutableArray alloc] init];
			[newUniArray addObject:array];
			[array release];
		}
		
		for (University *uni in universities) {
			NSAutoreleasePool * pool = [NSAutoreleasePool new];
			
			// Ask the collation which section number the university belongs in, based on its sortName.
			NSInteger sectionNumber = [collation sectionForObject:uni collationStringSelector:@selector(sortName)];
			
			// Get the array for the section.
			NSMutableArray *alphabetSectionUniversities = [newUniArray objectAtIndex:sectionNumber];
			
			[alphabetSectionUniversities addObject:uni];
			
			[pool drain]; pool = nil;
		}
		
		// Sort universities using collation
		for (int i = 0; i < alphabetTitlesCount; i++) {
			
			NSMutableArray *alphabetSectionUniversities = [newUniArray objectAtIndex:i];
			
			// If the table view or its contents were editable, you would make a mutable copy here.
			NSArray *sortedUniversitiesForSection = [collation sortedArrayFromArray:alphabetSectionUniversities collationStringSelector:@selector(sortName)];
			
			// Replace the existing array with the sorted array.
			[newUniArray replaceObjectAtIndex:i withObject:sortedUniversitiesForSection];
		}
		
		self.sortedUniversities = newUniArray;
		[newUniArray release];		
		
	}
}

// Populate the database from csv files
- (void)loadGreenLeagueDataFromFileToDB {	            
    [self loadKeysFromFileToDB];
    
    [self loadDataFromFileToDB];
}


// Assume data to be first row header, and data after that
- (void)loadKeysFromFileToDB {
    // Load keys file    
	NSString *keyFilePath = [[NSBundle mainBundle] pathForResource:kScoreKeySourceFile ofType:@"csv"];
	NSString *keyFileContents = [NSString stringWithContentsOfFile:keyFilePath encoding:NSUTF8StringEncoding error:nil];
    
	// Get csv rows as an array while ignoring kDataCSVRowsToIgnore rows
	NSArray *csvRows = [keyFileContents csvRows];
	NSRange rowRangeExcludingIgnoredRows;
	rowRangeExcludingIgnoredRows.location = kDataCSVRowsToIgnore; 
	rowRangeExcludingIgnoredRows.length = [csvRows count] - kDataCSVRowsToIgnore;	
	csvRows = [csvRows subarrayWithRange:rowRangeExcludingIgnoredRows];
    
	// Parse CSV file
	for (NSArray *row in csvRows) {		
		[ScoreKey addScoreKeyToDBWithManagedContext:[self managedObjectContext] fromRowArray:row];
	}
}

// Assume data to be first row header, and data after that
- (void)loadDataFromFileToDB {    

    // Load data file    
	NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:kDataSourceFile ofType:@"csv"];
	NSString *dataFileContents = [NSString stringWithContentsOfFile:dataFilePath encoding:NSUTF8StringEncoding error:nil];
        	
	// Get csv rows as an array while ignoring kDataCSVRowsToIgnore rows
	NSArray *csvRows = [dataFileContents csvRows];
	NSRange rowRangeExcludingIgnoredRows;
	rowRangeExcludingIgnoredRows.location = kDataCSVRowsToIgnore; 
	rowRangeExcludingIgnoredRows.length = [csvRows count] - kDataCSVRowsToIgnore;	
	csvRows = [csvRows subarrayWithRange:rowRangeExcludingIgnoredRows];
	
    // Get header row
	NSArray *headerRowArray = [ScoreKey scoreKeyArrayFromKeyStringArray:[[dataFileContents csvRows] objectAtIndex:0] managedObjectContext:[self managedObjectContext]];
    
	// Parse CSV file
	for (NSArray *row in csvRows) {		
		[University addUniversityToDBWithManagedContext:[self managedObjectContext] fromRowArray:row headerRowArray:headerRowArray];
	}
}

#pragma mark -
#pragma mark === Database helpers ===
#pragma mark

- (NSMutableArray *)awardClasses {
	if (!awardClasses) {
		// Fetch the results from the database and sort by the value of the sort control
		awardClasses = [[NSMutableArray alloc] initWithCapacity:0];		
	}
	
	return awardClasses;
}

- (NSMutableArray *)sortedUniversities {
	if (!sortedUniversities) {
		sortedUniversities = [[NSMutableArray alloc] initWithCapacity:0];		
	}
	
	return sortedUniversities;
}

- (NSMutableArray *)questionScoreKeys {
    if (!questionScoreKeys) {
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:[ScoreKey entityName] inManagedObjectContext:[self managedObjectContext]];
        
        // Setup the fetch request
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entity]; 
        
        // Assuming it is sorted
        
        // Set predicate of university award class
        NSString *predicate = [NSString stringWithFormat:@"%@ ENDSWITH '%@'", kDBFieldScoreKey, kDBFieldQuestionSuffix];
        NSPredicate *questionPredicate = [NSPredicate predicateWithFormat:predicate];
        [request setPredicate:questionPredicate];
        
        // Fetch the records and handle an error
        NSError *error;
        questionScoreKeys = [[[self managedObjectContext] executeFetchRequest:request error:&error] mutableCopy];        
        
        if (!questionScoreKeys) {
            // Handle the error.
            // This is a serious error and should advise the user to restart the application
            NSLog(@"questionScoreKeys error: %@", error);
        } 
        
    }
    return questionScoreKeys;
}

- (Score *)findScoreForUniversity:(University *)uni scoreKey:(ScoreKey *)scoreKey {
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:[Score entityName] inManagedObjectContext:[self managedObjectContext]];
    
    // Setup the fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    // Set predicate of university award class
    NSString *predicate = [NSString stringWithFormat:@"(%@.name == '%@') AND (%@.key == '%@')", kDBFieldScoreUniversity, uni.name, kDBFieldScoreKey, scoreKey.key];
    NSPredicate *uniScorePredicate = [NSPredicate predicateWithFormat:predicate];
    [request setPredicate:uniScorePredicate];
    
    // Fetch the records and handle an error
    NSError *error;
    NSMutableArray *mutableFetchResults = [[[self managedObjectContext] executeFetchRequest:request error:&error] mutableCopy];        
    
    if (!mutableFetchResults) {
        // Handle the error.
        // This is a serious error and should advise the user to restart the application
        NSLog(@"uniScore error: %@", error);
    } 
    
    Score *uniScore = nil;
    if (mutableFetchResults.count == 1) {
        uniScore = [mutableFetchResults objectAtIndex:0]; // Only take first result
    } else {
        NSLog(@"Uni score for '%@', score key '%@' didn't return 1 result. Returned %d result/s", uni.name, scoreKey.key, mutableFetchResults.count);        
    }
    
    return uniScore;

}

- (Boolean)dbExists {
	NSFileManager *filemgr = [NSFileManager defaultManager];
	
	return [filemgr fileExistsAtPath:[self dbPath]];
}

// Set up the database, and get the data from a file if necessary
- (void)setupDB {
	// Check if there are any universities in the DB
	if (![self dbExists]) { // If none, load it from file
		[self loadGreenLeagueDataFromFileToDB];
	}
}


- (void)deleteDB {
	NSFileManager *filemgr = [NSFileManager defaultManager];
	
	if ([filemgr removeItemAtPath:[self dbPath] error: NULL]  == YES) {
        NSLog (@"Remove sqlite file successful");
	} else {
        NSLog (@"Remove sqlite file failed");
	}
}


#pragma mark -
#pragma mark === Application paths ===
#pragma mark

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (NSString *)dbPath {
	return [[self applicationDocumentsDirectory] stringByAppendingPathComponent:kDatabaseSqliteFile];
}


#pragma mark -
#pragma mark === Instance paths ===
#pragma mark

// Return an autoreleased university
- (University *)topRankedUniversity {
    University *uni = nil;
    if ([self.awardClasses count] > 0) {
        uni = [self.awardClasses objectAtIndex:0];
    }
    return [uni autorelease];
}




@end
