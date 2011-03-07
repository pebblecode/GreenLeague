//
//  CompareViewController.h
//  GreenLeague
//
//  Created by Tak on 24/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UniversitiesModel.h"

@interface CompareViewController : UITableViewController {
	NSMutableArray *universitiesToCompare;
	UniversitiesModel *universitiesModel;
}

@property (nonatomic, retain) NSMutableArray *universitiesToCompare;
@property (nonatomic, retain) UniversitiesModel *universitiesModel;

- (id)initWithUniversitiesModel:(UniversitiesModel *)unisModel;

- (IBAction)addButtonPress;
- (IBAction)compareButtonPress;

@end
