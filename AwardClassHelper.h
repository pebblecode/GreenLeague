//
//  AwardClassHelper.h
//  GreenLeague
//
//  Helper file to get award class static data
//
//  Created by Tak Tran (Pebble Code - http://pebblecode.com)
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
