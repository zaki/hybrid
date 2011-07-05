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

- (id) initWithName:(NSString *)name email:(NSString *)email
{
  self = [super init];
  if (self) {
    self.name = name;
    self.email = email;
    self.sendInvite = NO;
  }
  return (self);
}

@end
