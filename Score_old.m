//
//  Data.m
//  GreenLeague
//
//  Created by Tak Tran on 16/05/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Score.h"
#import "University.h"

static NSString *kDataEntityName = @"Score";

@implementation Score
@dynamic value;
@dynamic university;
@dynamic key;

+ (NSString *)entityName {
	return [NSString stringWithString:kDataEntityName];
}

@end
