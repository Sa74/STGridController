//
//  GridCell.m
//  STGridController
//
//  Created by Sasi M on 10/05/13.
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
@synthesize gridIndex = _gridIndex;
@synthesize backgroundImage = _backgroundImage;
@synthesize identifier = _identifier;

#pragma mark - Init methods
// =======================================================================================================================================>>
-(id)initWithFrame:(CGRect)frame reusableIdnetifier:(NSString *)identifier {
    self = [super initWithFrame:frame];
    if (self) {
        self.identifier = identifier;
    }
    return self;
}


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

