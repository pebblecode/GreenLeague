//
//  CompareViewController.m
//  GreenLeague
//
//  Created by Tak on 24/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CompareViewController.h"


@implementation CompareViewController

@synthesize universitiesToCompare;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if ((self = [super initWithNibName:@"CompareViewController" bundle:nibBundleOrNil])) {
		self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Compare" image:[UIImage imageNamed:@"12-eye.png"] tag:1];		
	}
	return self;
} 


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Add button to the bottom of the table
	UIView *compareButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
	UIButton *compareButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	compareButton.frame = CGRectMake(60, 10, 200, 40);
	[compareButton setTitle:@"Compare" forState:UIControlStateNormal];
	[compareButton addTarget:self action:@selector(compareButtonPress) forControlEvents:UIControlEventTouchUpInside];
	
	[compareButtonView addSubview:compareButton];		
	self.tableView.tableFooterView = compareButtonView;

	[compareButtonView release];
	
	// Set editing mode
	[self.tableView setEditing:YES animated:NO];
	
	// Populate table with universities
	
	
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
	[universitiesToCompare release];
	
    [super dealloc];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"Compare:";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [universitiesToCompare count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	
	// TODO: get university
	cell.textLabel.text = @"hello";
	
    return cell;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
		
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		// Delete the row from the data source.
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
		
		int rowToRemove = [indexPath row];
		[universitiesToCompare removeObjectAtIndex:rowToRemove];
	} else if (editingStyle == UITableViewCellEditingStyleInsert) {
		// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
	}   
}


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
#pragma mark === Action methods ===
#pragma mark

- (IBAction)compareButtonPress {
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"TODO" message:@"Not implemented yet" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
	[alert show];
}


@end
