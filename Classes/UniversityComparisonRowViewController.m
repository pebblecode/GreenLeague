//
//  UniversityComparisonRowView.m
//  GreenLeague
//
//  Created by Tak Tran on 19/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UniversityComparisonRowViewController.h"
#import "ScoreKey.h"
#import "NSString+Helper.h"

#define kViewHeight 50.0
#define kUniLabelWidth 185.0

#define kMaxNumRatingImages 4

@interface UniversityComparisonRowViewController()

- (NSNumber *)ratingImageIndexFromScore:(NSNumber *)score maxScore:(NSNumber *)maxScore;
- (UIImage *)imageFromIndex:(NSNumber *)index;
- (UIImage *)imageFromUniScoreKey:(ScoreKey *)scoreKey;

@end



@implementation UniversityComparisonRowViewController

@synthesize university, universitiesModel;

- (id)initWithUniversity:(University *)uni universitiesModel:(UniversitiesModel *)unisModel {
    self = [self initWithNibName:@"UniversityComparisonRowViewController" bundle:nil];
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
    UILabel *uniNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kUniLabelWidth, [UniversityComparisonRowViewController height])];
    uniNameLabel.text = university.sortName;
    [self.view addSubview:uniNameLabel];
    [uniNameLabel release];
    
    // For each question add score
    // Get questions as Score objects
    NSArray *scoreKeys = self.universitiesModel.questionScoreKeys;;
    for (ScoreKey *scoreKey in scoreKeys) {        
        // Set the correct image
        UIImage *ratingImage = [self imageFromUniScoreKey:scoreKey];
        
        UIImageView *scoreImageView = [[UIImageView alloc] initWithImage:ratingImage];
        // Layout score image
        //scoreImage.
        
        // Add it to the view
        [self.view addSubview:scoreImageView];
    }
    
    // self.view.frame = CGRectMake();
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

#pragma mark -
#pragma mark === Helper ===
#pragma mark

// Find the rating based on the number of rating images there are.
// Eg, if there are 4, then the ratings are 0-25%, 25-50%, 50-75% and 75-100% 
- (NSNumber *)ratingImageIndexFromScore:(NSNumber *)score maxScore:(NSNumber *)maxScore {
    
    float scorePercentage = [score floatValue] / [maxScore floatValue];
    NSNumber *ratingImageIndex = [NSNumber numberWithFloat:round(scorePercentage * (kMaxNumRatingImages - 1))];
    
    return ratingImageIndex;
}

// Get the image for a given index value
// 0 = awful
// 1 = poor
// 2 = ok
// 3 = excellent
- (UIImage *)imageFromIndex:(NSNumber *)index {
    UIImage *image = nil;
    
    switch ([index intValue]) {
        case 0:
            image = [UIImage imageNamed:@"star_awful.png"];
            break;
        case 1:
            image = [UIImage imageNamed:@"star_poor.png"];
            break;            
        case 2:
            image = [UIImage imageNamed:@"star_ok.png"];
            break; 
        case 3:
            image = [UIImage imageNamed:@"star_excellent.png"];
            break;             
            
        default:
            break;
    }
    
    return image;
}

- (UIImage *)imageFromUniScoreKey:(ScoreKey *)scoreKey {

    Score *uniScore = [self.universitiesModel findScoreForUniversity:self.university scoreKey:scoreKey];
    
    NSNumber *ratingImageIndex = [self ratingImageIndexFromScore:[uniScore.value numberFromString] maxScore:scoreKey.maxScore];
    NSLog(@"uniScore: %@/%d", uniScore.value, [scoreKey.maxScore intValue]);
    
    return [self imageFromIndex:ratingImageIndex];

}


@end
