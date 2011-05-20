//
//  Score.m
//  GreenLeague
//
//  Created by Tak Tran on 19/05/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
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
