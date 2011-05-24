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
