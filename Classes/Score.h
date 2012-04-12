//
//  Score.h
//  GreenLeague
//
//  Created by Tak Tran (Pebble Code - http://pebblecode.com)
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
