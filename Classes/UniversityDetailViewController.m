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

University *university;

@property (nonatomic, retain) University *university;

@end



@implementation UniversityDetailViewController

@synthesize university, nameLabel, rank2010Label, rank2009Label, awardClassLabel, totalScoreLabel;



- (id)initWithUniversity:(University *)uni {
    self = [super initWithNibName:nil bundle:nil]; // Load default nib
    if (self) {
		university = uni;		
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
		
	self.nameLabel.text = [self.university name];
	self.rank2010Label.text = ([[self.university rank2010] intValue] == 0) ? @"(none)" : [NSString stringWithFormat:@"%@", [[self.university rank2010] ordinalString]];
	self.rank2009Label.text = ([[self.university rank2009] intValue] == 0) ? @"(none)" : [NSString stringWithFormat:@"%@", [[self.university rank2009] ordinalString]];
	self.awardClassLabel.text = [self.university awardClassName];
	self.totalScoreLabel.text = [NSString stringWithFormat:@"%.1f", [[self.university totalScore] floatValue]];
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
	
}

@end
