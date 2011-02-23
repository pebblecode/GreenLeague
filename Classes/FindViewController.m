//
//  FindViewController.m
//  GreenLeague
//
//  Created by Tak Tran on 23/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FindViewController.h"

#define kNumberOfSections 6
// Data source file minus the file extension
#define kDataSourceFile "gl2010"
#define kStartIndexForData 3
#define kDatabaseSqliteFile "green_league.sqlite"

// Index for the fields in the data source file
#define kDataFieldIndexRank 0
#define kDataFieldIndexUniversity 1
#define kDataFieldIndexScore 2
#define kDataFieldIndexAward 3

// Data source field dictionary keys

#define kDataFieldKeyRank "rank"
#define kDataFieldKeyUniversity "university"
#define kDataFieldKeyScore "score"
#define kDataFieldKeyAward "award"

// Private methods
@interface FindViewController()

- (void)populateDatabaseFromFile;

@end



@implementation FindViewController

@synthesize greenLeagueUniversityData, managedObjectContext, managedObjectModel, persistentStoreCoordinator;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    [self populateDatabaseFromFile];
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
    // Return the number of sections.
    return kNumberOfSections;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 5;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    return cell;
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
	[greenLeagueUniversityData release];
	
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
    NSURL *storeUrl = [NSURL fileURLWithPath:[[self applicationDocumentsDirectory] stringByAppendingPathComponent:@kDatabaseSqliteFile]];
	
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

// Populate the database from kDataSourceFile csv file
- (void)populateDatabaseFromFile {	
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@kDataSourceFile ofType:@"csv"];
	NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
	
	NSLog(@"kDataSourceFile: %@", @kDataSourceFile);
	NSLog(@"fileContents: %@", fileContents);
	// Parse CSV file
	if (fileContents) {
		NSArray *lines = [fileContents componentsSeparatedByString:@"\n"];
		NSLog(@"lines: %@", lines);		
		NSMutableDictionary *glDataItem = [[NSMutableDictionary alloc] initWithCapacity:0];		
		for (int i = kStartIndexForData; i < lines.count; i++) {
			NSArray *dataItem = [[lines objectAtIndex:i] componentsSeparatedByString:@","];
			
			if ([dataItem count] > kDataFieldIndexRank) {
				[glDataItem setObject:[dataItem objectAtIndex:kDataFieldIndexRank] forKey:@kDataFieldKeyRank];
			}
			if ([dataItem count] > kDataFieldIndexUniversity) {
				[glDataItem setObject:[dataItem objectAtIndex:kDataFieldIndexUniversity] forKey:@kDataFieldKeyUniversity];
			}	
			if ([dataItem count] > kDataFieldIndexScore) {
				[glDataItem setObject:[dataItem objectAtIndex:kDataFieldIndexScore] forKey:@kDataFieldKeyScore];
			}
			if ([dataItem count] > kDataFieldIndexAward) {
				[glDataItem setObject:[dataItem objectAtIndex:kDataFieldIndexAward] forKey:@kDataFieldKeyAward];
			}
		}
		[greenLeagueUniversityData addObject:glDataItem];
		[glDataItem release];
	}
	NSLog(@"%@", greenLeagueUniversityData);
}


#pragma mark -
#pragma mark === Application's Documents directory ===
#pragma mark

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}



@end

