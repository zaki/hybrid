//
//  InviteViewController.h
//  Rand
//
//  Created by Dezso Zoltan on 2011.06.29..
//  Copyright 2011 Friday Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>

@interface InviteViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
  NSMutableArray* people;
  IBOutlet UITableView *tableView;
  IBOutlet UINavigationItem *navTitle;
  
  int selectedContacts;
}

@property (nonatomic, retain) NSMutableArray *people;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UINavigationItem *navTitle;

@end
