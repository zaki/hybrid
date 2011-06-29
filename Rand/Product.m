//
//  Product.m
//  Rand
//
//  Created by Dezso Zoltan on 2011.06.29..
//  Copyright 2011 Friday Systems. All rights reserved.
//

#import "Product.h"


@implementation Product

@synthesize name;
@synthesize price;
@synthesize productId;

- (id) initWithName:(NSString *)name price:(NSString *)price productId:(NSString *)productId
{
  self = [super init];
  if (self) {
    self.name = name;
    self.price = price;
    self.productId = productId;
  }
  return self;
}

@end
