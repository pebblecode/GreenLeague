//
//  FindSelectorViewController.m
//  GreenLeague
//
//  Created by Tak Tran on 08/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FindSelectorViewController.h"


@implementation FindSelectorViewController

@synthesize navController, findViewController;

- (id)initWithUniversitiesModel:(UniversitiesModel *)unisModel {
	if ((self = [self initWithNibName:@"FindSelectorViewController" bundle:nil])) {
		findViewController = [[FindViewController alloc]initWithUniversitiesModel:unisModel];        
        navController = [[UINavigationController alloc] initWithRootViewController:findViewController];
	}
	return self;	
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc {
    [findViewController release];
    [navController release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark -
#pragma mark === View lifecycle ===
#pragma mark

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view = navController.view;
    self.findViewController.title = @"Universities";
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
