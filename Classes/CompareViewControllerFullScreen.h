//
//  CompareViewControllerFullScreen.h
//  GreenLeague
//
//  Created by Tak Tran on 04/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CompareViewController;

@interface CompareViewControllerFullScreen : UIViewController {
    UIScrollView *scrollView;
    CompareViewController *compareViewController;
}

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) CompareViewController *compareViewController;


- (id)initWithCompareViewController:(CompareViewController *)compareVC;

- (IBAction)exitFullScreenButtonPress;

@end
