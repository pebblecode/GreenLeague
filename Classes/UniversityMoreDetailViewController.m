//
//  UniversityMoreDetailViewController.m
//  GreenLeague
//
//  Created by Tak Tran on 02/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UniversityMoreDetailViewController.h"
#import "ScoreKey.h"
#import "ScoreClassHelper.h"
#import "MethodologyViewController.h"

// Global variables
#define kPolicySectionIndex 0
#define kPerformaceSectionIndex 1

// Indexes are inclusive
#define kPolicyStartIndex      0
#define kPolicyLastIndex       8
#define kPerformanceStartIndex 9 
#define kPerformanceLastIndex  12

#define kMaxTextLength         30 // The maximum text length before the short name is used

// Data source keys
static NSString *kDataSourceTitleKey = @"title";
static NSString *kDataSourceScoreKey = @"score";
static NSString *kDataSourceTotalScoreKey = @"totalScore";

// Private
@interface UniversityMoreDetailViewController()

- (void)storeDataSourceArray;
- (NSDictionary *)findDataForIndexPath:(NSIndexPath *)indexPath;
- (UIImage *)findRatingImageForIndexPath:(NSIndexPath *)indexPath;
- (ScoreKey *)findScoreKeyFromIndexPath:(NSIndexPath *)indexPath;

@end



@implementation UniversityMoreDetailViewController

@synthesize university, universitiesModel, dataSourceArray, policyArray, performanceArray, detailTableView;

#pragma mark -
#pragma mark View lifecycle


- (id)initWithUniversity:(University *)uni universitiesModel:(UniversitiesModel *)unisModel {
    self = [super initWithNibName:@"UniversityMoreDetailViewController" bundle:nil];
    if (self) {
		university = uni;
		self.title = uni.sortName;
        universitiesModel = unisModel;
        
        [self storeDataSourceArray];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailTableView.tableFooterView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"table-key-no-help.png"]];
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
        cell.imageView.image = [self findRatingImageForIndexPath:indexPath];
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

    MethodologyViewController *methodologyViewController = [[MethodologyViewController alloc] initWithScoreKey:[self findScoreKeyFromIndexPath:indexPath]];

    [self.navigationController pushViewController:methodologyViewController animated:YES];
    [methodologyViewController release];
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

// Reverses how storeDataSourceArrayWithUniversitiesModel stores the scores
- (UIImage *)findRatingImageForIndexPath:(NSIndexPath *)indexPath {
    
    ScoreKey *scoreKey = [self findScoreKeyFromIndexPath:indexPath];
    
    return [ScoreClassHelper imageFromUniScoreKey:scoreKey university:self.university universitiesModel:self.universitiesModel];

}

- (ScoreKey *)findScoreKeyFromIndexPath:(NSIndexPath *)indexPath {
    // Calculate the score key index by looking at what array it is, and adding the sum of all the previous array counts
    
    NSArray *scoreKeys = self.universitiesModel.questionScoreKeys;
    ScoreKey *scoreKey = nil;
    // Hard coding section handling - will need to generalise if there are more than 2 sections
    if ([indexPath section] == kPolicySectionIndex) {
        
        scoreKey = [scoreKeys objectAtIndex:[indexPath row]];
    } else if ([indexPath section] == kPerformaceSectionIndex) {        
        
        NSArray *policyDictionariesArray = [self.dataSourceArray objectAtIndex:kPolicySectionIndex];
        int performanceScoreIndex = ([indexPath section] * policyDictionariesArray.count) + [indexPath row];
        scoreKey = [scoreKeys objectAtIndex:performanceScoreIndex];   
        
    } else {
        NSLog(@"Error in finding: %@", indexPath);
    }
    
    return scoreKey;
}
     
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
- (void)storeDataSourceArray {

    NSArray *scoreKeys = self.universitiesModel.questionScoreKeys;

    NSMutableArray *policyTempArray = [[NSMutableArray alloc] init];
    NSMutableArray *performanceTempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < scoreKeys.count; i++) {
        ScoreKey *scoreKey = [scoreKeys objectAtIndex:i];        
        Score *uniScore = [self.universitiesModel findScoreForUniversity:self.university scoreKey:scoreKey];
        
        // Use short name if score text is too long and short name exists, otherwise use score text        
        NSString *title = nil;
        if ((scoreKey.text.length > kMaxTextLength) &&
                (scoreKey.shortName.length > 0)) {
            title = scoreKey.shortName;
        } else {
            title = scoreKey.text;
        }
        
        NSDictionary *scoreData = [NSDictionary dictionaryWithObjectsAndKeys:
                                   title, kDataSourceTitleKey, 
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
    //[universitiesModel release]; // TODO: Release?
    
	[policyArray release];
    [performanceArray release];
    
    [detailTableView release];
    [super dealloc];
}

@end

