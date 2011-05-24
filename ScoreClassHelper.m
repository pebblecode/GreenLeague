//
//  ScoreClassHelper.m
//  GreenLeague
//
//  Created by Tak Tran on 24/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScoreClassHelper.h"
#import "NSString+Helper.h"
#import "Score.h"

#define kMaxNumRatingImages 4

@implementation ScoreClassHelper


// Find the rating based on the number of rating images there are.
// Eg, if there are 4, then the ratings are 0-25%, 25-50%, 50-75% and 75-100% 
+ (NSNumber *)ratingImageIndexFromScore:(NSNumber *)score maxScore:(NSNumber *)maxScore {
    
    float scorePercentage = [score floatValue] / [maxScore floatValue];
    NSNumber *ratingImageIndex = [NSNumber numberWithFloat:round(scorePercentage * (kMaxNumRatingImages - 1))];
    
    return ratingImageIndex;
}

// Get the image for a given index value
// 0 = awful
// 1 = poor
// 2 = ok
// 3 = excellent
+ (UIImage *)imageFromIndex:(NSNumber *)index {
    UIImage *image = nil;
    
    switch ([index intValue]) {
        case 0:
            image = [UIImage imageNamed:@"star_awful.png"];
            break;
        case 1:
            image = [UIImage imageNamed:@"star_poor.png"];
            break;            
        case 2:
            image = [UIImage imageNamed:@"star_ok.png"];
            break; 
        case 3:
            image = [UIImage imageNamed:@"star_excellent.png"];
            break;             
            
        default:
            break;
    }
    
    return image;
}

+ (UIImage *)imageFromUniScoreKey:(ScoreKey *)scoreKey university:(University *)uni universitiesModel:(UniversitiesModel *)unisModel {
    
    Score *uniScore = [unisModel findScoreForUniversity:uni scoreKey:scoreKey];
    
    NSNumber *ratingImageIndex = [self ratingImageIndexFromScore:[uniScore.value numberFromString] maxScore:scoreKey.maxScore];
    //    NSLog(@"uniScore: %@/%d", uniScore.value, [scoreKey.maxScore intValue]);
    
    return [self imageFromIndex:ratingImageIndex];
    
}

@end
