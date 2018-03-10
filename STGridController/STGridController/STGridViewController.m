//
//  STGridViewController.m
//  STGridController
//
//  Created by Sasi M on 08/03/18.
//  Copyright © 2018 LeanSwift Inc. All rights reserved.
//

#import "STGridViewController.h"

@interface STGridViewController ()

@end

@implementation STGridViewController


#pragma Grid Controller Data source and Delegates...
// =======================================================================================================================================>>
-(NSInteger)numberOfGrids {
    return 0; // Override as required
}

-(STGridCell *)gridView:(STGridView *)gridView cellForIndex:(int)index {
    return nil; // Override as required
}

-(void)selectedGrid:(STGridCell *)gridcell AtIndex:(int)index {
    // Override as required
}
// =======================================================================================================================================>>


@end
