//
//  CompareViewControllerFullScreen.h
//  GreenLeague
//
//  Full screen view of the compared universities
//
//  Created by Tak Tran (Pebble Code - http://pebblecode.com)
//

#import <UIKit/UIKit.h>

@class CompareViewController;

@interface CompareViewControllerFullScreen : UIViewController {
    CompareViewController *compareViewController;
}

@property (nonatomic, retain) CompareViewController *compareViewController;


- (id)initWithCompareViewController:(CompareViewController *)compareVC;

- (IBAction)exitFullScreenButtonPress;

@end
