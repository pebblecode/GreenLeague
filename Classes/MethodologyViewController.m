//
//  MethodologyViewController.m
//  GreenLeague
//
//  Created by Tak Tran on 25/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MethodologyViewController.h"

static NSString *kMethodologyHtmlFile = @"Methodology";

@implementation MethodologyViewController

@synthesize webView, scoreKey, activityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Methodology";
		self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Methodology" image:[UIImage imageNamed:@"179-notepad.png"] tag:1];	        
    }
    return self;
}

- (id)initWithScoreKey:(ScoreKey *)sk {
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        scoreKey = sk;
    }
    return self;    
}

- (void)dealloc
{
    [webView release];
    //[scoreKey release]; // Don't need to release?
    
    [super dealloc];    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set activity indicator
    [self.webView setDelegate:self];
    self.activityIndicator.hidesWhenStopped = YES;
    [self.activityIndicator startAnimating];
    
	NSString *methodologyFilePath = [[NSBundle mainBundle] pathForResource:kMethodologyHtmlFile ofType:@"html"];   
    
    if (scoreKey) { // Load the page with a #scorekey after the url - javascript in the html can process it
    
//        // Load  file url into webview
//        NSURL *fileUrl = [[NSURL fileURLWithPath:methodologyFilePath] URLByAppendingPathComponent:@"q5_subtotal"]; // Add /q5_subtotal
//        NSURL *fileUrl = [NSURL fileURLWithPath:methodologyFilePath];    
//
//        NSLog(@"fileUrl = %@", fileUrl);
//        [self.webView loadRequest:[NSURLRequest requestWithURL:fileUrl]];
//    
//        NSURL *fileUrl2 = [NSURL fileURLWithPath:[methodologyFilePath stringByAppendingFormat:@"#q5_subtotal"]];
//        [self.webView loadRequest:[NSURLRequest requestWithURL:fileUrl2]];
//        NSLog(@"fileUrl2 = %@, reachable? %d", fileUrl2, [fileUrl2 checkResourceIsReachableAndReturnError:nil]);

        // Load file into a string first, then load into webview as a string
        NSString *methodologyFileContents = [NSString stringWithContentsOfFile:methodologyFilePath encoding:NSUTF8StringEncoding error:nil];    
        NSString *baseUrl = [NSString stringWithFormat:@"http://greenleague.app/#%@", scoreKey.key];
        [self.webView loadHTMLString:methodologyFileContents baseURL:[NSURL URLWithString:baseUrl]];

    } else { // Just load the whole page
        
        // Load file url into webview
        NSURL *fileUrl = [NSURL fileURLWithPath:methodologyFilePath];
        NSLog(@"fileUrl for whole page: %@", fileUrl);
        [self.webView loadRequest:[NSURLRequest requestWithURL:fileUrl]];
    }

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark -
#pragma mark === Web view delegate methods ===
#pragma mark

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicator stopAnimating];
}

@end
