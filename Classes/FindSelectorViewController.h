
//  FindSelectorViewController.h
//  GreenLeague
//
//  A subclass of FindViewController, that allows the selection of
//  universities
//
//  Created by Tak Tran on 08/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindViewController.h"

@interface FindSelectorViewController : FindViewController {
    NSMutableSet *selectedUniversities;
}

@property (nonatomic, retain) NSMutableSet *selectedUniversities;

- (id)initWithUniversitiesModel:(UniversitiesModel *)unisModel selectedUniversities:(NSArray *)selectedUnis;
- (void)doneButtonPressed;

- (void)clearSelectedUniversities;

@end
