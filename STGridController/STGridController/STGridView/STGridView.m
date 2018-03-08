//
//  GridController.m
//  STGridController
//
//  Created by Sasi M on 10/05/13.
//  Copyright (c) 2013 Sasi M. All rights reserved.
//

#import "STGridView.h"
#import <QuartzCore/QuartzCore.h>

/*
 Pre defined values for custom Grid Controller...
 It will provide 4 x 4 cards for Landscape & 3 x 4 cards for portrait...
 These values can be over written to get custom grid layout...
 */
static NSInteger row_Portrait = 4;
static NSInteger col_Portrait = 3;

static NSInteger row_Landscape = 3;
static NSInteger col_Landscape = 4;

static const NSInteger strtPos_Portrait = 57;
static const NSInteger topSpace_Portrait = 30;
static NSInteger rowSpace_Portrait = 41;
static NSInteger colSpace_Portrait = 43;

static const NSInteger strtPos_Landscape = 57;
static const NSInteger topSpace_Landscape = 30;
static NSInteger rowSpace_Landscape = 41;
static NSInteger colSpace_Landscape = 43;

#define IS_Port(orientation) (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
#define IS_Landscape(orientation) (orientation == UIDeviceOrientationLandscapeRight || orientation == UIDeviceOrientationLandscapeLeft)


#pragma mark - STGridView implementation starts here
// =======================================================================================================================================>>

@implementation STGridView
@synthesize dataSource = _dataSource;
@synthesize gridDelegate = _gridDelegate;


#pragma mark - STGridView init methods
// =======================================================================================================================================>>
/*
 To init grid controller should provide delegate and datasource...
 Without data source grid controller will not work as expected...
 */
-(id)initWithFrame:(CGRect)frame withDelegate:(id)gridDelegate AndDatasource:(id)gridDatasource;
{
    self = [super init];
    if(self)
    {
        self.gridDelegate = gridDelegate;
        self.dataSource = gridDatasource;
        self.frame = frame;
        reusableGrids = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void) setGridDelegate:(id<UIScrollViewDelegate>)delegate {
    super.delegate = self;
}



#pragma mark - inital frame values configuration
// =======================================================================================================================================>>
/*
 Implement the following methods to set new values to get custom grid layout as expected...
 */
-(void)setNumberOfColumns:(int)_columns
{
    col_Portrait = _columns;
    col_Landscape = _columns;
    columns = _columns;
}

-(void)setNumberOfRows:(int)_rows
{
    row_Landscape = _rows;
    row_Landscape = _rows;
    rows = _rows;
}

-(void)setRowSpace:(int)_rowspace
{
    rowSpace_Landscape = _rowspace;
    rowSpace_Portrait = _rowspace;
    rowSpace = _rowspace;
}

-(void)setColumnSpace:(int)_columnspace
{
    colSpace_Landscape = _columnspace;
    colSpace_Portrait = _columnspace;
    colSpace = _columnspace;
}



#pragma mark - getter methods
// =======================================================================================================================================>>
/*
 This method will return array of all grids..
 */
-(NSMutableArray *)getAllGrids {
    return reusableGrids.allValues.mutableCopy;
}

/*
 To return card at specific index...
 */
-(STGridCell *)cellForIndex:(int)index {
    return (STGridCell *)[reusableGrids objectForKey:@(index+1)];
}

/*
 To get grid scroller frame based on orientation change..
 */
-(void)getFrames
{
    rows = (int)row_Landscape;
    columns = (int)col_Landscape;
    rowSpace = (int)rowSpace_Landscape;
    colSpace = (int)colSpace_Landscape;
    strtPos = strtPos_Landscape;
    topSpace = topSpace_Landscape;
    
    if(IS_Port([[UIApplication sharedApplication] statusBarOrientation])) {
        rows = (int)row_Portrait;
        columns = (int)col_Portrait;
        rowSpace = (int)rowSpace_Portrait;
        colSpace = (int)colSpace_Portrait;
        strtPos = strtPos_Portrait;
        topSpace = topSpace_Portrait;
    }
    
    if (!reusableGrids) {
        reusableGrids = [NSMutableDictionary dictionary];
    }
    
    numberOfGrid = (int)[self.dataSource numberOfGrids];
    totalPage =  (numberOfGrid % (columns * rows) != 0) ? ((numberOfGrid / (columns * rows)) + 1) : (numberOfGrid / (columns * rows));
    
    self.contentSize = (CGSize) {totalPage * self.frame.size.width, self.frame.size.height};
    self.pagingEnabled = YES;
    
    CGFloat pageWidth = self.frame.size.width;
    currentPage = floor((self.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    if(totalPage > 1) {
        self.pageIndicator.hidden = NO;
        [self refreshPageIncrementor];
    } else {
        self.pageIndicator.hidden = YES;
    }
}



#pragma mark - inital data load methods
// =======================================================================================================================================>>
/*
 Inital grid load method..
 */
-(void)loadData
{
    if (!reusableGrids) {
        reusableGrids = [NSMutableDictionary dictionary];
    }
    
    self.backgroundColor = [UIColor grayColor];
    [self getFrames];
    
    cell = [self.dataSource gridView:self cellForIndex:0];
    if(!cell) {
        cell = [[STGridCell alloc] init];
    }
    
    currentPage = 0;
    [self loadGrid];
}

/*
 To load grids from initial page 0...
 */
-(void)loadGrid
{
    fromPage = 0;
    toPage = 2;
    
    for(int i = fromPage; i <= toPage; i++) {
        [self loadGridsForPage:i];
    }
    [self bringSubviewToFront:self];
}


/*
 To load grids for each page based on scroller movement...
 */
-(void)loadGridsForPage:(int)Page
{
    if(Page >= 0 && Page <= totalPage)
    {
        for(int i= (Page * columns * rows); i < ((Page * columns * rows) + (columns * rows)); i++)
        {
            if(i < numberOfGrid && i >=0) {
                STGridCell *gridCell = [self cellForIndex:i];
                if(!gridCell) {
                    [self createGridAtIndex:i];
                } else {
                    gridCell.gridIndex = [self gridIndexForIndex:i];
                    gridCell.frame = [self getFrameForCell:gridCell atGridIndex:gridCell.gridIndex];
                    [reusableGrids setObject:gridCell forKey:@(i+1)];
                }
            }
        }
    }
}


#pragma mark - page indicator update methods
// =======================================================================================================================================>>
/*
 To update the page bar based on scroller movement...
 */
-(void)refreshPageIncrementor {
    if (!self.pageIndicator) {
        return;
    }
    [self.pageIndicator setAlpha:0.0f];    
    [UIView animateWithDuration:0.5 animations:^(void) {
        self.pageIndicator.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [self.pageIndicator movetoPage:currentPage+1 inTotalPage:totalPage];
    }];
}



#pragma mark - grid reload method
// =======================================================================================================================================>>
/*
 To reload grids for data change and orientation change...
 */
-(void)reloadData {
    
    [self getFrames];
    
    NSArray *allGridCells = reusableGrids.allValues;
    
    for(STGridCell *grid in allGridCells) {
        grid.gridIndex = [self gridIndexForIndex:grid.gridIndex.index];
        grid.frame = [self getFrameForCell:grid atGridIndex:grid.gridIndex];
    }
    
    fromPage = (currentPage-1 >= 0) ? (currentPage-1) : 0;
    if (fromPage > 0) {
        fromPage--;
    }
    toPage = currentPage + 2;
    
    for(int i = fromPage; i <= toPage; i++) {
        [self loadGridsForPage:i];
    }
    
    [self setContentOffset:CGPointMake((currentPage * self.frame.size.width), 0) animated:YES];
    [self refreshPageIncrementor];
}



/*
 To get grids frame based on orientation change and page movement...
 Which will be calculated based on gridIndex...
 */
-(CGRect)getFrameForCell:(STGridCell *)gridcell atGridIndex:(GridIndex *)gridIndex
{
    int page = gridIndex.page;
    int cellColoumn = gridIndex.column % columns;
    int cellRow = gridIndex.row;
    
    float x = (self.frame.size.width * page) + strtPos + (cellColoumn * gridcell.frame.size.width ) + (cellColoumn * colSpace);
    float y = (cellRow * gridcell.frame.size.height ) + (cellRow * rowSpace) + topSpace;
    
    return (CGRect){x, y, gridcell.frame.size};
}




#pragma mark - GridCell delegate method and GridView delegate execution
// =======================================================================================================================================>>
/*
 To inititate selection for Grids...
 */
-(void)gridCellTapped:(STGridCell *)gridcell {
    [self.gridDelegate selectedGrid:gridcell AtIndex:gridcell.gridIndex.index];
}



#pragma mark - Deque/Reset and dealloc GridCell methods
// =======================================================================================================================================>>
/*
 To deallocate reusable grids...
 */
-(void)dequeScrollCellAtPage:(int)Page
{
    if(Page >= 0 && Page <= totalPage)
    {
        for(int i= (Page * columns * rows); i < ((Page * columns * rows) + (columns*rows)); i++)
        {
            STGridCell *deque = [self cellForIndex:i];
            [reusableGrids removeObjectForKey:@(i+1)];
            [deque removeFromSuperview];
            deque.gridIndex = nil;
            deque = nil;
        }
    }
}

/*
 To reset cards after removing detail view...
 */
-(void)resetCardsInPage:(int)page
{
    for(int i = (page * columns); i < (page*columns) + columns; i++) {
        int index = (i >= columns) ?  ((page * rows * columns) + (i % columns)) : i;
        
        for(int j= (i * rows); j < ((i * rows) + rows); j++) {
            STGridCell *grid = [self cellForIndex:index];
            if (grid) {
                CGRect frame = [self getFrameForCell:grid atGridIndex:grid.gridIndex];
                [UIView animateWithDuration:0.5 animations:^(void) {
                    grid.frame = frame;
                }];
                index += columns;
            }
        }
    }
}



/*
 To dealloc grid and release grid memory...
 */
-(void)deallocCell:(STGridCell *)gridCell {
    [reusableGrids removeObjectForKey:@(gridCell.gridIndex.index+1)];
    [gridCell removeFromSuperview];
    gridCell = nil;
}


#pragma Grid Controller Data Source...
// =======================================================================================================================================>>
/*
 To insert new girds...
 Can insert single card and array of cards based on Grid Controller Data Source...
 Cards will be animated based on cards visiblity by calculting the cards frame and Scroller content offset...
 Remaing cards will be replaced simply without animation in Background...
 */
-(void)insertGridsAtIndexes:(NSMutableArray *)indexes
{
    [self getFrames];
    for(int i=0; i < [indexes count]; i++)
    {
        if([self isVisible:[indexes[i] intValue]])
        {
            STGridCell *gridcell = [self createGridAtIndex:[indexes[i] intValue] alpha:0];
            [reusableGrids setObject:gridcell forKey:@(0)];
            [self showGrid:gridcell AfterCompleted:^(void) {
                [reusableGrids setObject:gridcell forKey:@(gridcell.gridIndex.index+1)];
                [reusableGrids removeObjectForKey:@(0)];
             }];
        }
    }
    fromPage = currentPage - 2;
    toPage = currentPage + 2;
}

-(void)insertGridAtIndex:(int)index
{
    [self getFrames];
    [self moveGridsFromIndex:index];
    if([self isVisible:index])
    {
        STGridCell *gridcell = [self createGridAtIndex:index alpha:0];
        [self showGrid:gridcell AfterCompleted:^(void) {
            [reusableGrids setObject:gridcell forKey:@(index+1)];
         }];
    }
}

/*
 To icheck cards visiblity based on cards frame and scrolers currentPage...
 */
-(BOOL)isVisible:(int)index
{
    int page = (index / (columns * rows));
    return (page >= currentPage-2 && page <= currentPage+2);
}


#pragma mark - GridView search implementation and card layout update methods
// =======================================================================================================================================>>
/*
 To move cards from one postion to another position based on data change on new card insertion or
 existing card deletion...
 Similar to insertion visible cards will be animated where as remaining cards will be replaced in background..
 */
-(void)moveGridsAtIndexes:(NSMutableArray *)indexes toIndexes:(NSMutableArray *)moveIndexes
{
    [self getFrames];
    for(int i = 0; i < [indexes count]; i++)
    {
        [self moveGridAtIndex:[[indexes objectAtIndex:i] intValue] toIndex:[[moveIndexes objectAtIndex:i] intValue]];
    }
}

-(void)moveGridsFromIndex:(int)index
{
    int EndIndex = (numberOfGrid < ( (currentPage + 2) * columns * rows) ) ? (numberOfGrid - 1) : ( ((currentPage + 2) * columns * rows) - 1 );
    for(int i = index; i < EndIndex; i++)
    {
        [self moveGridAtIndex:i toIndex:i+1];
    }
}

-(void)moveGridAtIndex:(int)index toIndex:(int)moveIndex
{
    STGridCell *grid = (STGridCell *)[reusableGrids objectForKey:@(index+1)];
    
    if(!grid && [self isVisible:moveIndex])
    {
        grid = [self createGridAtIndex:moveIndex];
        if(grid.gridIndex.page == currentPage) {
            CGRect frame = grid.frame;
            grid.frame = (CGRect){frame.origin.x + self.frame.size.width, frame.origin.y, frame.size};
        }
    }
    
    if(grid)
    {
        GridIndex *newGridIndex = [self gridIndexForIndex:moveIndex];
        if(grid.gridIndex.page == currentPage || newGridIndex.page == currentPage)
        {
            [grid setGridIndex:newGridIndex];
            [self moveGrid:grid AfterCompleted:^(void) {
                [reusableGrids setObject:grid forKey:@(moveIndex+1)];
                [self bringSubviewToFront:grid];
             }];
        }
        else
        {
            [grid setGridIndex:newGridIndex];
            [grid setFrame:[self getFrameForCell:grid atGridIndex:newGridIndex]];
            [reusableGrids setObject:grid forKey:@(moveIndex+1)];
            [self bringSubviewToFront:grid];
        }
    }
}



#pragma mark - GridCell creation and data source execution methods
// =======================================================================================================================================>>
/*
 To get New card for each index from Grid Controller Data Source..
 */
-(STGridCell *)createGridAtIndex:(int)index {
    return [self createGridAtIndex:index alpha:1.0f];
}

-(STGridCell *)createGridAtIndex:(int)index alpha:(CGFloat)alpha
{
    STGridCell *grid = [self.dataSource gridView:self cellForIndex:index];
    grid.gridIndex = [self gridIndexForIndex:index];
    grid.frame = [self getFrameForCell:grid atGridIndex:grid.gridIndex];
    grid.alpha = alpha;
    grid.delegate = self;
    [grid addTapgesture];
    [self addSubview:grid];
    [self bringSubviewToFront:grid];
    [reusableGrids setObject:grid forKey:@(index+1)];
    return grid;
}



#pragma mark - GridCell delete and remove methods
// =======================================================================================================================================>>
/*
 To remove existing grids from Grid Controller..
 Single card or array of cards can be removed simultaneously...
 Based on which remaing cards will be alligned.. Similar to insert and move, visible cards will be animated..
 Remainig cards will be removed immediatly in background...
 */
-(void)removeGridsAtIndexes:(NSMutableArray *)indexes
{
    for(int i=0; i < [indexes count]; i++)
    {
        STGridCell *gridCell = (STGridCell *)[reusableGrids objectForKey:@([indexes[i] intValue]+1)];
        if(gridCell)
        {
            if(gridCell.gridIndex.page == currentPage)
            {
                [self hideGrid:gridCell AfterCompleted:^(void)
                 {
                     [gridCell setHidden:YES];
                     [self deallocCell:gridCell];
                 }];
            }
            else
            {
                [self deallocCell:gridCell];
            }
        }
    }
}

-(void)removeGridAtIndex:(int)index
{
    STGridCell *gridCell = (STGridCell *)[reusableGrids objectForKey:@(index+1)];
    [self removeGrid:gridCell];
}


-(void)removeGrid:(STGridCell *)grid
{
    [self updateCardsFromIndex:grid.gridIndex.index];
    [self hideGrid:grid AfterCompleted:^(void) {
         [self deallocCell:grid];
     }];
}

/*
 To remove all grids from Grid controller...
 */
-(void)removeAllGrids
{
    for(UIView *subView in [self subviews])
    {
        if([subView isKindOfClass:[STGridCell class]])
        {
            STGridCell *grid = (STGridCell *)subView;
            if(grid.gridIndex.page == currentPage)
            {
                [self hideGrid:grid AfterCompleted:^(void)
                 {
                     [grid removeFromSuperview];
                     [self deallocCell:grid];
                 }];
            }
            else
            {
                [grid removeFromSuperview];
                [self deallocCell:grid];
            }
        }
    }
    [reusableGrids removeAllObjects];
}

/*
 Move animation for existing card to new position...
 */
-(void)moveGrid:(STGridCell *)grid AfterCompleted:(void (^)(void))completion
{
    CGRect frame = [self getFrameForCell:grid atGridIndex:grid.gridIndex];
    
    [UIView animateWithDuration:0.6 animations:^(void) {
        grid.alpha = 1.0f;
        grid.frame = (grid.gridIndex.page == currentPage) ? frame : (CGRect){grid.frame.origin.x + self.frame.size.width, frame.origin.y, frame.size};
    }  completion:^(BOOL finished) {
        grid.frame = frame;
        if(completion)
            completion();
    }];
}


/*
 Hide animation fro existing card...
 After animation completion block will be executed.. Wchich can be used to release card memory and set new frame to card...
 */
-(void)hideGrid:(STGridCell *)grid AfterCompleted:(void (^)(void))completion
{
    [UIView animateWithDuration:0.3 animations:^(void)
     {
         [grid setAlpha:0.0f];
     }];
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^(void)
     {
         if(completion)
             completion();
     }];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    [animation setToValue:[NSNumber numberWithDouble:0.0]];
    [animation setFromValue:[NSNumber numberWithDouble:1.0]];
    [animation setDuration:0.3];
    animation.delegate = self;
    
    [grid.layer addAnimation:animation forKey:@"Hide Grid"];
    
    [CATransaction commit];
}

/*
 Grow animation fro existing card...
 After animation completion block will be executed.. Wchich can be used to set tag and datasource to card...
 */
-(void)showGrid:(STGridCell *)grid AfterCompleted:(void (^)(void))completion
{
    [UIView animateWithDuration:0.2 animations:^(void) {
        grid.alpha = 1.0f;
    }];
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^(void)
     {
         if(completion)
             completion();
     }];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    [animation setToValue:[NSNumber numberWithDouble:1.0]];
    [animation setFromValue:[NSNumber numberWithDouble:0.0]];
    [animation setDuration:0.3];
    animation.delegate = self;
    
    [grid.layer addAnimation:animation forKey:@"Show Grid"];
    
    [CATransaction commit];
}


#pragma mark - GridCell grid Index creation and frame/page calculation methods
// =======================================================================================================================================>>
/*
 To set new grid index for each card based on card index... Which will set frame and page for all grid...
 */
-(GridIndex *)gridIndexForIndex:(int)index
{
    int page = (index / (columns * rows));
    int pos = (index % (columns * rows));
    int column = (page * columns) + (pos % columns);
    int row = (pos / columns);
    
    GridIndex *gridIndex = [[GridIndex alloc] initWithColumn:column andRow:row];
    gridIndex.index = index;
    gridIndex.page = page;
    return gridIndex;
}


#pragma mark - GridCell reuse and layout update methods
// =======================================================================================================================================>>
/*
 After inserting new card the remaing cards will be updated based on new index...
 */
-(void)updateCardsFromIndex:(int)index
{
    [self getFrames];
    
    for(int i=index; i < numberOfGrid; i++)
    {
        STGridCell *gridCell = (STGridCell *)[reusableGrids objectForKey:@(i+2)];
        
        GridIndex *gridIndex = [self gridIndexForIndex:i];
        CGRect frame = [self getFrameForCell:gridCell atGridIndex:gridIndex];
        
        if(gridCell && (gridCell.gridIndex.page == currentPage || gridIndex.page == currentPage)) {
            [UIView animateWithDuration:0.5 animations:^(void) {
                gridCell.frame = frame;
             } completion:^(BOOL finished) {
                 gridCell.gridIndex = gridIndex;
             }];
        } else if(gridIndex.page <= currentPage+3) {
            if(!gridCell) {
                gridCell = [self createGridAtIndex:i];
            } else {
                gridCell.gridIndex = gridIndex;
                gridCell.frame = frame;
            }
        }
        [reusableGrids setObject:gridCell forKey:@(i+1)];
        [reusableGrids removeObjectForKey:@(i+2)];
    }
}


#pragma Mark Scrollview Delegates.....
// =======================================================================================================================================>>
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    /*
     To get the scroller movement direction...
     */
    CGFloat pageWidth = scrollView.frame.size.width;
    currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    scrollBeginOffset = scrollView.contentOffset.x;
    [self.pageIndicator movetoPage:currentPage+1 inTotalPage:totalPage];
    scrollDirection = GridScrollDirectionRight;
    [self scrollAnimationForGridsForState:NO];
    scrollDirection = GridScrollDirectionLeft;
    [self scrollAnimationForGridsForState:NO];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    /*
     To paginate grids based on scroller page movement and to update page bar...
     */
    if(scrollBeginOffset < scrollView.contentOffset.x) {
        scrollDirection = GridScrollDirectionRight;
        if(scrollView.contentOffset.x >= (scrollBeginOffset + scrollView.frame.size.width))
        {
            if(toPage < totalPage) {
                toPage++;
                [self loadGridsForPage:toPage];
            }
            
            if((currentPage - fromPage) > 2) {
                [self dequeScrollCellAtPage:fromPage];
                fromPage++;
            }
            
            scrollBeginOffset += scrollView.frame.size.width;
        }
    } else {
        scrollDirection = GridScrollDirectionLeft;
        if(scrollView.contentOffset.x <= (scrollBeginOffset - scrollView.frame.size.width))
        {
            if(fromPage > 0)
            {
                fromPage--;
                [self loadGridsForPage:fromPage];
            }
            if((toPage - currentPage) > 2)
            {
                [self dequeScrollCellAtPage:toPage];
                toPage--;
            }
            
            scrollBeginOffset = (scrollBeginOffset - scrollView.frame.size.width);
        }
    }
    
    CGFloat pageWidth = scrollView.frame.size.width;
    currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [self.pageIndicator movetoPage:currentPage+1 inTotalPage:totalPage];
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    /*
     To animate card fall for scroller movement direction...
     */
    CGFloat pageWidth = scrollView.frame.size.width;
    currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    scrollDirection = GridScrollDirectionRight;
    [self scrollAnimationForGridsForState:YES];
    scrollDirection = GridScrollDirectionLeft;
    [self scrollAnimationForGridsForState:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    /*
     To update page bar based on scroller page...
     */
    CGFloat pageWidth = scrollView.frame.size.width;
    currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [self.pageIndicator movetoPage:currentPage+1 inTotalPage:totalPage];
}
// =======================================================================================================================================>>



#pragma Mark Scroll Animations.....
// =======================================================================================================================================>>
/*
 To animate cards fall based on movement..
 To set initial position and to animate to the final position...
 */
-(void)scrollAnimationForGridsForState:(BOOL)state
{
    float delay = 0.3;
    
    int page = (scrollDirection == GridScrollDirectionRight) ? (currentPage + 1) : (currentPage - 1);
    
    if(page >= 0 && page <= toPage) {
        int column = page * columns;
        
        if(scrollDirection == GridScrollDirectionRight) {
            for(int i = column; i < (column + columns); i++) {
                [self animateGirdsInColumn:i shouldAnimate:state duration:delay];
                delay += 0.2;
            }
        } else if(scrollDirection == GridScrollDirectionLeft) {
            for(int i = (column + columns)-1 ; i >= column; i--) {
                [self animateGirdsInColumn:i shouldAnimate:state duration:delay];
                delay += 0.2;
            }
        }
    }
}

-(void)animateGirdsInColumn:(int)column shouldAnimate:(BOOL)animate duration:(float)duration
{
    int currentIndex = (column >= columns) ? (((column / columns) * rows * columns) + (column % columns)) : column;
    
    for(int j= (column * rows); j < ((column * rows) + rows); j++)
    {
        if(currentIndex >= 0) {
            STGridCell *grid = [self cellForIndex:currentIndex];
            CGRect frame = [self getFrameForCell:grid atGridIndex:grid.gridIndex];
            
            if(animate) {
                [UIView animateWithDuration:duration animations:^(void) {
                    grid.frame = frame;
                }];
            } else {
                switch (scrollDirection) {
                    case GridScrollDirectionRight:
                        grid.frame = (CGRect) {frame.origin.x + 75, frame.origin.y, frame.size};
                        break;
                        
                    case GridScrollDirectionLeft:
                        grid.frame = (CGRect) {frame.origin.x - 75, frame.origin.y, frame.size};
                        break;
                        
                    case GridScrollDirectionUp:
                        grid.frame = (CGRect) {frame.origin.x, frame.origin.y + 75, frame.size};
                        break;
                        
                    case GridScrollDirectionDown:
                        grid.frame = (CGRect) {frame.origin.x, frame.origin.y - 75, frame.size};
                        break;
                        
                    default:
                        break;
                }
            }
        }
        currentIndex += columns;
    }
}
// =======================================================================================================================================>>


#pragma mark - layoutSubviews to handle orientation changes
// =======================================================================================================================================>>
- (void) layoutSubviews {
    [super layoutSubviews];
    CGSize layoutSize = self.bounds.size;
    if (priorLayoutSize.width != layoutSize.width) {
        priorLayoutSize = layoutSize;
        [self reloadData];
    }
}

@end

