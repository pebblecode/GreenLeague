//
//  FindViewController.m
//  GreenLeague
//
//  Created by Tak Tran on 23/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FindViewController.h"
#import "University.h"

// Data source file minus the file extension
#define kDataSourceFile "gl2010"
#define kStartIndexForData 4
#define kDatabaseSqliteFile "green_league.sqlite"

#define kInvalidSortByControlIndex -100
#define kSortByRankControlIndex 0
#define kSortByNameControlIndex 1

// Data source field dictionary keys

#define kDataFieldNameRank "rank2010"
#define kDataFieldNameUniversity "university"
#define kDataFieldNameScore "score"
#define kDataFieldNameAward "awardClass"

// Private methods
@interface FindViewController()

@property (nonatomic, retain) UILocalizedIndexedCollation *collation;

- (void)deleteDB;

//- (void)fetchRankedUniversitiesFromDBSortBy:(NSString *)sortField;
//- (void)configureAwardClasses;

- (void)fetchUniversitiesBySortControl;
- (void)fetchRankedUniversitiesFromDB;

- (void)loadGreenLeagueDataFromFileToDB;
- (NSString *)dbPath;
- (Boolean)dbExists;
- (void)setupDB;
- (Boolean)isRankSort;
- (Boolean)isNameSort;

@end



@implementation FindViewController

@synthesize awardClasses, awardClassNames, awardClassDBNames, collation, managedObjectContext, managedObjectModel, persistentStoreCoordinator, sortControl;

#pragma mark -
#pragma mark View lifecycle


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {			
		//self.title = @"Green League Universities";
		self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Find" image:[UIImage imageNamed:@"06-magnify.png"] tag:1];	
	}
	return self;
}

// TODO: viewDidLoad gets called twice for some reason
- (void)viewDidLoad {
    [super viewDidLoad];
	
	universitySortIndex = kInvalidSortByControlIndex; // Set to invalid, so that results are fetched the first time
	sortControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Rank", @"A-Z", nil]];
	sortControl.frame = CGRectMake(76, 4, 150, 34);
	sortControl.selectedSegmentIndex = kSortByRankControlIndex; // Select rank by default
	[sortControl addTarget:self action:@selector(fetchUniversitiesBySortControl) forControlEvents:UIControlEventValueChanged];
	[self.navigationController.navigationBar addSubview:sortControl];	
	
	// Fetch the results from the database and sort by the value of the sort control
	self.awardClasses = [[NSMutableArray alloc] initWithCapacity:0];
	
	self.awardClassDBNames = [NSArray arrayWithObjects:@"1st", @"2:1", @"2:2", @"3rd", @"Fail", @"Did not sit exam", nil];
	self.awardClassNames = [NSArray arrayWithObjects:@"1st", @"Upper 2nd", @"Lower 2nd", @"3rd", @"Failed", @"No award", nil];
	
	//universities = [[NSMutableArray alloc] initWithCapacity:0];
	
	// To remove the db all the time (for debugging only)
	//[self deleteDB];		
	
	// Set up the database, and get the data from the file if necessary		
	[self setupDB];
	
	[self fetchUniversitiesBySortControl];	
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

- (Boolean)isRankSort {
	return (self.sortControl.selectedSegmentIndex == kSortByRankControlIndex);
}

- (Boolean)isNameSort {
	return (self.sortControl.selectedSegmentIndex == kSortByNameControlIndex);
}

// Fetch the results from the database and sort by the value of the sort control
- (void)fetchUniversitiesBySortControl {
	
	// Only fetch new sort if value has changed
	if (self.sortControl.selectedSegmentIndex != universitySortIndex) {	
		if ([self isRankSort]) {
			[self fetchRankedUniversitiesFromDB];
		} else if ([self isNameSort]) {
			NSLog(@"Name sort");
		}
	}
	universitySortIndex = self.sortControl.selectedSegmentIndex;
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark === Table view data source ===
#pragma mark

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    int sections;
	
	if ([self isRankSort]) {
		sections = [self.awardClasses count];
	} else if ([self isNameSort]) {
		sections = [[collation sectionTitles] count];
	}	

    return sections;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// The number of time zones in the section is the count of the array associated with the section in the sections array.
    int sections;
	
	if ([self isRankSort]) {
		sections = [[awardClasses objectAtIndex:section] count];
	} else if ([self isNameSort]) {
		sections = [[collation sectionTitles] count]; // TODO: WRONG???
	}		
	
    return sections;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	if ([self isRankSort]) {
//		int glDataIndex = [indexPath indexAtPosition:[indexPath length] - 1];
//		if (glDataIndex < [self.universities count]) {
//			University *uni = [self.universities objectAtIndex:glDataIndex];
//			// Text: Rank. University
//			NSString *rankString = ([[uni rank2010] intValue] == 0) ? @"(none) " : [NSString stringWithFormat:@"%@. ", uni.rank2010];
//			cell.textLabel.text = [NSString stringWithFormat:@"%@%@", rankString, uni.name];	
//			// Detailed text: Scored: Score
//			cell.detailTextLabel.text = [NSString stringWithFormat:@"Scored: %@", uni.totalScore];
//		}
		
		NSArray *universitiesInAwardClass = [awardClasses objectAtIndex:indexPath.section];	
		University *uni = [universitiesInAwardClass objectAtIndex:indexPath.row];
		
		// Text: Rank. University
		NSString *rankString = ([[uni rank2010] intValue] == 0) ? @"(none) " : [NSString stringWithFormat:@"%@. ", uni.rank2010];
		cell.textLabel.text = [NSString stringWithFormat:@"%@%@", rankString, uni.sortName];	
		// Detailed text: Scored: Score
		cell.detailTextLabel.text = [NSString stringWithFormat:@"Scored: %@", uni.totalScore];		
		
	} else if ([self isNameSort]) {		
		NSArray *universitiesInAwardClass = [awardClasses objectAtIndex:indexPath.section];	
		University *uni = [universitiesInAwardClass objectAtIndex:indexPath.row];
		
		// Text: Rank. University
		NSString *rankString = ([[uni rank2010] intValue] == 0) ? @"(none) " : [NSString stringWithFormat:@"%@. ", uni.rank2010];
		cell.textLabel.text = [NSString stringWithFormat:@"%@%@", rankString, uni.sortName];	
		// Detailed text: Scored: Score
		cell.detailTextLabel.text = [NSString stringWithFormat:@"Scored: %@", uni.totalScore];
	}
	
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {	
	NSString *headerTitle;
	
	if ([self isRankSort]) {
		headerTitle = [self.awardClassNames objectAtIndex:section];
	} else if ([self isNameSort]) {
		headerTitle = [[collation sectionTitles] objectAtIndex:section];
	}
    return headerTitle;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
	NSArray *indexTitles;
	if ([self isRankSort]) {
		indexTitles = self.awardClassNames;
	} else if ([self isNameSort]) {
		indexTitles = [collation sectionIndexTitles];
	}
    
	return indexTitles;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
	NSInteger section;
	if ([self isRankSort]) {
		section = index; // Same as index
	} else if ([self isNameSort]) {
		section = [collation sectionForSectionIndexTitleAtIndex:index];
	}    
	return section;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
	
	//NSLog(@"selected row (%@): %@", indexPath, self.universities);
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	//[universities release];
	[awardClasses release];
	[awardClassNames release];
	[awardClassDBNames release];
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
	
	NSLog(@"storeUrl(%@) exists = %@", storeUrl, ([[NSFileManager defaultManager] fileExistsAtPath:storeUrl.path] ? @"YES" : @"NO"));
    
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

- (void)deleteDB {
	NSFileManager *filemgr = [NSFileManager defaultManager];
	
	if ([filemgr removeItemAtPath:[self dbPath] error: NULL]  == YES) {
        NSLog (@"Remove sqlite file successful");
	} else {
        NSLog (@"Remove sqlite file failed");
	}
}

//- (void)fetchRankedUniversitiesSortBy:(NSString *)sortField {
//
//	[self fetchRankedUniversitiesFromDBSortBy:sortField];
//	
//	if (self.universities.count <= 0) {
//		NSLog(@"No green league data");
//		[self loadGreenLeagueDataFromFileToDB];
//		[self fetchRankedUniversitiesFromDBSortBy:sortField];
//	}
//	//NSLog(@"Loaded: %@", universities);
//	
//	if (self.sortControl.selectedSegmentIndex == kSortByAlphabetIndex) {
//		[self configureAwardClasses];
//	}
//	
//}
//
//- (void)setUniversities:(NSMutableArray *)newDataArray {
//	if (newDataArray != universities) {
//		[universities release];
//		universities = [newDataArray retain];
//	}
//	if (universities == nil) {
//		self.awardClasses = nil;
//	} else {
//		//[self configureAwardClasses];
//	}
//}
//			
//- (void)configureAwardClasses {
//	// Get the current collation and keep a reference to it.
//	self.collation = [UILocalizedIndexedCollation currentCollation];
//	
//	NSInteger awardTitlesCount = [[collation sectionTitles] count];
//	
//	NSMutableArray *newAwardsArray = [[NSMutableArray alloc] initWithCapacity:awardTitlesCount];
//	
//	// Set up the awards array with empty arrays
//	for (int i = 0; i < awardTitlesCount; i++) {
//		NSMutableArray *array = [[NSMutableArray alloc] init];
//		[newAwardsArray addObject:array];
//		[array release];
//	}
//	
//	for (University *uni in universities) {
//		// Ask the collation which section number the time zone belongs in, based on its locale name.
//		NSInteger sectionNumber = [collation sectionForObject:uni collationStringSelector:@selector(sortName)];
//		
//		// Get the array for the section.
//		NSMutableArray *awardUniversities = [newAwardsArray objectAtIndex:sectionNumber];
//		
//		//  Add the time zone to the section.
//		[awardUniversities addObject:uni];		
//	}
//	
//	// Sort array?
//	
//	self.awardClasses = newAwardsArray;
//	[newAwardsArray release];		
//		
//}			
//

- (void)fetchRankedUniversitiesFromDB {
	NSEntityDescription *entity = [NSEntityDescription entityForName:[University entityName] inManagedObjectContext:[self managedObjectContext]]; 	
	
	for (NSString *awardName in self.awardClassDBNames) {
		// Setup the fetch request
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		[request setEntity:entity]; 
		
		// Sort by given rank
		NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@kDataFieldNameRank ascending:YES];
		NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
		[request setSortDescriptors:sortDescriptors];
		[sortDescriptor release]; 
		
		// Set predicate of university award class
		NSString *predicate = [NSString stringWithFormat:@"%@ == '%@'", @kDataFieldNameAward, awardName]; // Doesn't work if it is put straight into predicateWithFormat for some reason
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
		//[self setUniversities:mutableFetchResults];
		[self.awardClasses addObject:mutableFetchResults];		
		
		[mutableFetchResults release];
		[request release];
	}
	
}


// Populate the database from kDataSourceFile csv file
- (void)loadGreenLeagueDataFromFileToDB {	
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@kDataSourceFile ofType:@"csv"];
	NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
	
	// Parse CSV file
	if (fileContents) {
		NSArray *lines = [fileContents componentsSeparatedByString:@"\n"];
		
		// Not sure why it's lines.count - 1
		for (int i = kStartIndexForData; i < (lines.count - 1); i++) {
			[University addUniversityFromCSVLine:[lines objectAtIndex:i] toDBWithManagedContext:[self managedObjectContext]];
		}
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
	return [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@kDatabaseSqliteFile];
}


@end

