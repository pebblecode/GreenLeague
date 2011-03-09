//
//  UniversityComparisonViewController.h
//  GreenLeague
//
//  Created by Tak Tran on 09/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "University.h"

@interface UniversityComparisonViewController : UIViewController {
    University *university;
    
    UIView *containerView;
    UILabel *universityNameLabel;
    UILabel *totalScoreLabel;
    
    UIImageView *policy1ResultImage;
    UIImageView *policy2ResultImage;
    UIImageView *policy3ResultImage;
    UIImageView *policy4ResultImage;
    UIImageView *policy5ResultImage;
    UIImageView *policy6ResultImage;
    UIImageView *policy7ResultImage;
    
    UIImageView *performance8ResultImage;
    UIImageView *performance9ResultImage;
    UIImageView *performance10ResultImage;
    UIImageView *performance11ResultImage;
    
}

@property (nonatomic, retain) University *university;

@property (nonatomic, retain) IBOutlet UIView *containerView;
@property (nonatomic, retain) IBOutlet UILabel *universityNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *totalScoreLabel;

@property (nonatomic, retain) IBOutlet UIImageView *policy1ResultImage;
@property (nonatomic, retain) IBOutlet UIImageView *policy2ResultImage;
@property (nonatomic, retain) IBOutlet UIImageView *policy3ResultImage;
@property (nonatomic, retain) IBOutlet UIImageView *policy4ResultImage;
@property (nonatomic, retain) IBOutlet UIImageView *policy5ResultImage;
@property (nonatomic, retain) IBOutlet UIImageView *policy6ResultImage;
@property (nonatomic, retain) IBOutlet UIImageView *policy7ResultImage;

@property (nonatomic, retain) IBOutlet UIImageView *performance8ResultImage;
@property (nonatomic, retain) IBOutlet UIImageView *performance9ResultImage;
@property (nonatomic, retain) IBOutlet UIImageView *performance10ResultImage;
@property (nonatomic, retain) IBOutlet UIImageView *performance11ResultImage;

+ (CGFloat)width;
+ (CGFloat)height;

- (id)initWithUniversity:(University *)uni;

@end
