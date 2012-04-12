//
//  UniversityComparisonTitlesViewController.h
//  GreenLeague
//
//  The header row titles for the comparison view
//
//  Created by Tak Tran (Pebble Code - http://pebblecode.com)
//

#import <UIKit/UIKit.h>
#import "UniversitiesModel.h"

@interface UniversityComparisonTitlesViewController : UIViewController {
    
    UniversitiesModel *universitiesModel;    
}

@property (nonatomic, retain) UniversitiesModel *universitiesModel;

- (id)initWithUniversitiesModel:(UniversitiesModel *)unisModel;

@end
