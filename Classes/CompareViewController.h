//
//  CompareViewController.h
//  GreenLeague
//
//  Created by Tak on 24/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UniversitiesModel.h"
#import "UniversityComparisonTitlesViewController.h"
#import "FindSelectorViewController.h"

// Note: CompareViewController is handled by a navigation controller from the app delegate.
@interface CompareViewController : UIViewController {
	NSMutableArray *universitiesToCompare;
	UniversitiesModel *universitiesModel;
    
    
    UIView *helpView;
    UIScrollView *scrollView;
    
    NSMutableArray *universityViewControllers;
    UniversityComparisonTitlesViewController *comparisonTitlesViewController;
    
    FindSelectorViewController *findSelectorViewController;
}

@property (nonatomic, retain) NSMutableArray *universitiesToCompare;
@property (nonatomic, retain) UniversitiesModel *universitiesModel;

@property (nonatomic, retain) IBOutlet UIView *helpView;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet NSMutableArray *universityViewControllers;
@property (nonatomic, retain) UniversityComparisonTitlesViewController *comparisonTitlesViewController;
@property (nonatomic, retain) FindSelectorViewController *findSelectorViewController;

- (id)initWithUniversitiesModel:(UniversitiesModel *)unisModel;
- (void)setUniversitiesToCompareWithNotification:(NSNotification *)notification;

- (IBAction)addButtonPress;
- (IBAction)compareButtonPress;

- (void)showFindSelectorView;

@end
