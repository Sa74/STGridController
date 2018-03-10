//
//  GridCell.h
//  STGridController
//
//  Created by Sasi M on 10/05/13.
//  Copyright (c) 2013 Sasi M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridIndex : NSObject

@property (nonatomic) int column;
@property (nonatomic) int row;
@property (nonatomic) int index;
@property (nonatomic) int page;

-(id)initWithColumn:(int)column andRow:(int)row;

@end


@protocol STGridCellDelegate;

@interface STGridCell : UIView

@property (retain, nonatomic) id <STGridCellDelegate> delegate;
@property (retain, nonatomic) GridIndex *gridIndex;

@property (retain, nonatomic) IBInspectable UIImageView *backgroundImage;
@property (retain, nonatomic) IBInspectable NSString *identifier;

-(id)initWithFrame:(CGRect)frame reusableIdnetifier:(NSString *)identifier;
-(void)addTapgesture;

@end


@protocol STGridCellDelegate <NSObject>

-(void)gridCellTapped:(STGridCell *)gridcell;

@end

