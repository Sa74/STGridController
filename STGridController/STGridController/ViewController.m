//
//  ViewController.m
//  STGridController
//
//  Created by Sasi M on 24/02/18.
//  Copyright © 2018 LeanSwift Inc. All rights reserved.
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
    NSMutableArray *indexes = [NSMutableArray arrayWithObjects:@1, @5, @8, @9, nil];
    for (NSNumber *number in indexes) {
        [self.dataArray insertObject:@"dataIn" atIndex:number.integerValue];
    }
//        [self.dataArray insertObject:@"data" atIndex:1];
//        [self.gridView insertGridAtIndex:1];
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
-(void)reloadData
{
    [self.gridView reloadData];
}

@end
