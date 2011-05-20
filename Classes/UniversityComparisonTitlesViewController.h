//
//  UniversityComparisonTitlesViewController.h
//  GreenLeague
//
//  Created by Tak Tran on 09/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UniversitiesModel.h"

@interface UniversityComparisonTitlesViewController : UIViewController {
    
    UniversitiesModel *universitiesModel;    
}

@property (nonatomic, retain) UniversitiesModel *universitiesModel;

- (id)initWithUniversitiesModel:(UniversitiesModel *)unisModel;

@end
