//
//  AboutViewController.m
//  GreenLeague
//
//  Created by Tak on 24/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"


@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"About" image:[UIImage imageNamed:@"189-plant.png"] tag:1];		
	}
	return self;
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
    [super dealloc];
}

#pragma mark -
#pragma mark === Button methods ===
#pragma mark 

- (IBAction)greenLeagueButtonPress {
	NSString *urlAddress = @"http://peopleandplanet.org/greenleague";
	NSURL *url = [NSURL URLWithString:urlAddress];		
	[[UIApplication sharedApplication] openURL:url];		
}

- (IBAction) pebbleLink:(UIButton *)sender {
	NSString *urlAddress = @"http://pebbleit.com/";		
	NSURL *url = [NSURL URLWithString:urlAddress];		
	[[UIApplication sharedApplication] openURL:url];
}

- (IBAction) donateButtonPress:(UIButton *)sender {
	NSString *urlAddress = @"http://peopleandplanet.org/greenleague/donate/";
	NSURL *url = [NSURL URLWithString:urlAddress];		
	[[UIApplication sharedApplication] openURL:url];
}

@end
