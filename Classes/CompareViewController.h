//
//  CompareViewController.h
//  GreenLeague
//
//  Loads the data from the univerities model and shows it in a table. Selecting
//  universities allows it to be viewed in full screen.
//
//  Created by Tak Tran (Pebble Code - http://pebblecode.com)
//

#import <UIKit/UIKit.h>
#import "UniversitiesModel.h"
#import "UniversityComparisonTitlesViewController.h"
#import "FindSelectorViewController.h"

@class CompareViewControllerFullScreen;

// Note: CompareViewController is handled by a navigation controller from the app delegate.
@interface CompareViewController : UIViewController {
	NSMutableArray *universitiesToCompare;
	UniversitiesModel *universitiesModel;
    
    
    UIView *helpView;
    UIScrollView *scrollView;
    UIView *tableKeyView;
    UIButton *fullScreenButton;
    
    NSMutableArray *universityViewControllers;
    UniversityComparisonTitlesViewController *comparisonTitlesViewController;
    
    FindSelectorViewController *findSelectorViewController;
    CompareViewControllerFullScreen *fullScreenViewController;
}

@property (nonatomic, retain) NSMutableArray *universitiesToCompare;
@property (nonatomic, retain) UniversitiesModel *universitiesModel;

@property (nonatomic, retain) IBOutlet UIView *helpView;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIView *tableKeyView;
@property (nonatomic, retain) IBOutlet UIButton *fullScreenButton;
@property (nonatomic, retain) IBOutlet NSMutableArray *universityViewControllers;
@property (nonatomic, retain) UniversityComparisonTitlesViewController *comparisonTitlesViewController;
@property (nonatomic, retain) FindSelectorViewController *findSelectorViewController;
@property (nonatomic, retain) CompareViewControllerFullScreen *fullScreenViewController;

- (BOOL)shouldShowFindSelectorFirst;

- (id)initWithUniversitiesModel:(UniversitiesModel *)unisModel;
- (void)setUniversitiesToCompareWithNotification:(NSNotification *)notification;

- (void)exitFullScreen:(NSNotification *)notification;

- (IBAction)editButtonPress;
- (IBAction)fullScreenButtonPress;
- (IBAction)compareButtonPress;

@end
