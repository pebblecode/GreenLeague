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
	NSArray *dataSoruceArray;
    NSArray *policyArray;
    NSArray *performanceArray;
    
    University *university;
    UniversitiesModel *universitiesModel;
}

@property (nonatomic, retain) NSArray *dataSoruceArray;
@property (nonatomic, retain) NSArray *policyArray;
@property (nonatomic, retain) NSArray *performanceArray;

@property (nonatomic, retain) University *university;  
@property (nonatomic, retain) UniversitiesModel *universitiesModel;

- (id)initWithUniversity:(University *)uni universitiesModel:(UniversitiesModel *)unisModel;

@end
