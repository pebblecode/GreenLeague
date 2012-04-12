//
//  MethodologyViewController.h
//  GreenLeague
//
//  Methodology screen that loads the Methodology.html file. If a score
//  key exists, then only a section of the methodology is selected,
//  otherwise the entire methodology is shown.
//
//  Created by Tak Tran (Pebble Code - http://pebblecode.com)
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
