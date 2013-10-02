//
//  BaseViewController.m
//  rankrunner
//
//  Created by Jordi Badia Santaulària on 10/05/12.
//  Copyright (c) 2012 Endepro Software. All rights reserved.
//

#import "BaseViewController.h"

#pragma mark - BaseViewController

@implementation BaseViewController

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (UIView*) mainView
{
    if (self.navigationController != nil)
        return self.navigationController.view;
    else
        return self.view;
}

- (UIViewController*) mainViewController
{
    if (self.navigationController != nil)
        return self.navigationController;
    else
        return self;    
}

#pragma mark View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
        
    //Set Background
    //self.view.backgroundColor = [UIColor colorWithR:255 G:255 B:255 A:1];
    
    //[self setBackButtonCustom];
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

#pragma mark Offline Data

- (NSString*) getOfflinePathForFilename:(NSString*)filename
{
    return [[ECommon documentsPath] stringByAppendingPathComponent:filename];
}

- (BOOL) saveObjectOffileFor:(NSObject*)obj toFile:(NSString*)filename
{
    NSMutableData *theData = [NSMutableData data];
    NSKeyedArchiver *encoder = [[NSKeyedArchiver alloc] initForWritingWithMutableData:theData];
    
    [encoder encodeObject:obj forKey:@"Data"];
    [encoder finishEncoding];
    return [theData writeToFile:[self getOfflinePathForFilename:filename] atomically:YES];
}

- (NSObject*) loadObjectOfflineFromFile:(NSString*)filename
{
    NSData *theData = [NSData dataWithContentsOfFile:[self getOfflinePathForFilename:filename]];
    NSKeyedUnarchiver *decoder = [[NSKeyedUnarchiver alloc] initForReadingWithData:theData];
    return [decoder decodeObjectForKey:@"Data"];
}

@end



#pragma mark - BaseTableViewController

@implementation BaseTableViewController

@synthesize offset;
@synthesize prevItemsCount;
@synthesize moreItems;

- (void)viewDidLoad
{
    if (self.tableView.tableHeaderView != nil)
    {
        //MUST be set before the super call
        self.headerOffsetY = self.tableView.tableHeaderView.frame.size.height;
    }
    
    [super viewDidLoad];
    
    [self resetOffset];
    
    //To hide it when it shouldn't be shown
    //[self.tableView sendSubviewToBack:refreshHeaderView];
    
    //[self setBackButtonCustom];
}

- (UIView*) mainView
{
    if (self.navigationController != nil)
        return self.navigationController.view;
    else
        return self.view;
}

- (UIViewController*) mainViewController
{
    if (self.navigationController != nil)
        return self.navigationController;
    else
        return self;    
}

- (void)keyboardControlsPreviousNextPressed:(BSKeyboardControls *)controls withDirection:(KeyboardControlsDirection)direction andActiveTextField:(id)textField
{
    [super keyboardControlsPreviousNextPressed:controls withDirection:direction andActiveTextField:textField];
    [self scrollViewToTextField:textField];
}

- (void)scrollViewToTextField:(id)textField
{
    UITableViewCell *cell = nil;
    if ([textField isKindOfClass:[UITextField class]])
        cell = (UITableViewCell *) ((UITextField *) textField).superview.superview;
    else if ([textField isKindOfClass:[UITextView class]])
        cell = (UITableViewCell *) ((UITextView *) textField).superview.superview;
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

- (void) loadData
{
}

- (void) resetOffset
{
    self.offset = 0;
    self.prevItemsCount = 0;
    self.moreItems = NO;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.moreItems && indexPath.row + 1 == [self.tableView.dataSource tableView:self.tableView numberOfRowsInSection:0])
    {
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
        [self loadData];
    }
}


#pragma mark UITextView Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [super textFieldDidBeginEditing:textField];
    [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(scrollViewToTextField:) userInfo:textField repeats:NO];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [super textViewDidBeginEditing:textView];
    [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(scrollViewToTextField:) userInfo:textView repeats:NO];
}

#pragma mark PullRefreshTableViewController

- (void)startLoading
{
    [self resetOffset];
    [self loadData];
}

#pragma mark Offline Data

- (NSString*) getOfflinePathForFilename:(NSString*)filename
{
    return [[ECommon documentsPath] stringByAppendingPathComponent:filename];
}

- (BOOL) saveDataOffileFor:(NSArray*)arr toFile:(NSString*)filename
{
    NSMutableData *theData = [NSMutableData data];
    NSKeyedArchiver *encoder = [[NSKeyedArchiver alloc] initForWritingWithMutableData:theData];
    
    [encoder encodeObject:arr forKey:@"Data"];
    [encoder finishEncoding];
    return [theData writeToFile:[self getOfflinePathForFilename:filename] atomically:YES];
}

- (NSMutableArray*) loadDataOfflineFromFile:(NSString*)filename
{
    NSData *theData = [NSData dataWithContentsOfFile:[self getOfflinePathForFilename:filename]];
    NSKeyedUnarchiver *decoder = [[NSKeyedUnarchiver alloc] initForReadingWithData:theData];
    NSMutableArray *arr = [decoder decodeObjectForKey:@"Data"];
    if (arr == nil)
    {
        arr = [[NSMutableArray alloc] init];
    }
    
    return arr;
}

@end

