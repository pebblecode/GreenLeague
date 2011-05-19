//
//  UniversityComparisonRowView.m
//  GreenLeague
//
//  Created by Tak Tran on 19/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UniversityComparisonRowViewController.h"

#define kViewHeight 50.0
#define kUniLabelWidth 185.0
@implementation UniversityComparisonRowViewController

@synthesize university, universitiesModel;

- (id)initWithUniversity:(University *)uni universitiesModel:(UniversitiesModel *)unisModel {
    self = [self initWithNibName:@"UniversityComparisonRowViewController" bundle:nil];
    if (self) {
        self.university = [uni retain]; 
        universitiesModel = [universitiesModel retain];
    }
    return self;
}

- (void)dealloc
{
    [university release];
    [universitiesModel release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Programmatically, creat a view hierarchy
- (void)loadView 
{            
    self.view = [[UIView alloc] init];
    
    // Add university name label
    UILabel *uniNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kUniLabelWidth, [UniversityComparisonRowViewController height])];
    [self.view addSubview:uniNameLabel];
    [uniNameLabel release];
    
    // For each question add score
    // Get questions as Score objects
    NSArray *scoreKeys = universitiesModel.questionScoreKeys;
    for (NSString *scoreKey in scoreKeys) {
        // Get the score
        //Find university score where university.scoreKey =- scoreKey
        
        // Set the correct image
        
        
        // Add it to the view
    }
    
    // self.view.frame = CGRectMake();
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"TODO: UniversityComparisonView viewDidLoad");
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
#pragma mark === Dimensions ===
#pragma mark

+ (CGFloat)width {
    NSLog(@"TODO: width");
    return 0;
}

+ (CGFloat)height {
    return kViewHeight;
}

+ (CGFloat)heightForNumberOfRows:(NSUInteger)numRows {
    return self.height * numRows;
}

@end
