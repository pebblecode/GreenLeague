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

@synthesize university, universitiesModel, nameLabel, rankLabel, rankLastYearLabel, awardClassImage, totalScoreLabel;



- (id)initWithUniversity:(University *)uni universitiesModel:(UniversitiesModel *)unisModel {
    self = [super initWithNibName:nil bundle:nil]; // Load default nib
    if (self) {
		university = [uni retain]; // Keep a reference to the university
        universitiesModel = [unisModel retain];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

	self.nameLabel.text = [self.university name];
	self.rankLabel.text = ([[self.university rank] intValue] == 0) ? @"(none)" : [NSString stringWithFormat:@"%@", [[self.university rank] ordinalString]];
	self.rankLastYearLabel.text = ([[self.university rankLastYear] intValue] == 0) ? @"(none)" : [NSString stringWithFormat:@"%@", [[self.university rankLastYear] ordinalString]];
	self.awardClassImage.image = [AwardClassHelper badgeImageForAwardClassDBName:[self.university awardClass]];
	self.totalScoreLabel.text = [NSString stringWithFormat:@"%.1f", [[self.university totalScore] floatValue]];

	// Change colours to award class colours
	self.rankLabel.backgroundColor = [self.university awardClassBackgroundColour];
	
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
    [universitiesModel release];
	
	[nameLabel release];
	[rankLabel release];
	[rankLastYearLabel release];
	[awardClassImage release];
	[totalScoreLabel release];
	
    [super dealloc];
}

#pragma mark -
#pragma mark === Action methods ===
#pragma mark

- (IBAction)detailButtonPressed {
	UniversityMoreDetailViewController *uniMoreDetailVC = [[UniversityMoreDetailViewController alloc] initWithUniversity:self.university universitiesModel:self.universitiesModel];
	[self.navigationController pushViewController:uniMoreDetailVC animated:YES];
	
	[uniMoreDetailVC release];
}

@end
