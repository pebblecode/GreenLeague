//
//  CompareViewControllerFullScreen.m
//  GreenLeague
//
//  Created by Tak Tran on 04/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CompareViewControllerFullScreen.h"
#include <math.h>
#import "CompareViewController.h"
#import "ComparisonViewDimensions.h"

static inline double degreesToRadians (double degrees) {return degrees * M_PI/180;}

@implementation CompareViewControllerFullScreen

@synthesize scrollView, compareViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCompareViewController:(CompareViewController *)compareVC {
    self = [self initWithNibName:@"CompareViewControllerFullScreen" bundle:nil];
    if (self) {
        self.compareViewController = compareVC;
    }
    
    return self;    
}

- (void)dealloc {
    
    [compareViewController release]; compareViewController = nil;
    [scrollView release]; scrollView = nil;
    
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
    NSLog(@"viewDidLoad");
    
    // Animate rotating sideways to the left
    [UIView animateWithDuration:0.75
                     animations:^{ 				 
                         self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(90));                       
                     }
     ];    
    

}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"viewWillAppear");
    
    // Reload to new scroll view
    self.scrollView = self.compareViewController.scrollView;
    NSLog(@"viewWillAppear: self.scrollView: %@", self.scrollView);    
    // Add scroll view and send it to the back
    [self.view addSubview:self.scrollView];
    [self.view sendSubviewToBack:self.compareViewController.scrollView];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"viewDidAppear");
    
    // Set the frame to be the size of the current view
    self.scrollView = self.compareViewController.scrollView;
    self.scrollView.frame = CGRectMake(0, 0, kFullScreenWidth, kFullScreenHeight);
    NSLog(@"self.scrollView: %@", self.scrollView);
    
    [self.scrollView setContentOffset:CGPointMake(0, 0)];    
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
#pragma mark === Public methods ===
#pragma mark

- (IBAction)exitFullScreenButtonPress { 
    [[NSNotificationCenter defaultCenter] postNotificationName:@"compareViewFullScreenExit" object:self];    

    [self.navigationController popViewControllerAnimated:NO];    
}


@end
