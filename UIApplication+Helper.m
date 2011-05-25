//
//  UIApplication+Helper.m
//  GreenLeague
//
//  Created by Tak Tran on 25/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIApplication+Helper.h"


@implementation UIApplication(Helper)

+ (void)openInApplicationWithURL:(NSString *)urlAddress {
	NSURL *url = [NSURL URLWithString:urlAddress];		
	[[UIApplication sharedApplication] openURL:url];    
}

@end
