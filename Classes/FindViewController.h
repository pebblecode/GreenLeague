//
//  FindViewController.h
//  GreenLeague
//
//  Created by Tak Tran on 23/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "UniversitiesModel.h"


@interface FindViewController : UITableViewController {
	UniversitiesModel *universitiesModel;	
	UISegmentedControl *sortControl;
    UITableView *universitiesTableView;
	
	int universitySortIndex;
}

@property (nonatomic, retain) UniversitiesModel *universitiesModel;
@property (nonatomic, retain) UISegmentedControl *sortControl;
@property (nonatomic, retain) IBOutlet UITableView *universitiesTableView;


- (id)initWithUniversitiesModel:(UniversitiesModel *)unisModel;
- (University *)universityFromIndexPath:(NSIndexPath *)indexPath;

- (Boolean)isRankSort;
- (Boolean)isNameSort;

@end
