//
//  ViewController.m
//  STGridController
//
//  Created by Sasi M on 24/02/18.
//  Copyright © 2018 Sasi Moorthy. All rights reserved.
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

#import "ViewController.h"
#import "STGridView.h"

@interface ViewController () <GridDelegate, GridDataSource>

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation ViewController 


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.dataArray = [NSMutableArray arrayWithObjects:@"Data1", @"Data1", @"Data2", @"Data3", @"Data4", @"Data5", @"Data6", @"Data7", @"Data8", @"Data1", @"Data1", @"Data2", @"Data3", @"Data4", @"Data5", @"Data6", @"Data7", @"Data8", @"Data1", @"Data1", @"Data2", @"Data3", @"Data4", @"Data5", @"Data6", @"Data7", @"Data8", @"Data1", @"Data1", @"Data2", @"Data3", @"Data4", @"Data5", @"Data6", @"Data7", @"Data8", @"Data1", @"Data1", @"Data2", @"Data3", @"Data4", @"Data5", @"Data6", @"Data7", @"Data8", @"Data1", @"Data1", @"Data2", @"Data3", @"Data4", @"Data5", @"Data6", @"Data7", @"Data8", @"Data1", @"Data1", @"Data2", @"Data3", @"Data4", @"Data5", @"Data6", @"Data7", @"Data8", @"Data1", @"Data1", @"Data2", @"Data3", @"Data4", @"Data5", @"Data6", @"Data7", @"Data8", @"Data1", @"Data1", @"Data2", @"Data3", @"Data4", @"Data5", @"Data6", @"Data7", @"Data8", @"Data1", @"Data1", @"Data2", @"Data3", @"Data4", @"Data5", @"Data6", @"Data7", @"Data8", @"Data1", @"Data1", @"Data2", @"Data3", @"Data4", @"Data5", @"Data6", @"Data7", @"Data8", @"Data1", @"Data1", @"Data2", @"Data3", @"Data4", @"Data5", @"Data6", @"Data7", @"Data8",nil];
    
    self.gridView.dataSource = self;
    self.gridView.gridDelegate = self;
    self.gridView.gridDelegate = self;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.gridView reloadData];
}

- (IBAction)filterGrids:(id)sender {
    NSMutableArray *indexes = [NSMutableArray arrayWithObjects:@1, @5, @8, @9, nil];
    for (NSNumber *number in indexes) {
        [self.dataArray removeObjectAtIndex:number.integerValue];
    }
//    [self.dataArray removeObjectAtIndex:1];
//    [self.gridView removeGridAtIndex:1];
    [self.gridView removeGridsAtIndexes:indexes];
}

- (IBAction)insertGrids:(id)sender {
    NSMutableArray *indexes = [NSMutableArray arrayWithObjects:@1, @5, @8, @10, nil];
    for (NSNumber *number in indexes) {
        [self.dataArray insertObject:@"dataIn" atIndex:number.integerValue];
    }
//    [self.dataArray insertObject:@"data" atIndex:1];
//    [self.gridView insertGridAtIndex:1];
    [self.gridView insertGridsAtIndexes:indexes];
}


#pragma Grid Controller Data source and Delegates...
// =======================================================================================================================================>>
-(NSInteger)numberOfGrids {
    return self.dataArray.count;
}

-(STGridCell *)gridView:(STGridView *)gridView cellForIndex:(int)index {
    
    STGridCell *cell = [gridView dequeuCellWithIdentifier:@"gridIdentifier" atIndex:index];
    if (!cell) {
        cell = [[STGridCell alloc] initWithFrame:(CGRect){CGPointZero, 195.0f, 147.0f} reusableIdnetifier:@"gridIdentifier"];
        cell.backgroundColor = [UIColor colorWithRed:0 green:150.0f/255.0f blue:1.0f alpha:1.0f];
    }
    
    return cell;
}

-(void)selectedGrid:(STGridCell *)gridcell AtIndex:(int)index {
    
}
// =======================================================================================================================================>>

/*
 Method to update grid controller frame based on Orientation change...
 */
-(void)reloadData {
    [self.gridView reloadData];
}

@end
