//
//  Score.m
//  GreenLeague
//
//  Created by Tak Tran (Pebble Code - http://pebblecode.com)
//

#import "Score.h"
#import "ScoreKey.h"
#import "University.h"

static NSString *kDataEntityName = @"Score";

@implementation Score

+ (NSString *)entityName {
	return [NSString stringWithString:kDataEntityName];
}


@end
