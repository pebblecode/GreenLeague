//
//  UniversityDetailViewController.h
//  GreenLeague
//
//  Created by Tak Tran on 02/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UniversityDetailViewController : UIViewController {	
	UILabel *nameLabel;
	UILabel *rank2010Label;
	UILabel *rank2009Label;
	UILabel *awardClassLabel;
	UILabel *totalScoreLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *rank2010Label;
@property (nonatomic, retain) IBOutlet UILabel *rank2009Label;
@property (nonatomic, retain) IBOutlet UILabel *awardClassLabel;
@property (nonatomic, retain) IBOutlet UILabel *totalScoreLabel;

- (id)initWithName:(NSString *)name rank2010:(NSNumber *)rank2010 rank2009:(NSNumber *)rank2009 awardClass:(NSString *)awardClass totalScore:(NSNumber *)totalScore;
- (IBAction)detailButtonPressed;

@end
