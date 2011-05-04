//
//  CompareViewControllerFullScreen.m
//  GreenLeague
//
//  Created by Tak Tran on 04/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CompareViewControllerFullScreen.h"
#include <math.h>

static inline double degreesToRadians (double degrees) {return degrees * M_PI/180;}

@implementation CompareViewControllerFullScreen

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"CompareViewControllerFullScreen" bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Rotate sideways
    self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(90));
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark -
#pragma mark === Overriding super methods ===
#pragma mark

// Returns whether to show the find selector at first or not
// Should override this in subclasses
- (BOOL)shouldShowFindSelectorFirst {
    return NO;
}


@end
