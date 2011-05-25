//
//  MethodologyViewController.h
//  GreenLeague
//
//  Created by Tak Tran on 25/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreKey.h"

@interface MethodologyViewController : UIViewController <UIWebViewDelegate> {
    UIWebView *webView;
    ScoreKey *scoreKey;
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) ScoreKey *scoreKey;

- (id)initWithScoreKey:(ScoreKey *)sk;

@end
