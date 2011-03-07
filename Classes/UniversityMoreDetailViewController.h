//
//  UniversityMoreDetailViewController.h
//  GreenLeague
//
//  Created by Tak Tran on 02/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "University.h"

@interface UniversityMoreDetailViewController : UITableViewController {
	NSArray *dataSoruceArray;    
    University *university;
}

@property (nonatomic, retain) NSArray *dataSoruceArray;
@property (nonatomic, retain) University *university;    

- (id)initWithUniversity:(University *)uni;

@end
