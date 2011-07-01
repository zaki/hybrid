//
//  Person.h
//  Rand
//
//  Created by Dezso Zoltan on 2011.07.01..
//  Copyright 2011 Friday Systems. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Person : NSObject {
  NSString *name;
  NSString *email;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *email;

- (id) initWithName:(NSString *)name email:(NSString *)email;

@end
