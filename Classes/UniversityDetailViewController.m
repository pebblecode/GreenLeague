//
//  UniversityDetailViewController.m
//  GreenLeague
//
//  Created by Tak Tran on 02/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UniversityDetailViewController.h"
#import "UniversityMoreDetailViewController.h"
#import "NSNumber+Helper.h"
#import "AwardClassHelper.h"
#import "University.h"

@interface UniversityDetailViewController()

@end



@implementation UniversityDetailViewController

@synthesize university, nameLabel, rank2010Label, rank2009Label, awardClassLabel, totalScoreLabel;



- (id)initWithUniversity:(University *)uni {
    self = [super initWithNibName:nil bundle:nil]; // Load default nib
    if (self) {
		university = [uni retain]; // Keep a reference to the university
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"TODO: UniversityDetailViewController viewDidLoad");
//	self.nameLabel.text = [self.university name];
//	self.rank2010Label.text = ([[self.university rank2010] intValue] == 0) ? @"(none)" : [NSString stringWithFormat:@"%@", [[self.university rank2010] ordinalString]];
//	self.rank2009Label.text = ([[self.university rank2009] intValue] == 0) ? @"(none)" : [NSString stringWithFormat:@"%@", [[self.university rank2009] ordinalString]];
//	self.awardClassLabel.text = [self.university awardClassName];
//	self.totalScoreLabel.text = [NSString stringWithFormat:@"%.1f", [[self.university totalScore] floatValue]];
//
//	// Change colours to award class colours
//	self.awardClassLabel.textColor = [self.university awardClassTextColour];
//	
//	self.awardClassLabel.backgroundColor = [self.university awardClassBackgroundColour];
//	self.rank2010Label.backgroundColor = [self.university awardClassBackgroundColour];
	
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
	[university release];
	
	[nameLabel release];
	[rank2010Label release];
	[rank2009Label release];
	[awardClassLabel release];
	[totalScoreLabel release];
	
    [super dealloc];
}

#pragma mark -
#pragma mark === Action methods ===
#pragma mark

- (IBAction)detailButtonPressed {
	UniversityMoreDetailViewController *uniMoreDetailVC = [[UniversityMoreDetailViewController alloc] initWithUniversity:self.university];
	[self.navigationController pushViewController:uniMoreDetailVC animated:YES];
	
	[uniMoreDetailVC release];
}

@end
