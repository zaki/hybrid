//
//  GameViewController.h
//  Rand
//
//  Created by Dezso Zoltan on 2011.06.28..
//  Copyright 2011 Friday Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EAGLView;

@interface GameViewController : UIViewController {
  IBOutlet EAGLView *glView;
  CGPoint startTouchPosition;
}

@property (nonatomic, retain) EAGLView *glView;

@end
