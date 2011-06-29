//
//  ShopViewController.m
//  Rand
//
//  Created by Dezso Zoltan on 2011.06.29..
//  Copyright 2011 Friday Systems. All rights reserved.
//

#import "ShopViewController.h"
#import "Product.h"
#import "FlurryAPI.h"

@implementation ShopViewController

@synthesize products;
@synthesize tableView;

- (void) loadProducts
{
  if (products != nil)
    return;
  products = [[NSMutableArray alloc] init];
  [products addObject:[[Product alloc] initWithName:@"1 Coin"             price:@"$0.99" productId:@""]];
  [products addObject:[[Product alloc] initWithName:@"5 Coin Pack"        price:@"$1.99" productId:@""]];
  [products addObject:[[Product alloc] initWithName:@"10 Coin Pack"       price:@"$2.99" productId:@""]];
  [products addObject:[[Product alloc] initWithName:@"20 Coin Superpack"  price:@"$3.99" productId:@""]];
  [products addObject:[[Product alloc] initWithName:@"50 Coin Megapack"   price:@"$4.99" productId:@""]];
  [products addObject:[[Product alloc] initWithName:@"100 Coin Überpack"   price:@"$5.99" productId:@""]];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      [self loadProducts];
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

#pragma mark - View lifecycle

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  [self loadProducts];
  return ([products count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{  
  [self loadProducts];
  NSInteger row = [indexPath row];
	
	// Create a cell if one is not already available
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"any-cell"];
	if (cell == nil) 
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"any-cell"] autorelease];
	
  Product *product = [products objectAtIndex:[indexPath row]];
  cell.textLabel.text = product.name;
  UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  button.frame = CGRectMake(0, 0, 70, 30);
  [button setTitle:product.price forState:UIControlStateNormal];
  
  cell.accessoryView = button;
  
  //cell.accessoryType = UITableViewCellAccessoryCheckmark;
	return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [FlurryAPI logEvent:@"Shop row selected"];
}

@end
