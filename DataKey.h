//
//  DataKey.h
//  GreenLeague
//
//  Created by Tak Tran on 16/05/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Data, MetaData;

@interface DataKey : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) Data * data;

+ (NSString *)entityName;
+ (NSArray *)dataKeyArrayFromKeyStringArray:(NSArray *)keyStringArray managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
+ (void)addDataKeyToDBWithManagedContext:(NSManagedObjectContext *)managedObjectContext fromRowArray:(NSArray *)rowArray;

@end
