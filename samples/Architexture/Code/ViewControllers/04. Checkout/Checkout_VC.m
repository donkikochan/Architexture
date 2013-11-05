//
//  Checkout_VC.m
//  ArchiteXture
//
//  Created by DonKikochan on 27/07/13.
//
//

//---Imports:--
#import "Checkout_VC.h"
#import "Checkout_Cell.h"
#import "CheckoutRing.h"
#import "CollectionSection_View.h"
//-------------

@interface Checkout_VC ()

@end

@implementation Checkout_VC

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
    
    m_fTotalPrize = 0;
    m_fRingPrize = RING_PRIZE;
    m_iTotalAmmount = 0;
    
    //----Localize Labels:----
    _m_Label_Title.text         = NSLocalizedString(@"CHECKOUT",nil);
    _m_Label_Total.text         = NSLocalizedString(@"TOTAL_AUX",nil);
    _m_Label_NotShipping.text   = NSLocalizedString(@"NOT_SHIPPING",nil);
    [_m_Button_Back setTitle:NSLocalizedString(@"BACK",nil) forState:UIControlStateNormal];
    [_m_Button_Clear setTitle:NSLocalizedString(@"CLEAR",nil) forState:UIControlStateNormal];
    [_m_Button_Order setTitle:NSLocalizedString(@"NEXT",nil) forState:UIControlStateNormal];
    //-------------------------
    
    [self calculateAmmounts];
    [self setLabels];
    
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

- (void) calculateAmmounts
{
    m_iTotalAmmount = [[AppDelegate mainAppDelegate].m_CheckOutInfo getNumBuyedRings];
    m_fTotalPrize = m_iTotalAmmount * m_fRingPrize;
}

- (void) setLabels
{
    _m_Label_TotalAmmount.text  = [NSString stringWithFormat:@"%d",m_iTotalAmmount];
    _m_Label_RingPrize.text     = [NSString stringWithFormat:@"x (%d€) =",(int)m_fRingPrize];
    _m_Label_TotalPrize.text    = [NSString stringWithFormat:@"%d €",(int)m_fTotalPrize];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setM_TableView:nil];
    [self setM_Button_Clear:nil];
    [self setM_Button_Order:nil];
    [self setM_Label_TotalAmmount:nil];
    [self setM_Label_RingPrize:nil];
    [self setM_Label_Total:nil];
    [self setM_Label_TotalPrize:nil];
    [super viewDidUnload];
}


- (IBAction) back_Clicked:(id)sender
{
    [[AppDelegate mainAppDelegate] setOpenMenu];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) clear_Clicked:(id)sender
{
    [[AppDelegate mainAppDelegate].m_CheckOutInfo resetRings];
    [self calculateAmmounts];
    [self setLabels];
    [_m_TableView reloadData];
}

- (IBAction) order_Clicked:(id)sender
{
    if (m_iTotalAmmount == 0)
    {
     
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:NSLocalizedString(@"WARNING",nil)
                              message:NSLocalizedString(@"AT_LEAST_ONE_RING",nil)
                              delegate:self
                              cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil,nil];
        [alert show];
    }
    else
    {
        [self performSegueWithIdentifier:@"FromChechOutToDelivaryAddress" sender:nil];
    }
}



- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(notificationCallback:)
												 name:nil
											   object:nil ];
    
    m_sRingToJump = [[AppDelegate mainAppDelegate].m_CheckOutInfo getRingToJump];
    
}



- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:nil
                                                  object:nil];
    
    [super viewDidDisappear:animated];
}


- (void) notificationCallback:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"CheckoutCell_imageClicked"])
    {
        //NSString* ID = [notification object];
        //TODO..
    }
    else if ([[notification name] isEqualToString:@"CheckoutCell_addClicked"])
    {
        NSString* ID = [notification object];
        [[AppDelegate mainAppDelegate].m_CheckOutInfo addAmmount:1 ToRing:ID];
        [self calculateAmmounts];
        [self setLabels];
        
        [_m_TableView reloadData];
    }
    else if ([[notification name] isEqualToString:@"CheckoutCell_removeClicked"])
    {
        NSString* ID = [notification object];
        [[AppDelegate mainAppDelegate].m_CheckOutInfo addAmmount:-1 ToRing:ID];
        [self calculateAmmounts];
        [self setLabels];
        [_m_TableView reloadData];
    }
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
    NSLog(@"Num Sections: %d",[[AppDelegate mainAppDelegate].m_CheckOutInfo getCollectionsToShop].count);
    return [[AppDelegate mainAppDelegate].m_CheckOutInfo getCollectionsToShop].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* collection =[ [AppDelegate mainAppDelegate].m_CheckOutInfo getCollectionsToShop][section];
    return  collection.count;
}

-(NSIndexPath *)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO..
    return indexPath;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Checkout_Cell";
    Checkout_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil)
    {
        cell = [[Checkout_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSArray* collection =[ [AppDelegate mainAppDelegate].m_CheckOutInfo getCollectionsToShop][indexPath.section];
    CheckoutRing* checkoutRing = [collection objectAtIndex:indexPath.row];
    
    [cell.m_Button_PhotoRing setBackgroundImage:[checkoutRing getImg] forState:UIControlStateNormal];
    cell.m_Label_Ammount.text = [NSString stringWithFormat:@"%d",[checkoutRing getAmmount]];
    cell.m_Label_Quantity.text = [NSString stringWithFormat:@"%@:",[checkoutRing getRingName]];
    [cell setId:[checkoutRing getRingName]];
    
    
  
    if ([m_sRingToJump isEqualToString:[checkoutRing getRingName]])
    {
        m_IndexPathToJump = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    }
    
    int numSections = [[AppDelegate mainAppDelegate].m_CheckOutInfo getCollectionsToShop].count;
    if (indexPath.section == numSections - 1)
    {
        int numRows = collection.count;
        if (indexPath.row == numRows - 1)
        {
            if (![m_sRingToJump isEqualToString:@""])
            {
                [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(jumpToRing) userInfo:nil repeats:NO];
            }
        }
    }
    
    return cell;
}

- (void) jumpToRing
{
    [_m_TableView scrollToRowAtIndexPath:m_IndexPathToJump
                         atScrollPosition:UITableViewScrollPositionMiddle
                                 animated:YES];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray* collection =[ [AppDelegate mainAppDelegate].m_CheckOutInfo getCollectionsToShop][section];
    CheckoutRing* checkoutRing = [collection objectAtIndex:0];
    CollectionSection_View* newSection = [[CollectionSection_View alloc] initWithCollectionName:[checkoutRing getCollectionName]];
    return newSection;
}

@end
