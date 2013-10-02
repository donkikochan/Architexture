//
//  SplitViewController.m
//  eTablet
//
//  Created by Jordi Badia Santaulària on 02/04/12.
//  Copyright (c) 2012 Endepro Software. All rights reserved.
//

#import "ECascadeSplitViewController.h"
#import "EConsts.h"

@implementation ECascadeSplitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // add divider
    UIImage* divider = [UIImage imageNamed:@"divider_vertical.png"];
    [self setDividerImage: divider];
    
    // change offsets
    [self.cascadeNavigationController setLeftInset:CASCADE_SPLIT_LEFT_INSERT];
    [self.cascadeNavigationController setWiderLeftInset:CASCADE_SPLIT_WIDER_LEFT_INSERT];
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
	return YES;
}

@end
