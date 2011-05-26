//
//  AboutViewController.h
//  GreenLeague
//
//  Created by Tak on 24/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
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
