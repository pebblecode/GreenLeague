//
//  UniversityComparisonRowViewController.h
//  GreenLeague
//
//  The view for each row of the comparison view.
//
//  Created by Tak Tran (Pebble Code - http://pebblecode.com)
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
