//
//  UniversityMoreDetailViewController.m
//  GreenLeague
//
//  Created by Tak Tran on 02/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UniversityMoreDetailViewController.h"
#import "ScoreKey.h"

// Global variables
#define kPolicySectionIndex 0
#define kPerformaceSectionIndex 1

// Indexes are inclusive
#define kPolicyStartIndex      0
#define kPolicyLastIndex       8
#define kPerformanceStartIndex 9 
#define kPerformanceLastIndex  12

// Data source keys
static NSString *kDataSourceTitleKey = @"title";
static NSString *kDataSourceScoreKey = @"score";
static NSString *kDataSourceTotalScoreKey = @"totalScore";

// Private
@interface UniversityMoreDetailViewController()

- (NSDictionary *)findDataForIndexPath:(NSIndexPath *)indexPath;

@end



@implementation UniversityMoreDetailViewController

@synthesize university, dataSourceArray, policyArray, performanceArray;

#pragma mark -
#pragma mark View lifecycle


- (id)initWithUniversity:(University *)uni universitiesModel:(UniversitiesModel *)unisModel {
    self = [super initWithNibName:@"UniversityMoreDetailViewController" bundle:nil];
    if (self) {
		university = uni;
		self.title = uni.sortName;
        
        // Structure:
        //		dataSourceArray
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
        NSArray *scoreKeys = unisModel.questionScoreKeys;
        
        NSMutableArray *policyTempArray = [[NSMutableArray alloc] init];
        NSMutableArray *performanceTempArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < scoreKeys.count; i++) {
            ScoreKey *scoreKey = [scoreKeys objectAtIndex:i];        
            Score *uniScore = [unisModel findScoreForUniversity:self.university scoreKey:scoreKey];
            
            NSDictionary *scoreData = [NSDictionary dictionaryWithObjectsAndKeys:
                                       scoreKey.text, kDataSourceTitleKey, 
                                       uniScore.value, kDataSourceScoreKey,
                                       scoreKey.maxScore, kDataSourceTotalScoreKey,                  
                                       nil];
            
            if ((i >= kPolicyStartIndex) && (i <= kPolicyLastIndex)) { // Policy scores
                [policyTempArray addObject:scoreData];            
            } else if ((i >= kPerformanceStartIndex) && (i <= kPerformanceLastIndex)) { // Performance scores
                [performanceTempArray addObject:scoreData];            
            } else {
                NSLog(@"Error: invalid score id '%d'", i);
            }
        }
        
        // Using NSArray class for instance variable, so that it can't be changed once created.
        self.policyArray = [NSArray arrayWithArray:policyTempArray];
        self.performanceArray = [NSArray arrayWithArray:performanceTempArray];    
        self.dataSourceArray = [NSArray arrayWithObjects:self.policyArray, self.performanceArray, nil];          
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    return self.dataSourceArray.count;
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
    // Find section array
    NSArray *sectionArray = [self.dataSourceArray objectAtIndex:section];
    
    return sectionArray.count;
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
		cell.textLabel.text = [NSString stringWithFormat:@"%@", [cellData valueForKey:kDataSourceTitleKey]];
		cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ / %@", [cellData valueForKey:kDataSourceScoreKey], [cellData valueForKey:kDataSourceTotalScoreKey]];
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
	
	NSArray *sectionDataDictionaries = [self.dataSourceArray objectAtIndex:[indexPath section]];
	
	if (sectionDataDictionaries) {
		if ([indexPath row] < sectionDataDictionaries.count) { // Check if valid index
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
	[dataSourceArray release];
	//[univerity release]; // TODO: Release?
    
	[policyArray release];
    [performanceArray release];
    
    [super dealloc];
}

@end

