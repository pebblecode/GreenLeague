//
//  Score.h
//  GreenLeague
//
//  Created by Tak Tran on 19/05/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ScoreKey, University;

@interface Score : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) University * university;
@property (nonatomic, retain) ScoreKey * key;

+ (NSString *)entityName;

@end
