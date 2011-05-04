//
//  CompareViewControllerFullScreen.h
//  GreenLeague
//
//  Created by Tak Tran on 04/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompareViewControllerFullScreen : UIViewController {
    UIScrollView *scrollView;
}

@property (nonatomic, retain) UIScrollView *scrollView;

- (id)initWithScrollView:(UIScrollView *)sView;

@end
