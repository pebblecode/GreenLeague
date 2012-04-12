//
//  UIApplication+Helper.m
//  GreenLeague
//
//  Created by Tak Tran (Pebble Code - http://pebblecode.com)
//

#import "UIApplication+Helper.h"


@implementation UIApplication(Helper)

+ (void)openInApplicationWithURL:(NSString *)urlAddress {
	NSURL *url = [NSURL URLWithString:urlAddress];		
	[[UIApplication sharedApplication] openURL:url];    
}

@end
