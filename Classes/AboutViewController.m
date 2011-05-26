//
//  AboutViewController.m
//  GreenLeague
//
//  Created by Tak on 24/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"
#import "UIApplication+Helper.h"

static NSString *kAboutHtmlFile = @"About";

@implementation AboutViewController

@synthesize aboutWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"About" image:[UIImage imageNamed:@"189-plant.png"] tag:1];		
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     // Load file url into webview
    NSString *aboutFilePath = [[NSBundle mainBundle] pathForResource:kAboutHtmlFile ofType:@"html"];   
    NSURL *fileUrl = [NSURL fileURLWithPath:aboutFilePath];
    [self.aboutWebView loadRequest:[NSURLRequest requestWithURL:fileUrl]];    
    
    self.aboutWebView.delegate = self;
    // Make background transparent (see http://stackoverflow.com/questions/3646930/how-to-make-a-transparent-uiwebview/3935033#3935033)
    self.aboutWebView.opaque = NO;
    self.aboutWebView.backgroundColor = [UIColor clearColor];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [aboutWebView release]; aboutWebView = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark === Button methods ===
#pragma mark 

- (IBAction)greenLeagueButtonPress {
    [UIApplication openInApplicationWithURL:@"http://peopleandplanet.org/greenleague"];	
}

- (IBAction) pebbleLink:(UIButton *)sender {
    [UIApplication openInApplicationWithURL:@"http://pebbleit.com/"];	    
}

- (IBAction) donateButtonPress:(UIButton *)sender {
    [UIApplication openInApplicationWithURL:@"http://peopleandplanet.org/greenleague/donate/"];    
}

#pragma mark -
#pragma mark === Web view delegate methods ===
#pragma mark


-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    
    if (inType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

@end
