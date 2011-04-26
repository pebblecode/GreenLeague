//
//  CompareViewController.m
//  GreenLeague
//
//  Created by Tak on 24/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CompareViewController.h"
#import "University.h"
#import "FindSelectorViewController.h"
#import "UniversityComparisonTitlesViewController.h"
#import "UniversityComparisonViewController.h"

#define kTitleHeight 60.0

@interface CompareViewController()

- (void)refreshScrollView;

@end

@implementation CompareViewController

@dynamic universitiesToCompare;
@synthesize universitiesModel, helpView, scrollView, universityViewControllers, comparisonTitlesViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if ((self = [super initWithNibName:@"CompareViewController" bundle:nibBundleOrNil])) {
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
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPress)];
    self.navigationItem.leftBarButtonItem = addButton;    
    
//    UIBarButtonItem *compareButton = [[UIBarButtonItem alloc] initWithTitle:@"Compare" style:UIBarButtonItemStylePlain target:self action:@selector(compareButtonPress)];
//	self.navigationItem.rightBarButtonItem = compareButton;
            
    // Handle universities selected on modal form
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setUniversitiesToCompareWithNotification:) name:@"selectedUniversitiesSet" object:nil];    

    // Add help view
    if ([self.universitiesToCompare count] <= 0) {
        [self.scrollView addSubview:self.helpView];
    } 
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
    [universityViewControllers release];
	[universitiesToCompare release];
	[universitiesModel release];
	[helpView release];
    [scrollView release];
    [comparisonTitlesViewController release];
    
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
        NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"rank2010" ascending:YES];
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
        comparisonTitlesViewController = [[UniversityComparisonTitlesViewController alloc] initWithNibName:@"UniversityComparisonTitlesViewController" bundle:nil];
        NSLog(@"comp titles: %@", comparisonTitlesViewController);
    }
    
    return comparisonTitlesViewController;
    
}

#pragma mark -
#pragma mark === Scroll view ===
#pragma mark

- (void)refreshScrollView {
    // Clear scroll view
    for (UIView *scrollSubview in self.scrollView.subviews) {        
        [scrollSubview removeFromSuperview];
    }
    [universityViewControllers release]; universityViewControllers = nil;    
    
    // Figure out how big the scroll content size should be
    CGFloat scrollHeight = ([UniversityComparisonViewController height] * [self.universitiesToCompare count] + kTitleHeight);
    
    // Set the content size of the scroll view
    [self.scrollView setContentSize:CGSizeMake([UniversityComparisonViewController width], scrollHeight)];
    
    // Loop through universities to compare and create a UniversityComparisonView for each
    for (int i = 0; i < [self.universitiesToCompare count]; i++) {
        University *uni = [self.universitiesToCompare objectAtIndex:i];
        
        UniversityComparisonViewController *uniComparisonVC = [[UniversityComparisonViewController alloc] initWithUniversity:uni];
        [self.universityViewControllers addObject:uniComparisonVC];
        [uniComparisonVC release];
        
        // Set layout
        uniComparisonVC.view.frame = CGRectMake(0, i * uniComparisonVC.view.frame.size.height + kTitleHeight, uniComparisonVC.view.frame.size.width, uniComparisonVC.view.frame.size.height);
        
        // Add to scroll view
        [self.scrollView addSubview:uniComparisonVC.view];
        
    }
    
    // Add titles to title scroll      
    if ([self.universitiesToCompare count] > 0) {        
        [self.scrollView addSubview:[self.comparisonTitlesViewController view]];
    } else {
        [self.scrollView addSubview:self.helpView];
    }        
}


#pragma mark -
#pragma mark === Action methods ===
#pragma mark

- (IBAction)addButtonPress {
        
    FindSelectorViewController *findVC = [[FindSelectorViewController alloc] initWithUniversitiesModel:universitiesModel selectedUniversities:self.universitiesToCompare];
    
    // Using nav controller that CompareViewController should already be in
    [self.navigationController pushViewController:findVC animated:NO];
    [findVC release];
}

- (IBAction)compareButtonPress {
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"TODO" message:@"Compare not implemented yet" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
	[alert show];
}


@end
