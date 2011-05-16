//
//  Data.m
//  GreenLeague
//
//  Created by Tak Tran on 16/05/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Data.h"
#import "University.h"

static NSString *kDataEntityName = @"Data";

@implementation Data
@dynamic value;
@dynamic university;
@dynamic criteriaKey;

+ (NSString *)entityName {
	return [NSString stringWithString:kDataEntityName];
}

@end
