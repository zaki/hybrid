//
//  ShopViewController.h
//  Rand
//
//  Created by Dezso Zoltan on 2011.06.29..
//  Copyright 2011 Friday Systems. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShopViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
  NSMutableArray* products;
  IBOutlet UITableView *tableView;
}

@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) UITableView *tableView;

@end
