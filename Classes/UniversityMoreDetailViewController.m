//
//  UniversityMoreDetailViewController.m
//  GreenLeague
//
//  Created by Tak Tran on 02/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UniversityMoreDetailViewController.h"

// Global variables
#define kPolicySectionIndex 0
#define kPerformaceSectionIndex 1

#define kNumberSections 2
#define kNumberRowsForPolicy 7
#define kNumberRowsForPerformance 4

// Data source keys
static NSString *kDataSourceTitleKey = @"title";
static NSString *kDataSourceScoreKey = @"score";
static NSString *kDataSourceTotalScoreKey = @"totalScore";

@interface UniversityMoreDetailViewController()

University *university;

@property (nonatomic, retain) University *university;

- (NSDictionary *)findDataForIndexPath:(NSIndexPath *)indexPath;

@end



@implementation UniversityMoreDetailViewController

@synthesize university, dataSoruceArray;

#pragma mark -
#pragma mark View lifecycle


- (id)initWithUniversity:(University *)uni {
    self = [super initWithNibName:@"UniversityMoreDetailViewController" bundle:nil];
    if (self) {
		university = uni;
		self.title = uni.sortName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Structure:
	//		dataSoruceArray
	//			- [0] Policy
	//				- [0] Dictionary
	//					- [title] "1. Publicly Available Environmental Policy"
	//					- [uniScore] 4
	//					- [scoreTotal] 6
	//				- [1] Dictionary
	//				- ...
	//			- [1] Performance
	//				- [0] Dictionary
	//					- [title] "8. Energy sources"
	//					- ...
	//				- ...	
	self.dataSoruceArray = [NSArray arrayWithObjects:
								// Policy
								[NSArray arrayWithObjects:
									 [NSDictionary dictionaryWithObjectsAndKeys:
										@"1. Publicly Available Environmental Policy", kDataSourceTitleKey,
										self.university.policy1Score, kDataSourceScoreKey,
										[NSNumber numberWithInt:6], kDataSourceTotalScoreKey,
									  nil],
									 [NSDictionary dictionaryWithObjectsAndKeys:
										  @"2. Staff", kDataSourceTitleKey,
										  self.university.policy2Score, kDataSourceScoreKey,
										  [NSNumber numberWithInt:8], kDataSourceTotalScoreKey,
									  nil],
									 [NSDictionary dictionaryWithObjectsAndKeys:
										  @"3. Comprehensive Environmental Auditing", kDataSourceTitleKey,
										  self.university.policy3Score, kDataSourceScoreKey,
										  [NSNumber numberWithInt:8], kDataSourceTotalScoreKey,
									  nil],
									 [NSDictionary dictionaryWithObjectsAndKeys:
										  @"4. Ethical Investment Policy", kDataSourceTitleKey,
										  self.university.policy4Score, kDataSourceScoreKey,
										  [NSNumber numberWithInt:4], kDataSourceTotalScoreKey,
									  nil],
									 [NSDictionary dictionaryWithObjectsAndKeys:
										  @"5. Carbon Management", kDataSourceTitleKey,
										  self.university.policy5Score, kDataSourceScoreKey,
										  [NSNumber numberWithInt:8], kDataSourceTotalScoreKey,
									  nil],
									 [NSDictionary dictionaryWithObjectsAndKeys:
										  @"6. Sustainable Procurement and Fairtrade accreditation", kDataSourceTitleKey,
										  self.university.policy6Score, kDataSourceScoreKey,
										  [NSNumber numberWithInt:3], kDataSourceTotalScoreKey,
									  nil],
									 [NSDictionary dictionaryWithObjectsAndKeys:
										  @"7. Student and Staff Engagement", kDataSourceTitleKey,
										  self.university.policy7Score, kDataSourceScoreKey,
										  [NSNumber numberWithInt:3], kDataSourceTotalScoreKey,
									  nil],								 
								 nil],
							 
								// Performance
								[NSArray arrayWithObjects:
									 [NSDictionary dictionaryWithObjectsAndKeys:
									  @"8. Energy sources", kDataSourceTitleKey,
									  self.university.performance8Score, kDataSourceScoreKey,
									  [NSNumber numberWithInt:6], kDataSourceTotalScoreKey,
									  nil],
									 [NSDictionary dictionaryWithObjectsAndKeys:
									  @"9. Waste", kDataSourceTitleKey,
									  self.university.performance9Score, kDataSourceScoreKey,
									  [NSNumber numberWithInt:8], kDataSourceTotalScoreKey,
									  nil],
									 [NSDictionary dictionaryWithObjectsAndKeys:
									  @"10. Carbon emissions per head", kDataSourceTitleKey,
									  self.university.performance10Score, kDataSourceScoreKey,
									  [NSNumber numberWithInt:8], kDataSourceTotalScoreKey,
									  nil],
									 [NSDictionary dictionaryWithObjectsAndKeys:								 
									  @"11. Water consumption per head", kDataSourceTitleKey,
									  self.university.performance10Score, kDataSourceScoreKey,
									  [NSNumber numberWithInt:8], kDataSourceTotalScoreKey,
									  nil],
								 nil],							 
							 nil];
								
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
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return kNumberSections;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSString *sectionTitle;
	
	if (section == kPolicySectionIndex) {
		sectionTitle = @"Policy";
	} else if (section == kPerformaceSectionIndex) {
		sectionTitle = @"Performance";
	}
	
	return sectionTitle;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int numRows = 0;
	
	if (section == kPolicySectionIndex) {
		numRows = kNumberRowsForPolicy;
	} else if (section == kPerformaceSectionIndex) {
		numRows = kNumberRowsForPerformance;
	}
    return numRows;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	NSDictionary *cellData = [self findDataForIndexPath:indexPath];
	if (cellData) {
		cell.textLabel.text = [NSString stringWithFormat:@"%@ [%@]", [cellData valueForKey:kDataSourceTitleKey], [cellData valueForKey:kDataSourceScoreKey]];
		cell.detailTextLabel.text = [NSString stringWithFormat:@"Out of %@", [cellData valueForKey:kDataSourceTotalScoreKey]];
	}
	
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
#pragma mark === Helper methods ===
#pragma mark

- (NSDictionary *)findDataForIndexPath:(NSIndexPath *)indexPath {
	NSDictionary *dataDictionary = nil;
	
	NSArray *sectionDataDictionaries = [self.dataSoruceArray objectAtIndex:[indexPath section]];
	
	if (sectionDataDictionaries) {
		if ([indexPath row] < [sectionDataDictionaries count]) { // Check if valid index
			dataDictionary = [sectionDataDictionaries objectAtIndex:[indexPath row]];
		}		
	}	
	
	return dataDictionary;
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
	[dataSoruceArray release];
	//[univerity release]; // TODO: Release?
	 	 
    [super dealloc];
}

@end

