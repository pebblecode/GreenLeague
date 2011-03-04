//
//  CompareViewController.h
//  GreenLeague
//
//  Created by Tak on 24/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CompareViewController : UITableViewController {
	NSMutableArray *universitiesToCompare;
}

@property (nonatomic, retain) NSMutableArray *universitiesToCompare;

- (IBAction)compareButtonPress;

@end
