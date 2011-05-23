//
//  UniversityComparisonRowViewController.h
//  GreenLeague
//
//  Created by Tak Tran on 19/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "University.h"
#import "UniversitiesModel.h"

#define kViewHeight                50.0
#define kUniLabelWidth             185.0
#define kUniLabelPadding           10.0
#define kUniLabelFullWidth         (kUniLabelWidth + (2 * kUniLabelPadding))

#define kRatingImageWidth          60.0
#define kRatingImageHeight         50.0
#define kRatingImageRightPadding   20.0
#define kRatingImageFullWidth      (kRatingImageWidth + kRatingImageRightPadding)

#define kTotalScoreLabelWidth      120.0

#define kMaxNumRatingImages        4


@interface UniversityComparisonRowViewController : UIViewController {
    
    University *university;
    UniversitiesModel *universitiesModel;
}

@property (nonatomic, retain) University *university;
@property (nonatomic, retain) UniversitiesModel *universitiesModel;

- (id)initWithUniversity:(University *)uni universitiesModel:(UniversitiesModel *)unisModel;

+ (CGFloat)widthFromUniversitiesModel:(UniversitiesModel *)unisModel;
+ (CGFloat)height;

+ (CGFloat)heightForNumberOfRows:(NSUInteger)numRows;

@end
