
//  FindSelectorViewController.h
//  GreenLeague
//
//  Created by Tak Tran on 08/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindViewController.h"

// A wrapper around FindViewController for selecting
@interface FindSelectorViewController : UINavigationController {
    UINavigationController *navController;
    FindViewController *findViewController;
}

@property (nonatomic, retain) UINavigationController *navController;
@property (nonatomic, retain) FindViewController *findViewController;

@end
