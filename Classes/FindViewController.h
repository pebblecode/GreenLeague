//
//  FindViewController.h
//  GreenLeague
//
//  Loads the data from the univerities model and shows it in a table. The
//  sortControl also allows the listing to be sorted by either alphabetical
//  order or ranking.
//
//  Created by Tak Tran (Pebble Code - http://pebblecode.com)
//

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "UniversitiesModel.h"
#import "University.h"

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
