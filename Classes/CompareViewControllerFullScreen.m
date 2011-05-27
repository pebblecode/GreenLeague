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


@interface CompareViewControllerFullScreen()
    
- (void)animateRotation;

@end



@implementation CompareViewControllerFullScreen

@synthesize compareViewController;

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
    
    [self animateRotation];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"viewWillAppear");
    
    // Reload to new scroll view
    UIScrollView *scrollView = self.compareViewController.scrollView;
    NSLog(@"viewWillAppear: scrollView: %@", scrollView);    
    // Add scroll view and send it to the back
    [self.view addSubview:scrollView];
    [self.view sendSubviewToBack:scrollView];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"viewDidAppear");
    
    [self animateRotation];
    
    // Set the frame to be the size of the current view
    UIScrollView *scrollView = self.compareViewController.scrollView;
    scrollView.frame = self.view.bounds; 
    NSLog(@"scrollView: %@", scrollView);
    
    [scrollView setContentOffset:CGPointMake(0, 0)];     
}

- (void)animateRotation {
    // Animate view to rotate to the side
    UIDeviceOrientation currentOrientation = [[UIDevice currentDevice] orientation];    
    if (currentOrientation == UIDeviceOrientationLandscapeLeft) {
        // Animate rotating sideways to the left
        self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(0));
        [UIView animateWithDuration:0.75
                         animations:^{ 				 
                             self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(90));                       
                         }
         ];    
    } else if (currentOrientation == UIDeviceOrientationLandscapeRight) {
        // Animate rotating sideways to the left
        self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(0));
        [UIView animateWithDuration:0.75
                         animations:^{ 				 
                             self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(270));                       
                         }
         ];         
    } else {
        NSLog(@"Rotation error: Shouldn't be here!");
    }    
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
