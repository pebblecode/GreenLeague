//
//  UniversityComparisonView.m
//  GreenLeague
//
//  Created by Tak Tran on 09/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UniversityComparisonView.h"

#define kWidth 1250.0
#define kHeight 50.0

@implementation UniversityComparisonView

@synthesize university;
@synthesize containerView, universityNameLabel, totalScoreLabel, policy1ResultImage, policy2ResultImage, policy3ResultImage, policy4ResultImage, policy5ResultImage, policy6ResultImage, policy7ResultImage, performance8ResultImage, performance9ResultImage, performance10ResultImage, performance11ResultImage;




- (id)initWithUniversity:(University *)uni {
    CGRect frame = CGRectMake(0, 0, [UniversityComparisonView width], [UniversityComparisonView height]);
    self = [super initWithFrame:frame];
    if (self) {
        self.university = [uni retain];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [universityNameLabel release];
    [totalScoreLabel release];
    
    [policy1ResultImage release];
    [policy2ResultImage release];
    [policy3ResultImage release];
    [policy4ResultImage release];
    [policy5ResultImage release];
    [policy6ResultImage release];
    [policy7ResultImage release];
    
    [performance8ResultImage release];
    [performance9ResultImage release];
    [performance10ResultImage release];
    [performance11ResultImage release];
    
    [university release];
    
    [super dealloc];
}

#pragma mark -
#pragma mark === Dimensions ===
#pragma mark

+ (CGFloat)width {
    return kWidth;
}

+ (CGFloat)height {
    return kHeight;
}

@end
