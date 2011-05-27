//
//  CompareViewController.m
//  GreenLeague
//
//  Created by Tak on 24/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CompareViewController.h"
#import "University.h"
#import "UniversityComparisonTitlesViewController.h"
#import "UniversityComparisonRowViewController.h"
#import "ComparisonViewDimensions.h"
#import "CompareViewControllerFullScreen.h"

@interface CompareViewController()

- (void)refreshScrollView;
- (void)showFindSelectorView;
- (void)showHelpMessage;
- (void)clearInterface;
- (void)rotateViewTo:(UIDeviceOrientation)orientation;

@end

@implementation CompareViewController

@dynamic universitiesToCompare;
@synthesize universitiesModel, helpView, scrollView, tableKeyView, fullScreenButton, universityViewControllers, comparisonTitlesViewController, findSelectorViewController, fullScreenViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.title = @"Universities";
		self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Compare" image:[UIImage imageNamed:@"12-eye.png"] tag:1];
	}
	return self;
} 

- (id)initWithUniversitiesModel:(UniversitiesModel *)unisModel {
	if ((self = [self initWithNibName:@"CompareViewController" bundle:nil])) {
		universitiesModel = [unisModel retain];                
        
        if ([self.universitiesToCompare count] <= 0) {            
//            // Add top ranked uni
//            University *uni = [universitiesModel topRankedUniversity];          
//            if (uni) {
//                [self setUniversitiesToCompare:[NSMutableSet setWithObject:uni]];                
//            }   
            [self setUniversitiesToCompare:[NSMutableArray array]];
        }
	}
	return self;	
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonPress)];
    self.navigationItem.rightBarButtonItem = editButton;    

    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(clearButtonPress)];
    self.navigationItem.leftBarButtonItem = clearButton;        
    
//    UIBarButtonItem *compareButton = [[UIBarButtonItem alloc] initWithTitle:@"Compare" style:UIBarButtonItemStylePlain target:self action:@selector(compareButtonPress)];
//	self.navigationItem.rightBarButtonItem = compareButton;
            
    // Handle universities selected on modal form
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setUniversitiesToCompareWithNotification:) name:@"selectedUniversitiesSet" object:nil];    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitFullScreen:) name:@"compareViewFullScreenExit" object:nil];
    
//    // Add help view
//    if ([self.universitiesToCompare count] <= 0) {
//        [self.scrollView addSubview:self.helpView];
//    } 
    
    if ([self shouldShowFindSelectorFirst]) {
        // Show find selector 
        [self.navigationController pushViewController:self.findSelectorViewController animated:NO];        
    }
    
    // Detect rotation
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:@"UIDeviceOrientationDidChangeNotification" object:nil]; 

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
    
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];

}


- (void)dealloc {
    [universityViewControllers release]; universityViewControllers = nil;
	[universitiesToCompare release]; universitiesToCompare = nil;
	[universitiesModel release]; universitiesModel = nil;
	[helpView release]; helpView = nil;
    [scrollView release]; scrollView = nil;
    [tableKeyView release]; tableKeyView = nil;
    [fullScreenButton release]; fullScreenButton = nil;
    [comparisonTitlesViewController release]; comparisonTitlesViewController = nil;
    [findSelectorViewController release]; findSelectorViewController = nil;
    [fullScreenViewController release]; fullScreenViewController = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark === Getters/Setters ===
#pragma mark

- (NSMutableArray *)universitiesToCompare {
    return universitiesToCompare;
}

- (void)setUniversitiesToCompare:(NSMutableArray *)unisToCompare {
    if (universitiesToCompare != unisToCompare) {
        [universitiesToCompare release];
        universitiesToCompare = [unisToCompare retain]; // Keep a retain of the new set
        
        // Sort universities by rank
        NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"rank" ascending:YES];
        [universitiesToCompare sortUsingDescriptors:[NSArray arrayWithObject:descriptor]];
        [descriptor release];
        
        [self refreshScrollView];                
    }
}

- (void)setUniversitiesToCompareWithNotification:(NSNotification *)notification {    
    [self setUniversitiesToCompare:[NSMutableArray arrayWithArray:[notification.object allObjects]]];
}

- (NSMutableArray *)universityViewControllers {    
    if (!universityViewControllers) {
        universityViewControllers = [[NSMutableArray alloc] init];
    }
    return universityViewControllers;
}

- (UniversityComparisonTitlesViewController *)comparisonTitlesViewController {
    
    if (!comparisonTitlesViewController) {
        comparisonTitlesViewController = [[UniversityComparisonTitlesViewController alloc] initWithUniversitiesModel:self.universitiesModel];
    }
    
    return comparisonTitlesViewController;
    
}

- (FindSelectorViewController *) findSelectorViewController {
    if (!findSelectorViewController) {
        findSelectorViewController = [[FindSelectorViewController alloc] initWithUniversitiesModel:self.universitiesModel selectedUniversities:self.universitiesToCompare];        
    }
    
    return findSelectorViewController;
}

- (CompareViewControllerFullScreen *)fullScreenViewController {
    if (!fullScreenViewController) {
        fullScreenViewController = [[CompareViewControllerFullScreen alloc] initWithCompareViewController:self];
    }
    return fullScreenViewController;
}

#pragma mark -
#pragma mark === Public methods ===
#pragma mark

// Returns whether to show the find selector at first or not
// Should override this in subclasses
- (BOOL)shouldShowFindSelectorFirst {
    return YES;
}

#pragma mark -
#pragma mark === Private methods ===
#pragma mark

- (void)refreshScrollView {
    // Clear scroll view
    for (UIView *scrollSubview in self.scrollView.subviews) {        
        [scrollSubview removeFromSuperview];
    }
    [universityViewControllers release]; universityViewControllers = nil; 
    
    // Figure out height of scroll view
    // Include table key height too.
    CGFloat scrollHeight = [UniversityComparisonRowViewController heightForNumberOfRows:[self.universitiesToCompare count]] + kRowHeight + self.tableKeyView.frame.size.height + (0.5 * kRowHeight); // 0.5 row height footer padding

    // Set the content size of the scroll view
    [self.scrollView setContentSize:CGSizeMake([UniversityComparisonRowViewController widthFromUniversitiesModel:self.universitiesModel], scrollHeight)];

    // Loop through universities to compare and create a UniversityComparisonRowViewController for each
    for (int i = 0; i < [self.universitiesToCompare count]; i++) {
        University *uni = [self.universitiesToCompare objectAtIndex:i];
        
        UniversityComparisonRowViewController *uniRowVC = [[UniversityComparisonRowViewController alloc] initWithUniversity:uni universitiesModel:self.universitiesModel];
        [self.universityViewControllers addObject:uniRowVC];
        [uniRowVC release];        
        
        // Set layout
        uniRowVC.view.frame = CGRectMake(0, i * [UniversityComparisonRowViewController height] + kRowHeight, [UniversityComparisonRowViewController widthFromUniversitiesModel:self.universitiesModel], [UniversityComparisonRowViewController height]);
                
        // Add to scroll view
        [self.scrollView addSubview:uniRowVC.view];
    }
    
    // Add titles to title scroll      
    if ([self.universitiesToCompare count] > 0) {        
        [self.scrollView addSubview:[self.comparisonTitlesViewController view]];
        [self.scrollView setScrollEnabled:YES];
        
        self.helpView.hidden = YES; // Hide help message
        self.tableKeyView.hidden = NO;
        self.fullScreenButton.hidden = NO;
    } else {
        [self showHelpMessage];
    }        
}

- (void)showFindSelectorView {
    // Using nav controller that CompareViewController should already be in
    [self.navigationController pushViewController:self.findSelectorViewController animated:NO];
}


- (void)showHelpMessage {
    self.helpView.hidden = NO;
    
    // Scroll to top left and disable scrolling
    self.scrollView.contentOffset = CGPointZero;
    [self.scrollView setScrollEnabled:NO];
    
    self.tableKeyView.hidden = YES;
    self.fullScreenButton.hidden = YES;
}

#pragma mark -
#pragma mark === Notification handling ===
#pragma mark

- (void)exitFullScreen:(NSNotification *)notification {
    // Show status bar and nav bar
    [[UIApplication sharedApplication] setStatusBarHidden:NO];    
    self.navigationController.navigationBarHidden = NO;
    self.hidesBottomBarWhenPushed = NO;
    
    // Need to re-add scroll view for some reason
    [self.view addSubview:self.scrollView];
    [self.view sendSubviewToBack:self.scrollView];
    self.scrollView.frame = CGRectMake(0, 0, 320, 367);
}


- (void)orientationChanged:(NSNotification *)notification {
    UIDeviceOrientation currentOrientation = [[UIDevice currentDevice] orientation];
    NSString *orientationStr;
    
    switch (currentOrientation) {
        case UIDeviceOrientationUnknown:
            orientationStr = @"unknown";
            break;
        case UIDeviceOrientationPortrait:
            orientationStr = @"portrait";
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            orientationStr = @"portrait upside down";
            break;
        case UIDeviceOrientationLandscapeLeft:
            orientationStr = @"landscape left";
            break;
        case UIDeviceOrientationLandscapeRight:
            orientationStr = @"landscape right";
            break;
            
        default:
            break;
    }
    
    NSLog(@"Orienation changed: %@", orientationStr);
    [self rotateViewTo:currentOrientation];
}

#pragma mark -
#pragma mark === Rotation methods ===
#pragma mark

// Rotate view based on the orientation
- (void)rotateViewTo:(UIDeviceOrientation)orientation {
    
//    switch (orientation) {
//        case UIDeviceOrientationPortrait:
//        case UIDeviceOrientationPortraitUpsideDown:
//            // Do nothing
//
//            break;            
//        case UIDeviceOrientationLandscapeLeft:
//        case UIDeviceOrientationLandscapeRight:
//            [self clearInterface];              
//            [self.navigationController pushViewController:self.fullScreenViewController animated:NO];      
//                        
//            break;
//        default:
//            break;
//    }
}

// Clear interface clutter from compare scroll view
- (void)clearInterface {
    // Hide tab bar
    self.hidesBottomBarWhenPushed = YES; 
    
    // Hide status bar
    [[UIApplication sharedApplication] setStatusBarHidden:YES];    
    
    // Hide navigation bar
    self.navigationController.navigationBarHidden = YES;   
}

#pragma mark -
#pragma mark === Action methods ===
#pragma mark

- (IBAction)editButtonPress {    
    [self showFindSelectorView];
}

- (IBAction)clearButtonPress {
    
    [self.findSelectorViewController clearSelectedUniversities];

    [self.universitiesToCompare removeAllObjects];
    [self refreshScrollView];
    
}

- (IBAction)fullScreenButtonPress {    
    
    [self clearInterface];
    
    [self.navigationController pushViewController:self.fullScreenViewController animated:NO];
    
}

- (IBAction)compareButtonPress {
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"TODO" message:@"Compare not implemented yet" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
	[alert show];
}


@end
