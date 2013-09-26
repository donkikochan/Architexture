//
//  Menu_VC.m
//  achitexture
//
//  Created by DonKikochan on 10/07/13.
//  Copyright (c) 2013 architexture. All rights reserved.
//

//---Imports:---
#import "Menu_VC.h"
#import <QuartzCore/QuartzCore.h>
#import "MenuOption_Cell.h"
#import "CheckoutRing.h"
#import "CollectionSection_View.h"
//---------------
@interface Menu_VC ()

@end

@implementation Menu_VC

#define TIME_TO_SHOW_NEW_MAIN_INFO  0.4

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
    
    //[_m_ScrollView setContentSize:CGSizeMake(1.f, 805.f)];
    // create a UITapGestureRecognizer to detect when the screenshot recieves a single tap
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapScreenShot:)];
    [_screenShotImageView addGestureRecognizer:_tapGesture];
    
    // create a UIPanGestureRecognizer to detect when the screenshot is touched and dragged
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureMoveAround:)];
    [_panGesture setMaximumNumberOfTouches:2];
    [_panGesture setDelegate:self];
    [_screenShotImageView addGestureRecognizer:_panGesture];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
    {
        // iOS 7
        [self setNeedsStatusBarAppearanceUpdate];
    }

}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void) viewDidUnload
{
    [super viewDidUnload];
    
    // remove the gesture recognizers
    [self.screenShotImageView removeGestureRecognizer:self.tapGesture];
    [self.screenShotImageView removeGestureRecognizer:self.panGesture];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    
    // when the menu view appears, it will create the illusion that the other view has slide to the side
    // what its actually doing is sliding the screenShotImage passed in off to the side
    // to start this, we always want the image to be the entire screen, so set it there
    [_screenShotImageView setImage:self.screenShotImage];
    
    CGRect frame = _screenShotImageView.frame;
    [_screenShotImageView setFrame:CGRectMake(0, frame.origin.y, frame.size.width, frame.size.height)];
    
    // now we'll animate it across to the right over 0.2 seconds with an Ease In and Out curve
    // this uses blocks to do the animation. Inside the block the frame of the UIImageView has its
    // x value changed to where it will end up with the animation is complete.
    // this animation doesn't require any action when completed so the block is left empty
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [_screenShotImageView setFrame:CGRectMake(255, frame.origin.y, frame.size.width, frame.size.height)];
    }
                     completion:^(BOOL finished){  }];
}


-(void) slideThenHide
{
    // this animates the screenshot back to the left before telling the app delegate to swap out the MenuViewController
    // it tells the app delegate using the completion block of the animation
    CGRect frame = _screenShotImageView.frame;
    
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [_screenShotImageView setFrame:CGRectMake(0, frame.origin.y, frame.size.width, frame.size.height)];
    }
                     completion:^(BOOL finished){ [[AppDelegate mainAppDelegate]  hideSideMenu]; }];
}




- (void)singleTapScreenShot:(UITapGestureRecognizer *)gestureRecognizer
{
    // on a single tap of the screenshot, assume the user is done viewing the menu
    // and call the slideThenHide function
    [self slideThenHide];
}

/* The following is from http://blog.shoguniphicus.com/2011/06/15/working-with-uigesturerecognizers-uipangesturerecognizer-uipinchgesturerecognizer/ */

-(void)panGestureMoveAround:(UIPanGestureRecognizer *)gesture;
{
    UIView *piece = [gesture view];
    [self adjustAnchorPointForGestureRecognizer:gesture];
    
    if ([gesture state] == UIGestureRecognizerStateBegan || [gesture state] == UIGestureRecognizerStateChanged)
    {
        
        CGPoint translation = [gesture translationInView:[piece superview]];
        
        // I edited this line so that the image view cannont move vertically
        [piece setCenter:CGPointMake([piece center].x + translation.x, [piece center].y)];
        [gesture setTranslation:CGPointZero inView:[piece superview]];
    }
    else if ([gesture state] == UIGestureRecognizerStateEnded)
        [self slideThenHide];
}

- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        UIView *piece = gestureRecognizer.view;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width,
                                              locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperview;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) option_Clicked:(id)sender
{
    [self slideThenHide];
    UIButton* btn = (UIButton*) sender;
    m_iTag = btn.tag;
    [NSTimer scheduledTimerWithTimeInterval:TIME_TO_SHOW_NEW_MAIN_INFO
                                     target:self
                                   selector:@selector(optionClicked:)
                                   userInfo:nil
                                    repeats:NO];

}
- (void) optionClicked:(NSTimer *)timer
{
    NSString* btnClicked = [NSString stringWithFormat:@"%d",m_iTag];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"option_Clicked" object:btnClicked];
}


#pragma mark - Table view data source

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45.f; //height of Mix Header is always 45
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    NSLog(@"Num Sectinos: %d",[[AppDelegate mainAppDelegate].m_CheckOutInfo getCollections].count);
    return [[AppDelegate mainAppDelegate].m_CheckOutInfo getCollections].count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section < [[AppDelegate mainAppDelegate].m_CheckOutInfo getCollections].count)
    {
        NSArray* collection =[ [AppDelegate mainAppDelegate].m_CheckOutInfo getCollections][section];
        return  collection.count;
    }
    else
    {
        return 3;
    }
}

-(NSIndexPath *)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO..
    return indexPath;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < [[AppDelegate mainAppDelegate].m_CheckOutInfo getCollections].count)
    {
        static NSString *CellIdentifier = @"MenuOption_Cell";
        MenuOption_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (cell == nil)
        {
            cell = [[MenuOption_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        NSArray* collection =[ [AppDelegate mainAppDelegate].m_CheckOutInfo getCollections][indexPath.section];
        CheckoutRing* checkoutRing = [collection objectAtIndex:indexPath.row];
        cell.m_Image_Option.hidden = NO;
        cell.m_Image_Option.image = [checkoutRing getImg];
        cell.m_Label_Option.text = [checkoutRing getRingName];
        
        int tag = (indexPath.section + 1)*10;
        tag += indexPath.row;
        cell.m_Button_Option.tag = tag;
        [cell.m_Button_Option addTarget:self action:@selector(option_Clicked:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else{
        static NSString *CellIdentifier = @"MenuOption_Cell";
        MenuOption_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (cell == nil)
        {
            cell = [[MenuOption_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.m_Image_Option.hidden = YES;
        
        if (indexPath.row == 0)
        {
            cell.m_Label_Option.text = NSLocalizedString(@"SHOP",nil);
        }
        if (indexPath.row == 1)
        {
            cell.m_Label_Option.text = NSLocalizedString(@"WEB_ARCHITEXTURE",nil);
        }
        if (indexPath.row == 2)
        {
            cell.m_Label_Option.text = NSLocalizedString(@"CONTACT_US",nil);
        }
        
        int tag = 100 + indexPath.row;
        cell.m_Button_Option.tag = tag;
        [cell.m_Button_Option addTarget:self action:@selector(option_Clicked:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    return nil;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CollectionSection_View* newSection;
    if (section < [[AppDelegate mainAppDelegate].m_CheckOutInfo getCollections].count)
    {
        NSArray* collection =[ [AppDelegate mainAppDelegate].m_CheckOutInfo getCollections][section];
        CheckoutRing* checkoutRing = [collection objectAtIndex:0];
        newSection = [[CollectionSection_View alloc] initWithCollectionName:[checkoutRing getCollectionName]];
    }
    else
    {
        newSection = [[CollectionSection_View alloc] initWithCollectionName:@"ArchiteXture"];
    }
    return newSection;
}



@end
