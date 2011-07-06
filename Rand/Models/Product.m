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

- (id) initWithName:(NSString *)_name price:(NSString *)_price productId:(NSString *)_productId
{
  self = [super init];
  if (self) {
    self.name = _name;
    self.price = _price;
    self.productId = _productId;
  }
  return self;
}

@end
