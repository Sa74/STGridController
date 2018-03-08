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

@property (strong, nonatomic) IBOutlet STGridCell *gridCell;
@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation ViewController 


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dataArray = [NSArray arrayWithObjects:@"Data1", @"Data1", @"Data2", @"Data3", @"Data4", @"Data5", @"Data6", @"Data7", @"Data8", @"Data1", @"Data1", @"Data2", @"Data3", @"Data4", @"Data5", @"Data6", @"Data7", @"Data8", @"Data1", @"Data1", @"Data2", @"Data3", @"Data4", @"Data5", @"Data6", @"Data7", @"Data8", @"Data1", @"Data1", @"Data2", @"Data3", @"Data4", @"Data5", @"Data6", @"Data7", @"Data8", @"Data1", @"Data1", @"Data2", @"Data3", @"Data4", @"Data5", @"Data6", @"Data7", @"Data8", @"Data1", @"Data1", @"Data2", @"Data3", @"Data4", @"Data5", @"Data6", @"Data7", @"Data8", @"Data1", @"Data1", @"Data2", @"Data3", @"Data4", @"Data5", @"Data6", @"Data7", @"Data8", @"Data1", @"Data1", @"Data2", @"Data3", @"Data4", @"Data5", @"Data6", @"Data7", @"Data8", @"Data1", @"Data1", @"Data2", @"Data3", @"Data4", @"Data5", @"Data6", @"Data7", @"Data8", @"Data1", @"Data1", @"Data2", @"Data3", @"Data4", @"Data5", @"Data6", @"Data7", @"Data8", @"Data1", @"Data1", @"Data2", @"Data3", @"Data4", @"Data5", @"Data6", @"Data7", @"Data8", @"Data1", @"Data1", @"Data2", @"Data3", @"Data4", @"Data5", @"Data6", @"Data7", @"Data8",nil];
    
    self.gridView.dataSource = self;
    self.gridView.gridDelegate = self;
    self.gridView.gridDelegate = self;
    self.gridCell.hidden = true;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.gridView reloadData];
    self.gridCell.hidden = true;
}

#pragma Grid Controller Data source and Delegates...
// =======================================================================================================================================>>
-(NSInteger)numberOfGrids {
    return self.dataArray.count;
}

-(STGridCell *)gridView:(STGridView *)gridView cellForIndex:(int)index
{
    /*
     Last index will be add server card...
     Active server should be highlighted...
     */
    STGridCell *cell = nil;
    self.gridCell.hidden = false;
    NSData *tempArchive = [NSKeyedArchiver archivedDataWithRootObject:self.gridCell];
    cell = [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
    
    self.gridCell.hidden = true;
    
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
