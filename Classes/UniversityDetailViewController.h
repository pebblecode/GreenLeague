//
//  UniversityDetailViewController.h
//  GreenLeague
//
//  Created by Tak Tran on 02/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "University.h"

@interface UniversityDetailViewController : UIViewController {	
	UILabel *nameLabel;
	UILabel *rankLabel;
	UILabel *rankLastYearLabel;
	UILabel *awardClassLabel;
	UILabel *totalScoreLabel;
    
    University *university;
}

@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *rankLabel;
@property (nonatomic, retain) IBOutlet UILabel *rankLastYearLabel;
@property (nonatomic, retain) IBOutlet UILabel *awardClassLabel;
@property (nonatomic, retain) IBOutlet UILabel *totalScoreLabel;

@property (nonatomic, retain) University *university;

- (id)initWithUniversity:(University *)uni;
- (IBAction)detailButtonPressed;

@end
