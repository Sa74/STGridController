//
//  STGridViewController.h
//  STGridController
//
//  Created by Sasi M on 10/05/13.
//  Copyright (c) 2013 Sasi M. All rights reserved.
//


/* Sasi M
 This is a custom generated controller which will generate GridView and works similar to UITableViewController...
 To implement this controller import this class & set datasource and delegate for this controller...
 */

#import <UIKit/UIKit.h>
#import "STGridView.h"


@interface STGridViewController : UIViewController <GridDelegate, GridDataSource, UIScrollViewDelegate> {
    @private
    
}

@property (nonatomic, strong) IBOutlet STGridView *gridView;

@end
