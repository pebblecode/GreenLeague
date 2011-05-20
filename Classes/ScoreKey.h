//
//  ScoreKey.h
//  GreenLeague
//
//  Created by Tak Tran on 19/05/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "_ScoreKey.h"

@class Score;

@interface ScoreKey : _ScoreKey {
@private
}

+ (NSString *)entityName;
+ (NSArray *)scoreKeyArrayFromKeyStringArray:(NSArray *)keyStringArray managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
+ (void)addScoreKeyToDBWithManagedContext:(NSManagedObjectContext *)managedObjectContext fromRowArray:(NSArray *)rowArray;

@end
