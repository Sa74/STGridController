//
//  STPageIndicator.m
//  STGridController
//
//  Created by Sasi M on 08/03/13.
//  Copyright (c) 2013 Sasi M. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
