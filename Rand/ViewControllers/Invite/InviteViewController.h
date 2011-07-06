//
//  InviteViewController.h
//  Rand
//
//  Created by Dezso Zoltan on 2011.06.29..
//  Copyright 2011 Friday Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <MessageUI/MessageUI.h>

@interface InviteViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate> {
  NSMutableArray* people;
  IBOutlet UITableView *tableView;
  IBOutlet UINavigationItem *navTitle;
  IBOutlet UIBarButtonItem *navButton;
  
  int selectedContacts;
}

@property (nonatomic, retain) NSMutableArray *people;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UINavigationItem *navTitle;
@property (nonatomic, retain) UIBarButtonItem *navButton;

@end
