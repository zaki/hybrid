//
//  Person.m
//  Rand
//
//  Created by Dezso Zoltan on 2011.07.01..
//  Copyright 2011 Friday Systems. All rights reserved.
//

#import "Person.h"

@implementation Person

@synthesize name;
@synthesize email;
@synthesize sendInvite;

- (id) initWithName:(NSString *)_name email:(NSString *)_email
{
  self = [super init];
  if (self) {
    self.name = _name;
    self.email = _email;
    self.sendInvite = NO;
  }
  return (self);
}

@end
