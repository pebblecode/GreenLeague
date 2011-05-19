//
//  ScoreKey.h
//  GreenLeague
//
//  Created by Tak Tran on 16/05/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Score;

@interface ScoreKey : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString* text;
@property (nonatomic, retain) NSString* key;
@property (nonatomic, retain) NSSet* score;

+ (NSString *)entityName;
+ (NSArray *)scoreKeyArrayFromKeyStringArray:(NSArray *)keyStringArray managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
+ (void)addScoreKeyToDBWithManagedContext:(NSManagedObjectContext *)managedObjectContext fromRowArray:(NSArray *)rowArray;

@end
