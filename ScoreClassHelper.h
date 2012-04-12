//
//  ScoreClassHelper.h
//  GreenLeague
//
//  Created by Tak Tran (Pebble Code - http://pebblecode.com)
//

#import <Foundation/Foundation.h>
#import "ScoreKey.h"
#import "UniversitiesModel.h"

@interface ScoreClassHelper : NSObject {
    
}

+ (NSNumber *)ratingImageIndexFromScore:(NSNumber *)score maxScore:(NSNumber *)maxScore;
+ (UIImage *)imageFromIndex:(NSNumber *)index;
+ (UIImage *)imageFromUniScoreKey:(ScoreKey *)scoreKey university:(University *)uni universitiesModel:(UniversitiesModel *)unisModel;

@end
