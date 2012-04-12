//
//  UniversityDetailViewController.h
//  GreenLeague
//
//  Details for the university selected
//
//  Created by Tak Tran (Pebble Code - http://pebblecode.com)
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
