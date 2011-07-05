//
//  InviteViewController.m
//  Rand
//
//  Created by Dezso Zoltan on 2011.06.29..
//  Copyright 2011 Friday Systems. All rights reserved.
//

#import "Person.h"
#import "FlurryAPI.h"
#import "InviteTableCell.h"
#import "InviteViewController.h"
#import <AddressBook/AddressBook.h>
#import <MessageUI/MessageUI.h>

@implementation InviteViewController

@synthesize people;
@synthesize tableView;
@synthesize navTitle;
@synthesize navButton;

- (void) loadPeople
{
  if (self.people != nil)
    return;
  ABAddressBookRef addressBook = ABAddressBookCreate();
  
  CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
  CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
  
  CFMutableArrayRef peopleMutable = CFArrayCreateMutableCopy(
                                                             kCFAllocatorDefault,
                                                             CFArrayGetCount(allPeople),
                                                             allPeople
                                                             );
  
  CFArraySortValues(
                    peopleMutable,
                    CFRangeMake(0, CFArrayGetCount(peopleMutable)),
                    (CFComparatorFunction) ABPersonComparePeopleByName,
                    (void*) ABPersonGetSortOrdering()
                    ); 
  
  people = [[NSMutableArray alloc] init];
  for (int i = 0; i < nPeople; i++) {
    ABRecordRef ref = CFArrayGetValueAtIndex(peopleMutable, i);
    CFStringRef firstName = ABRecordCopyValue(ref, kABPersonFirstNameProperty);
    CFStringRef lastName = ABRecordCopyValue(ref, kABPersonLastNameProperty);

    NSString *strEmail = @"";
    CFStringRef email = NULL;
    
    ABMultiValueRef emails = ABRecordCopyValue(ref, kABPersonEmailProperty);
    CFIndex emailCount = ABMultiValueGetCount(emails);
    if (emailCount > 0)
    {
      for (int i = 0; i < emailCount; i++)
      {
        CFStringRef emailLabel = (NSString *)ABMultiValueCopyLabelAtIndex(emails, i);
        if (emailLabel == NULL || CFStringCompare(emailLabel, kABWorkLabel, 0) != 0)
        {
          email = ABMultiValueCopyValueAtIndex(emails, i);
          strEmail = (NSString *)email;
          break;
        }
      }
      
      if (firstName != NULL || lastName != NULL)
      {
        NSString *strFirst, *strLast;
      
        strFirst = (firstName == NULL ? @"" : (NSString *)firstName);
        strLast =  (lastName  == NULL ? @"" : (NSString *)lastName);
      
        NSString *contactFirstLast = [NSString stringWithFormat: @"%@ %@", strFirst, strLast];
        Person *person = [[Person alloc] initWithName:contactFirstLast email:strEmail];
        [self.people addObject:person];
        [person release];
      }
    }
    
    if (firstName != NULL)
      CFRelease(firstName);
    if (lastName != NULL)
      CFRelease(lastName);
    if (emails != NULL)
      CFRelease(emails);
    if (email != NULL)
      CFRelease(email);
  }

  CFRelease(peopleMutable);
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
      [self loadPeople];
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
  [self loadPeople];
  selectedContacts = 0;
  self.navButton.enabled = NO;
  self.navButton.target = self;
  self.navButton.action = @selector(clickedInviteButton:);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Invite mailer

- (void) alertView:(UIAlertView*)alert willDismissWithButtonIndex:(NSInteger)buttonIndex
{
  if (buttonIndex != [alert cancelButtonIndex])
  {
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    [picker setSubject:@"Play DemoQuest"];
    
    // Set up the recipients.
    NSMutableArray *bccRecipients = [NSMutableArray array];
    
    for (int i = 0; i < [people count]; i++)
    {
      Person *person = [people objectAtIndex:i];
      if (person.sendInvite)
      {
        [bccRecipients addObject:person.email];
      }
    }
    
    [picker setBccRecipients:bccRecipients];
        
    // Fill out the email body text.
    NSString *emailBody = @"Hi! I am playing DemoQuest and thought you might enjoy it too. Start playing today at http://app8.dev";
    [picker setMessageBody:emailBody isHTML:NO];
    
    // Present the mail composition interface.
    [self presentModalViewController:picker animated:YES];
    [picker release]; // Can safely release the controller now.
  }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
  [self dismissModalViewControllerAnimated:YES];
}

- (void) clickedInviteButton:(id)sender
{
  UIButton *button = (UIButton *)sender;
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Send Invites" message:[NSString stringWithFormat:@"Send Invite to %d of Your Friends?", selectedContacts] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
  [FlurryAPI logEvent:[NSString stringWithFormat:@"INVITE:CLICK"]];
  [alert show];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return ([people count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{  
  //[self loadPeople];
  NSInteger row = [indexPath row];
	
	// Create a cell if one is not already available
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"any-cell"];
	if (cell == nil) 
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"any-cell"] autorelease];
	
  Person *person = [self.people objectAtIndex:[indexPath row]];
  
  cell.textLabel.text = person.name;
  cell.detailTextLabel.text = person.email;

  //cell.accessoryType = UITableViewCellAccessoryCheckmark;
	return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  cell.accessoryType = cell.accessoryType == UITableViewCellAccessoryCheckmark ? UITableViewCellAccessoryNone : UITableViewCellAccessoryCheckmark;
  
  selectedContacts += (cell.accessoryType == UITableViewCellAccessoryCheckmark ? 1 : -1);
  Person *person = [self.people objectAtIndex:[indexPath row]];
  person.sendInvite = (cell.accessoryType == UITableViewCellAccessoryCheckmark);
  self.navButton.enabled = (selectedContacts > 0);
  
  navTitle.title = [NSString stringWithFormat:@"%d Contact%@ Selected", selectedContacts, selectedContacts > 1 ? @"s" : @""];
}

@end
