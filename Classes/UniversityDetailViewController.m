//
//  UniversityDetailViewController.m
//  GreenLeague
//
//  Created by Tak Tran on 02/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UniversityDetailViewController.h"
#import "NSNumber+Helper.h"

@implementation UniversityDetailViewController

@synthesize rank2010Str, rank2009Str, awardClassStr, totalScoreStr, rank2010Label, rank2009Label, awardClassLabel, totalScoreLabel, infoButton;



- (id)initWithRank2010:(NSNumber *)rank2010 rank2009:(NSNumber *)rank2009 awardClass:(NSString *)awardClass totalScore:(NSNumber *)totalScore {
    self = [super initWithNibName:nil bundle:nil]; // Load default nib
    if (self) {
		rank2010Str= ([rank2010 intValue] == 0) ? @"(none)" : [NSString stringWithFormat:@"%@", [rank2010 ordinalString]] ;
		rank2009Str = ([rank2009 intValue] == 0) ? @"(none)" : [NSString stringWithFormat:@"%@", [rank2009 ordinalString]];
		awardClassStr = [awardClass copy];
		totalScoreStr = [NSString stringWithFormat:@"%.1f", [totalScore floatValue]];			
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.rank2010Label.text = rank2010Str;
	self.rank2009Label.text = rank2009Str;
	self.awardClassLabel.text = awardClassStr;
	self.totalScoreLabel.text = totalScoreStr;	
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
	[rank2010Str release];
	[rank2009Str release];
	[awardClassStr release];
	[totalScoreStr release];
	
	[rank2010Label release];
	[rank2009Label release];
	[awardClassLabel release];
	[totalScoreLabel release];
	[infoButton release];
	
    [super dealloc];
}


@end