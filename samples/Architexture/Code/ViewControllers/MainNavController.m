//
//  MainNavigationController.m
//  achitexture
//
//  Created by DonKikochan on 10/07/13.
//  Copyright (c) 2013 architexture. All rights reserved.
//

#import "MainNavController.h"

@interface MainNavController ()

@end

@implementation MainNavController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[AppDelegate mainAppDelegate] setNavigationViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
