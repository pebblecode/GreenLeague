//
//  CompareViewController.m
//  GreenLeague
//
//  Created by Tak on 24/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CompareViewController.h"
#import "University.h"
#import "FindSelectorViewController.h"
#import "UniversityComparisonViewController.h"

@interface CompareViewController()

- (void)refreshScrollView;

@end

@implementation CompareViewController

@dynamic universitiesToCompare;
@synthesize universitiesModel, helpView, scrollView, universityViewControllers;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if ((self = [super initWithNibName:@"CompareViewController" bundle:nibBundleOrNil])) {
        self.title = @"Universities";
		self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Compare" image:[UIImage imageNamed:@"12-eye.png"] tag:1];
	}
	return self;
} 

- (id)initWithUniversitiesModel:(UniversitiesModel *)unisModel {
	if ((self = [self initWithNibName:@"CompareViewController" bundle:nil])) {
		universitiesModel = [unisModel retain];                
        
        if ([self.universitiesToCompare count] <= 0) {            
//            // Add top ranked uni
//            University *uni = [universitiesModel topRankedUniversity];          
//            if (uni) {
//                [self setUniversitiesToCompare:[NSMutableSet setWithObject:uni]];                
//            }   
            [self setUniversitiesToCompare:[NSMutableArray array]];
        }
	}
	return self;	
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];	
    
	// Add button to the bottom of the table
//	UIView *compareTableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
//    {
//        UIButton *compareButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        compareButton.frame = CGRectMake(80, 10, 200, 40);
//        [compareButton setTitle:@"Compare" forState:UIControlStateNormal];
//        [compareButton addTarget:self action:@selector(compareButtonPress) forControlEvents:UIControlEventTouchUpInside];	
//        [compareTableFooterView addSubview:compareButton];		
//	}
//    {
//        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
//        addButton.frame = CGRectMake(30, 10, 40, 40);
//        [addButton setTitle:@"Add University" forState:UIControlStateNormal];
//        [addButton addTarget:self action:@selector(addButtonPress) forControlEvents:UIControlEventTouchUpInside];	
//        [compareTableFooterView addSubview:addButton];		
//	}
//    
//	self.tableView.tableFooterView = compareTableFooterView;
//    
//	[compareTableFooterView release];    
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPress)];
    self.navigationItem.leftBarButtonItem = addButton;    
    
    UIBarButtonItem *compareButton = [[UIBarButtonItem alloc] initWithTitle:@"Compare" style:UIBarButtonItemStylePlain target:self action:@selector(compareButtonPress)];
	self.navigationItem.rightBarButtonItem = compareButton;
    
	// Set editing mode
	//[self.tableView setEditing:YES animated:NO];
    
    // Handle universities selected on modal form
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setUniversitiesToCompareWithNotification:) name:@"selectedUniversitiesSet" object:nil];
    
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [universityViewControllers release];
	[universitiesToCompare release];
	[universitiesModel release];
	[helpView release];
    [scrollView release];
    
    [super dealloc];
}

#pragma mark -
#pragma mark === Getters/Setters ===
#pragma mark

- (NSMutableArray *)universitiesToCompare {
    return universitiesToCompare;
}

- (void)setUniversitiesToCompare:(NSMutableArray *)unisToCompare {
    if (universitiesToCompare != unisToCompare) {
        [universitiesToCompare release];
        universitiesToCompare = [unisToCompare retain]; // Keep a retain of the new set
        
        // Sort universities by rank
        NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"rank2010" ascending:YES];
        [universitiesToCompare sortUsingDescriptors:[NSArray arrayWithObject:descriptor]];
        [descriptor release];
        
        // Reload table
        //[self.tableView reloadData];
        
        [self refreshScrollView];
    }
}

- (void)setUniversitiesToCompareWithNotification:(NSNotification *)notification {    
    [self setUniversitiesToCompare:[NSMutableArray arrayWithArray:[notification.object allObjects]]];
}

- (NSMutableArray *)universityViewControllers {    
    if (!universityViewControllers) {
        universityViewControllers = [[NSMutableArray alloc] init];
    }
    return universityViewControllers;
}

#pragma mark -
#pragma mark === Scroll view ===
#pragma mark

- (void)refreshScrollView {
    // Clear scroll view
    for (UIView *scrollSubview in self.scrollView.subviews) {        
        [scrollSubview removeFromSuperview];
    }
    [universityViewControllers release]; universityViewControllers = nil;    
    
    // Figure out how big the scroll content size should be
    CGFloat scrollHeight = [UniversityComparisonViewController height] * [self.universitiesToCompare count];
    
    // Set the content size of the scroll view
    [self.scrollView setContentSize:CGSizeMake([UniversityComparisonViewController width], scrollHeight)];
    
    // Loop through universities to compare and create a UniversityComparisonView for each
    for (int i = 0; i < [self.universitiesToCompare count]; i++) {
        University *uni = [self.universitiesToCompare objectAtIndex:i];
        
        UniversityComparisonViewController *uniComparisonVC = [[UniversityComparisonViewController alloc] initWithUniversity:uni];
        [self.universityViewControllers addObject:uniComparisonVC];
        [uniComparisonVC release];
        
        // Set layout
        uniComparisonVC.view.frame = CGRectMake(0, i * uniComparisonVC.view.frame.size.height, uniComparisonVC.view.frame.size.width, uniComparisonVC.view.frame.size.height);
        
        // Add to scroll view
        [self.scrollView addSubview:uniComparisonVC.view];
        
    }
}

//#pragma mark -
//#pragma mark Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
////- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
////	return @"Universities:";
////}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//    NSInteger numRows = [self.universitiesToCompare count];
//    //NSLog(@"unis to compare: %d", numRows);    
//    
//    if (numRows <= 0) { // No universities - add help view        
//
//        [self.view addSubview:self.helpView];
//        self.helpView.alpha = 0;
//        [UIView animateWithDuration:1
//                         animations:^{ 				 
//                             self.helpView.alpha = 1.0;
//                         }
//        ];
//        
//    } else { // Has universities - remove help view if it is present
//        if ([self.helpView isDescendantOfView:self.view]) {
//            [self.helpView removeFromSuperview];
//        }        
//    }
//    
//    return numRows;
//}
//
//
//// Customize the appearance of table view cells.
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//    }
//    
//    University *uni = [self.universitiesToCompare objectAtIndex:indexPath.row];
//    
//	// Text: Rank. University
//	NSString *rankString = ([[uni rank2010] intValue] == 0) ? @"(none) " : [NSString stringWithFormat:@"%@. ", uni.rank2010];
//	cell.textLabel.text = [NSString stringWithFormat:@"%@%@", rankString, uni.sortName];    
//	
//    return cell;
//}
//
//
//// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//		
//	if (editingStyle == UITableViewCellEditingStyleDelete) {
//        
//        // Remove from array
//		int rowToRemove = [indexPath row];
//		[self.universitiesToCompare removeObjectAtIndex:rowToRemove];        
//        
//		// Delete the row from table
//		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];		
//        
//	} else if (editingStyle == UITableViewCellEditingStyleInsert) {
//		// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//	}   
//}
//
//
//#pragma mark -
//#pragma mark Table view delegate
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Navigation logic may go here. Create and push another view controller.
//    /*
//	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
//	 // ...
//	 // Pass the selected object to the new view controller.
//	 [self.navigationController pushViewController:detailViewController animated:YES];
//	 [detailViewController release];
//	 */
//}
//

#pragma mark -
#pragma mark === Action methods ===
#pragma mark

- (IBAction)addButtonPress {
        
    FindSelectorViewController *findVC = [[FindSelectorViewController alloc] initWithUniversitiesModel:universitiesModel selectedUniversities:self.universitiesToCompare];
	UINavigationController *findNavController = [[UINavigationController alloc] initWithRootViewController:findVC];
	[findVC release];
    
    [self presentModalViewController:findNavController animated:YES];        
    [findNavController release];
    
}

- (IBAction)compareButtonPress {
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"TODO" message:@"Compare not implemented yet" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
	[alert show];
}


@end
