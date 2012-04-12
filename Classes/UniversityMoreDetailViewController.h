//
//  UniversityMoreDetailViewController.h
//  GreenLeague
//
//  Show details of the methodology for the criteria selected. Uses the
//  MethodologyViewController to show it.
//
//  Created by Tak Tran (Pebble Code - http://pebblecode.com)
//

#import <UIKit/UIKit.h>
#import "University.h"
#import "UniversitiesModel.h"

@interface UniversityMoreDetailViewController : UITableViewController {
	NSArray *dataSourceArray;
    NSArray *policyArray;
    NSArray *performanceArray;
    
    University *university;
    UniversitiesModel *universitiesModel;
    
    UITableView *detailTableView;
}

@property (nonatomic, retain) NSArray *dataSourceArray;
@property (nonatomic, retain) NSArray *policyArray;
@property (nonatomic, retain) NSArray *performanceArray;

@property (nonatomic, retain) University *university;
@property (nonatomic, retain) UniversitiesModel *universitiesModel;

@property (nonatomic, retain) IBOutlet UITableView *detailTableView;

- (id)initWithUniversity:(University *)uni universitiesModel:(UniversitiesModel *)unisModel;

@end
