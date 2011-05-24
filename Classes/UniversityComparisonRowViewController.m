//
//  UniversityComparisonRowView.m
//  GreenLeague
//
//  Created by Tak Tran on 19/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UniversityComparisonRowViewController.h"
#import "ComparisonViewDimensions.h"
#import "ScoreClassHelper.h"


@implementation UniversityComparisonRowViewController

@synthesize university, universitiesModel;

- (id)initWithUniversity:(University *)uni universitiesModel:(UniversitiesModel *)unisModel {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.university = [uni retain];
        self.universitiesModel = [unisModel retain];
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
    UILabel *uniNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kUniLabelPadding, 0, kUniLabelWidth, [UniversityComparisonRowViewController height])];
    uniNameLabel.text = university.sortName;
    [self.view addSubview:uniNameLabel];
    [uniNameLabel release];
    
    // For each question (from score keys), get the rating images and add to the view
    NSArray *scoreKeys = self.universitiesModel.questionScoreKeys;
    for (int i = 0; i < scoreKeys.count; i++) {
        ScoreKey *scoreKey = [scoreKeys objectAtIndex:i];
        
        // Get the correct image
        UIImage *ratingImage = [ScoreClassHelper imageFromUniScoreKey:scoreKey university:self.university universitiesModel:self.universitiesModel];        
        UIImageView *ratingImageView = [[UIImageView alloc] initWithImage:ratingImage];
        [self.view addSubview:ratingImageView];
        [ratingImageView release];
        
        // Layout image
        // | kUniLabelFullWidth | kRatingImageContainerFullWidth | kRatingImageContainerFullWidth | ...
        ratingImageView.frame = CGRectMake(kUniLabelFullWidth + (i * kRatingImageContainerFullWidth) + (kRatingImageContainerWidth / 2) - (kRatingImageWidth / 2), (kRatingImageContainerHeight / 2) - (kRatingImageHeight / 2), kRatingImageWidth, kRatingImageHeight);
        
    }
    
    // Total score label
    CGFloat totalScoreLabelXPos = kUniLabelFullWidth + (scoreKeys.count * kRatingImageContainerFullWidth);
    UILabel *totalScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(totalScoreLabelXPos , 0, kTotalScoreLabelWidth, [UniversityComparisonRowViewController height])];
    
    totalScoreLabel.text = [NSString stringWithFormat:@"%.1f", [university.totalScore floatValue]];
    totalScoreLabel.font = [UIFont boldSystemFontOfSize:20];
    totalScoreLabel.textAlignment = UITextAlignmentRight;    
    [self.view addSubview:totalScoreLabel];
    [totalScoreLabel release];    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
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

+ (CGFloat)widthFromUniversitiesModel:(UniversitiesModel *)unisModel {
    return kUniLabelFullWidth + (unisModel.questionScoreKeys.count * kRatingImageContainerFullWidth) + kTotalScoreLabelFullWidth;
}

+ (CGFloat)height {
    return kViewHeight;
}

+ (CGFloat)heightForNumberOfRows:(NSUInteger)numRows {
    return self.height * numRows;
}




@end
