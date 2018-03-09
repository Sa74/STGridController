//
//  GridCell.m
//  STGridController
//
//  Created by Sasi M on 10/05/13.
//  Copyright (c) 2013 Sasi M. All rights reserved.
//

#import "STGridCell.h"

@implementation GridIndex
@synthesize column, row, index, page;

#pragma mark - Grid Index init methods
// =======================================================================================================================================>>
-(id)initWithColumn:(int)column andRow:(int)row
{
    self = [super init];
    if(self)
    {
        self.column = column;
        self.row = row;
    }
    return self;
}

@end


@implementation STGridCell
@synthesize delegate = _delegate;
@synthesize identifier = _identifier;
@synthesize gridIndex = _gridIndex;
@synthesize backgroundImage = _backgroundImage;


#pragma mark - STGridCell tapGesture and delegate methods
// =======================================================================================================================================>>
-(void)addTapgesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gridSelected)];
    [tap setNumberOfTapsRequired:1];
    [tap setNumberOfTouchesRequired:1];
    [self addGestureRecognizer:tap];
}

-(void)gridSelected {
    [self.delegate gridCellTapped:self];
}

@end

