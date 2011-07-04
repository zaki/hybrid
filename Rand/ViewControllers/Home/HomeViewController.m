//
//  HomeViewController.m
//  Rand
//
//  Created by Dezso Zoltan on 2011.06.28..
//  Copyright 2011 Friday Systems. All rights reserved.
//

#import "HomeViewController.h"
#import <SystemConfiguration/SystemConfiguration.h>

@implementation HomeViewController
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - UIWebViewDelegate

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
  return YES;
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
  [activityView stopAnimating];
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationDuration:0.5];
  [webView setAlpha:1.0];
  
  

  
  [UIView commitAnimations];
}

#pragma mark - View lifecycle

- (void) viewDidAppear:(BOOL)animated
{
  [activityView startAnimating];
  [self.view setBackgroundColor:[UIColor blackColor]];
  [webView setAlpha:0.0];

  BOOL connected = NO;
  SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, "staging.local.app8.pikdevja.com");
  
  if (reachability != NULL)
  {
    SCNetworkReachabilityFlags flags = 0;
    const BOOL reachable = SCNetworkReachabilityGetFlags(reachability, &flags);
    CFRelease(reachability);
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    
    if (isReachable && !needsConnection)
      connected = YES;
  }
  
  if (connected)
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://app8.dev/?minmode=1"]]];
  else
  {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Internet Connection Required" message:@"Cannot connect to the internet. Connect to a 3G or WiFi connection." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
  }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
