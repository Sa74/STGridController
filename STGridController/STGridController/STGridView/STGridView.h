//
//  GridController.h
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


/* Sasi M
 This is a custom generated view that is derived from UIScrollView which will represent list of data into 4 x 4 grid View...
 To implement this view import this class & set datasource and delegate for this GridVIew...
 To get your custom number of grids override the default values given in this class..
 */


#import <UIKit/UIKit.h>
#import "STGridCell.h"
#import "STPageIndicator.h"

/*
 Enumerator to handle card scroll direction to animate cards..
 */
typedef enum
{
    GridScrollDirectionRight,
    GridScrollDirectionLeft,
    GridScrollDirectionUp,
    GridScrollDirectionDown
}GridScrollDirection;


/*
 Delegate for Grid controller developed from Table View Controller Protocol..
 */
@protocol GridDelegate <NSObject>

-(void)selectedGrid:(STGridCell *)gridcell AtIndex:(int)index;

@end

@protocol GridDelegate;
@protocol GridDataSource;


IB_DESIGNABLE
@interface STGridView : UIScrollView <NSCoding, STGridCellDelegate, CAAnimationDelegate, UIScrollViewDelegate> {
    
@private
    int numberOfGrids;
    double totalPage;
    int fromPage;
    int toPage;
    int currentPage;
    
    GridScrollDirection scrollDirection;
    
    float scrollBeginOffset;
    CGSize priorLayoutSize;
    NSMutableDictionary *dequeueGrids;
    NSMutableDictionary *reusableGrids;
}

/*
 Properties with IBInspection option to customize default grid layout..
 */
@property (nonatomic) IBInspectable float rowSpace;
@property (nonatomic) IBInspectable float columnSpace;
@property (nonatomic) IBInspectable float gridLeading;
@property (nonatomic) IBInspectable float gridTop;
@property (nonatomic) IBInspectable float gridWidth;
@property (nonatomic) IBInspectable float gridHeight;

@property (nonatomic, weak) IBOutlet UIView *contentView;
@property (nonatomic, weak) id <GridDataSource> dataSource;
@property (nonatomic, weak) id <GridDelegate> gridDelegate;

/*
 STPageIndicator proeprty with IBOutlet connection used for page number indication
 */
@property (nonatomic, weak) IBOutlet STPageIndicator *pageIndicator;


/*
 Methods to init and handle grid controller frame deletage and datasources...
 */
-(id)initWithFrame:(CGRect)frame withDelegate:(id)gridDelegate AndDatasource:(id)gridDatasource;
-(void)reloadData;
-(void)loadData;

-(STGridCell *)gridForIndex:(int)index;
-(STGridCell *)dequeuCellWithIdentifier:(NSString *)identifier atIndex:(int)index;
-(CGRect)getFrameForCellAtGridIndex:(GridIndex *)gridIndex;
-(NSMutableArray *)getAllGrids;

-(void)loadGridsForPage:(int)Page;
-(void)dequeScrollCellAtPage:(int)Page;

-(void)removeGridsAtIndexes:(NSMutableArray *)removeIndexes;
-(void)removeGridAtIndex:(int)index;
-(void)removeGrid:(STGridCell *)grid;
-(void)removeAllGrids;

-(void)insertGridsAtIndexes:(NSMutableArray *)indexes;
-(void)insertGridAtIndex:(int)index;

@end


/*
 Data source for Grid controller developed from Table View Controller Protocol..
 */
@protocol GridDataSource <NSObject>

@required
-(NSInteger)numberOfGrids;
-(STGridCell *)gridView:(STGridView *)gridView cellForIndex:(int)index;

@end






