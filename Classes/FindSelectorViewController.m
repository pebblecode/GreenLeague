//
//  FindSelectorViewController.m
//  GreenLeague
//
//  Created by Tak Tran on 08/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FindSelectorViewController.h"
#import "UIColor+Helper.h"

@implementation FindSelectorViewController

@synthesize selectedUniversities;

- (id)initWithUniversitiesModel:(UniversitiesModel *)unisModel selectedUniversities:(NSArray *)selectedUnis {
    if ((self = [self initWithUniversitiesModel:unisModel])) {
        selectedUniversities = [[NSMutableSet alloc] initWithArray:selectedUnis];
    }
    return self;
}

- (void)dealloc {
    [selectedUniversities release];
    
    [super dealloc];
}

#pragma mark -
#pragma mark === View lifecycle ===
#pragma mark

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Select";

    
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed)];
	self.navigationItem.rightBarButtonItem = doneButton;
	[doneButton release];
}

#pragma mark -
#pragma mark === Getters/Setters ===
#pragma mark

- (NSMutableSet *)selectedUniversities {
    if (!selectedUniversities) {
        selectedUniversities = [[NSMutableSet alloc] initWithCapacity:0];
    }
    return selectedUniversities;
}

#pragma mark -
#pragma mark === Table view data source ===
#pragma mark

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	University *uni = [self universityFromIndexPath:indexPath];
	
	// Text: Rank. University
	NSString *rankString = ([[uni rank2010] intValue] == 0) ? @"(none) " : [NSString stringWithFormat:@"%@. ", uni.rank2010];
	cell.textLabel.text = [NSString stringWithFormat:@"%@%@", rankString, uni.sortName];    
    	
    return cell;
}

// Note that colour must be changed in this method rather than tableView:cellForRowAtIndexPath:
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[super tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    
    // Override colours for selected universities
    University *uni = [self universityFromIndexPath:indexPath];
    
    // Invert colours - show white if unselected, and uni colours if selected
    if ([self.selectedUniversities containsObject:uni]) {
        cell.textLabel.textColor = [uni awardClassTextColour];
        cell.backgroundColor = [uni awardClassBackgroundColour];
    } else {
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#cccccc"];
        cell.backgroundColor = [UIColor whiteColor];
    }    
}

#pragma mark -
#pragma mark === Table view delegate ===
#pragma mark

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	University *uni = [self universityFromIndexPath:indexPath];
    
	if ([uni isValidAwardClass]) {
        // Toggle whether uni is selected or not
        if ([self.selectedUniversities containsObject:uni]) {
            [self.selectedUniversities removeObject:uni];
        } else {
            [self.selectedUniversities addObject:uni];        
        }
		
	} else {
		NSLog(@"Could not find award class for '%@' of award class '%@'", [uni name], [uni awardClass]);
	}
	
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];  
   

}

#pragma mark -
#pragma mark === Buttons ===
#pragma mark


- (void)doneButtonPressed {
    // Send a retained object
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectedUniversitiesSet" object:self.selectedUniversities];
    
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

@end
