//
//  InviteTableCell.h
//  Rand
//
//  Created by Dezso Zoltan on 2011.06.28..
//  Copyright 2011 Friday Systems. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InviteTableCell : UITableViewCell {
  NSString *strContactName;
  IBOutlet UILabel *contactName;
  IBOutlet UIButton *inviteButton;
}

@property (nonatomic, retain) NSString *strContactName;
@property (nonatomic, retain) UILabel *contactName;
@property (nonatomic, retain) UIButton *inviteButton;

@end
