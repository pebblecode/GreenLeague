//
//  Score.h
//  GreenLeague
//
//  Created by Tak Tran on 19/05/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "_Score.h"

@class ScoreKey, University;

@interface Score : _Score {
@private
}

+ (NSString *)entityName;

@end
