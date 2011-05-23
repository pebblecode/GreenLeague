//
//  UniversityComparisonTitlesViewController.m
//  GreenLeague
//
//  Created by Tak Tran on 09/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UniversityComparisonTitlesViewController.h"
#import "UniversityComparisonRowViewController.h"
#import "ComparisonViewDimensions.h"

@implementation UniversityComparisonTitlesViewController

@synthesize universitiesModel;

- (id)initWithUniversitiesModel:(UniversitiesModel *)unisModel {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.universitiesModel = [unisModel retain];
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

// Programmatically, creat a view hierarchy
- (void)loadView 
{            
    self.view = [[UIView alloc] init];
    
    // For each question add the title
    NSArray *scoreKeys = self.universitiesModel.questionScoreKeys;
    for (int i = 0; i < scoreKeys.count; i++) {
        ScoreKey *scoreKey = [scoreKeys objectAtIndex:i];
        
        // Get the correct image
        UILabel *questionTitle = [[UILabel alloc] init];
        questionTitle.font = [UIFont systemFontOfSize:12];
        questionTitle.numberOfLines = 2;
        questionTitle.textAlignment = UITextAlignmentCenter;
        if (scoreKey.shortName.length > 0) {
            questionTitle.text = scoreKey.shortName;
        } else {
            questionTitle.text = scoreKey.text;
        }
        
        [self.view addSubview:questionTitle];
        [questionTitle release];
        
        // Layout label
        // | kUniLabelFullWidth | kRatingImageFullWidth | kRatingImageFullWidth | ...
        questionTitle.frame = CGRectMake(kUniLabelFullWidth + (i * kRatingImageFullWidth), 0, kRatingImageWidth, kRatingImageHeight);        
    }
    
    // Add total label
    CGFloat totalScoreLabelXPos = kUniLabelFullWidth + (scoreKeys.count * kRatingImageFullWidth);
    UILabel *totalScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(totalScoreLabelXPos , 0, kTotalScoreLabelWidth, [UniversityComparisonRowViewController height])];
    totalScoreLabel.text = @"Total Score";
    totalScoreLabel.font = [UIFont boldSystemFontOfSize:15];
    totalScoreLabel.textAlignment = UITextAlignmentRight;
    [self.view addSubview:totalScoreLabel];
    [totalScoreLabel release];       
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

@end
