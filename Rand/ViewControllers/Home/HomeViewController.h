//
//  HomeViewController.h
//  Rand
//
//  Created by Dezso Zoltan on 2011.06.28..
//  Copyright 2011 Friday Systems. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeViewController : UIViewController<UIWebViewDelegate> {
  IBOutlet UIWebView *webView;
  IBOutlet UIActivityIndicatorView *activityView;
}

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIActivityIndicatorView *activityView;

@end
