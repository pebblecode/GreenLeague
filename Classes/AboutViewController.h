//
//  AboutViewController.h
//  GreenLeague
//
//  About screen that loads the About.html file.
//
//  Created by Tak Tran (Pebble Code - http://pebblecode.com)
//

#import <UIKit/UIKit.h>


@interface AboutViewController : UIViewController <UIWebViewDelegate> {
    UIWebView *aboutWebView;    
}

@property (nonatomic, retain) IBOutlet UIWebView *aboutWebView;

- (IBAction)greenLeagueButtonPress;
- (IBAction) pebbleLink:(UIButton *)sender;
- (IBAction) donateButtonPress:(UIButton *)sender;

@end
