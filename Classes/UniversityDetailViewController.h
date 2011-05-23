//
//  UniversityDetailViewController.h
//  GreenLeague
//
//  Created by Tak Tran on 02/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "University.h"
#import "UniversitiesModel.h"

@interface UniversityDetailViewController : UIViewController {	
	UILabel *nameLabel;
	UILabel *rankLabel;
	UILabel *rankLastYearLabel;
    UIImageView *awardClassImage;
	UILabel *totalScoreLabel;
    
    University *university;
    UniversitiesModel *universitiesModel;
}

@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *rankLabel;
@property (nonatomic, retain) IBOutlet UILabel *rankLastYearLabel;
@property (nonatomic, retain) IBOutlet UIImageView *awardClassImage;
@property (nonatomic, retain) IBOutlet UILabel *totalScoreLabel;

@property (nonatomic, retain) University *university;
@property (nonatomic, retain) UniversitiesModel *universitiesModel;

- (id)initWithUniversity:(University *)uni universitiesModel:(UniversitiesModel *)unisModel;
- (IBAction)detailButtonPressed;

@end
