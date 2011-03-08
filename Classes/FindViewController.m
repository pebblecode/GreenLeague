//
//  FindViewController.m
//  GreenLeague
//
//  Created by Tak Tran on 23/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FindViewController.h"
#import "UniversityDetailViewController.h"
#import "University.h"
#import "AwardClassHelper.h"


#define kInvalidSortByControlIndex -100
#define kSortByRankControlIndex 0
#define kSortByNameControlIndex 1

// Sort control
#define kSortControlWidth 90.0
#define kSortControlHeight 30.0

// Private methods
@interface FindViewController()

- (void)sortControlValueChange;
- (Boolean)isRankSort;
- (Boolean)isNameSort;

@end



@implementation FindViewController

@synthesize sortControl, universitiesModel;

#pragma mark -
#pragma mark View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {			
		self.title = @"Find Universities";
		self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Find" image:[UIImage imageNamed:@"06-magnify.png"] tag:1];	
	}
	return self;
}

- (id)initWithUniversitiesModel:(UniversitiesModel *)unisModel {	
	if ((self = [self initWithNibName:@"FindViewController" bundle:nil])) {
		universitiesModel = [unisModel retain];
	}
	return self;	
}

// TODO: viewDidLoad gets called twice for some reason
- (void)viewDidLoad {
    [super viewDidLoad];	
	
	universitySortIndex = kInvalidSortByControlIndex; // Set to invalid, so that results are fetched the first time
	
	// Create sort control
	sortControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Rank", @"A-Z", nil]];
	sortControl.frame = CGRectMake(0, 0, kSortControlWidth, kSortControlHeight);
	sortControl.selectedSegmentIndex = kSortByRankControlIndex; // Select rank by default
	sortControl.segmentedControlStyle = UISegmentedControlStyleBar;
	[sortControl addTarget:self action:@selector(sortControlValueChange) forControlEvents:UIControlEventValueChanged];
	
	// Add sort control to nav bar
	UIBarButtonItem *segmentBarItem = [[UIBarButtonItem alloc] initWithCustomView:sortControl];    
	self.navigationItem.rightBarButtonItem = segmentBarItem;
	[segmentBarItem release];

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
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
	NSLog(@"didReceiveMemoryWarning");
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {	
	[sortControl release];
	[universitiesModel release];
	
    [super dealloc];
}


#pragma mark -
#pragma mark === Table view data source ===
#pragma mark

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    int sections;
	
	if ([self isRankSort]) {
		sections = [self.universitiesModel.awardClasses count];
	} else if ([self isNameSort]) {
		sections = [[self.universitiesModel.collation sectionTitles] count];
	}	

    return sections;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// The number of time zones in the section is the count of the array associated with the section in the sections array.
    int sections;
	
	if ([self isRankSort]) {
		sections = [[self.universitiesModel.awardClasses objectAtIndex:section] count];
	} else if ([self isNameSort]) {
		sections = [[self.universitiesModel.sortedUniversities objectAtIndex:section] count];		
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
    
	University *uni = [self universityFromIndexPath:indexPath];
	
	// Text: Rank. University
	NSString *rankString = ([[uni rank2010] intValue] == 0) ? @"(none) " : [NSString stringWithFormat:@"%@. ", uni.rank2010];
	cell.textLabel.text = [NSString stringWithFormat:@"%@%@", rankString, uni.sortName];	
	// Detailed text: Scored: Score
	cell.detailTextLabel.text = [NSString stringWithFormat:@"Scored: %.1f", [uni.totalScore floatValue]];		
		
	
    return cell;
}

// Note that colour must be changed in this method rather than tableView:cellForRowAtIndexPath:
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	University *uni = [self universityFromIndexPath:indexPath];
		
	cell.textLabel.textColor = [uni awardClassTextColour];
	cell.backgroundColor = [uni awardClassBackgroundColour];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {	
	NSString *headerTitle;
	
	if ([self isRankSort]) {
		headerTitle = [[AwardClassHelper awardClassNames] objectAtIndex:section];
	} else if ([self isNameSort]) {
		headerTitle = [[self.universitiesModel.collation sectionTitles] objectAtIndex:section];
	}
    return headerTitle;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
	NSArray *indexTitles;
	if ([self isRankSort]) {
		indexTitles = [AwardClassHelper awardClassIndexTitles];
	} else if ([self isNameSort]) {
		indexTitles = [self.universitiesModel.collation sectionIndexTitles];
	}
    
	return indexTitles;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
	NSInteger section;
	if ([self isRankSort]) {
		section = index; // Same as index
	} else if ([self isNameSort]) {
		section = [self.universitiesModel.collation sectionForSectionIndexTitleAtIndex:index];
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
	
	University *uni = [self universityFromIndexPath:indexPath];

	if ([uni isValidAwardClass]) {
		UniversityDetailViewController *uniDetailVC = [[UniversityDetailViewController alloc] initWithUniversity:uni];
		[self.navigationController pushViewController:uniDetailVC animated:YES];
		[uniDetailVC release];
	} else {
		NSLog(@"Could not find award class for '%@' of award class '%@'", [uni name], [uni awardClass]);
	}
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
}

#pragma mark -
#pragma mark === Table view helpers ===
#pragma mark 

- (University *)universityFromIndexPath:(NSIndexPath *)indexPath {
	University *uni;
	
	if ([self isRankSort]) {		
		NSArray *universitiesInAwardClass = [self.universitiesModel.awardClasses objectAtIndex:indexPath.section];	
		uni = [universitiesInAwardClass objectAtIndex:indexPath.row];
	} else if ([self isNameSort]) {		
		NSArray *alphabetSectionUniversities = [self.universitiesModel.sortedUniversities objectAtIndex:indexPath.section];	
		uni = [alphabetSectionUniversities objectAtIndex:indexPath.row];		
	}
	
	return uni;
}


#pragma mark -
#pragma mark === Sort control helper methods ===
#pragma mark

- (void)sortControlValueChange {	
	// Table methods should handle all sort changes - just need to reload the data to run all the table methods again
	
	// Reload data and scroll to the top
	[self.tableView reloadData];	
	[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];	
}

- (Boolean)isRankSort {
	return (self.sortControl.selectedSegmentIndex == kSortByRankControlIndex);
}

- (Boolean)isNameSort {
	return (self.sortControl.selectedSegmentIndex == kSortByNameControlIndex);
}


@end

