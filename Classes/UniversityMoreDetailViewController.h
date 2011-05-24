//
//  UniversityMoreDetailViewController.h
//  GreenLeague
//
//  Created by Tak Tran on 02/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
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
