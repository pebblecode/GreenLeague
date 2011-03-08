//
//  FindSelectorViewController.m
//  GreenLeague
//
//  Created by Tak Tran on 08/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FindSelectorViewController.h"


@implementation FindSelectorViewController

@synthesize selectedUniversities;


- (void)dealloc {
    [selectedUniversities release];
    
    [super dealloc];
}

#pragma mark -
#pragma mark === View lifecycle ===
#pragma mark

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Universities";
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

#pragma mark -
#pragma mark === Table view delegate ===
#pragma mark

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	University *uni = [self universityFromIndexPath:indexPath];
    
	if ([uni isValidAwardClass]) {
		[self.selectedUniversities addObject:uni];
	} else {
		NSLog(@"Could not find award class for '%@' of award class '%@'", [uni name], [uni awardClass]);
	}
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
