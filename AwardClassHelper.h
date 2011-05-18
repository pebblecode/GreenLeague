//
//  AwardClassHelper.h
//  GreenLeague
//
//  Helper file to get award class static data
//
//  Created by Tak on 3/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AwardClassHelper : NSObject {
	
}

+ (NSArray *)awardClassDBNames;
+ (NSArray *)awardClassIndexTitles;
+ (NSArray *)awardClassNames;
+ (NSArray *)awardClassBadges;
+ (NSArray *)awardClassColours;

+ (UIImage *)badgeImageForAwardClassDBName:(NSString *)awardClassDBName;
+ (UIColor *)backgroundColourForAwardClassDBName:(NSString *)awardClassDBName;
+ (UIColor *)textColourForAwardClassDBName:(NSString *)awardClass;

@end
