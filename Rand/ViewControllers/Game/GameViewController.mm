//
//  GameViewController.m
//  Rand
//
//  Created by Dezso Zoltan on 2011.06.28..
//  Copyright 2011 Friday Systems. All rights reserved.
//

#import "GameViewController.h"
#import "FlurryAPI.h"
#import "EAGLView.h"

@implementation GameViewController

@synthesize glView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) 
	{
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

#pragma mark - Touches

#pragma mark - View lifecycle

- (void)viewDidAppear:(BOOL)animated
{
  [FlurryAPI logEvent:@"GAME:OPENED"];
  [super viewDidAppear:animated];
  [glView startAnimation];
}

- (void)viewDidDisappear:(BOOL)animated
{
  [FlurryAPI logEvent:@"GAME:CLOSED"];
  [super viewDidDisappear:animated];
  [glView stopAnimation];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
