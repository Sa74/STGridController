//
//  STPageIndicator.m
//  STGridController
//
//  Created by Sasi M on 08/03/18.
//  Copyright (c) 2013 Sasi M. All rights reserved.
//

#import "STPageIndicator.h"


@implementation STPageIndicator


#pragma mark - Page indicator update method
// =======================================================================================================================================>>

-(void)movetoPage:(double)page inTotalPage:(double)totalPage {

    UIView *pageFillerView = [self.indicatorHolder viewWithTag:100];
    if (!pageFillerView) {
        pageFillerView = [[UIView alloc] initWithFrame:(CGRect){CGPointZero, 0, self.indicatorHolder.frame.size.height}];
        pageFillerView.backgroundColor = self.indicatorHolder.backgroundColor;
        pageFillerView.tag = 100;
        [self.indicatorHolder addSubview:pageFillerView];
        
        self.indicatorHolder.layer.cornerRadius = self.indicatorHolder.frame.size.height / 2.0;
        self.indicatorHolder.layer.borderColor = self.indicatorHolder.backgroundColor.CGColor;
        self.indicatorHolder.layer.borderWidth = 1.0;
        self.indicatorHolder.clipsToBounds = YES;
        self.indicatorHolder.backgroundColor = [UIColor clearColor];
        
        self.backgroundColor = [UIColor clearColor];
    }
    
    [self.pageDisplay setText:[NSString stringWithFormat:@"%d/%d",(int)page, (int)totalPage]];
    
    double filledWidth = (self.indicatorHolder.frame.size.width * (page / totalPage));
    [UIView animateWithDuration:0.5 animations:^{
        pageFillerView.frame = (CGRect) {CGPointZero, filledWidth, self.indicatorHolder.frame.size.height};
        [self setNeedsDisplay];
    }];
    
}

@end
