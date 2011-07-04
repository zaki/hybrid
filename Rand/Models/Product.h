//
//  Product.h
//  Rand
//
//  Created by Dezso Zoltan on 2011.06.29..
//  Copyright 2011 Friday Systems. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Product : NSObject {
  NSString *name;
  NSString *price;
  NSString *productId;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *price;
@property (nonatomic, retain) NSString *productId;

- (id) initWithName:(NSString *)name price:(NSString *)price productId:(NSString *)productId;

@end
