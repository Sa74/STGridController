//
//  STPageIndicator.h
//  STGridController
//
//  Created by Sasi M on 08/03/18.
//  Copyright (c) 2013 Sasi M. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface STPageIndicator : UIView

@property (nonatomic, weak) IBOutlet UILabel *pageDisplay;
@property (nonatomic, weak) IBOutlet UIView *indicatorHolder;

-(void)movetoPage:(double)page inTotalPage:(double)totalPage;

@end
