//
//  ViewController.m
//  achitexture
//
//  Created by DonKikochan on 10/07/13.
//  Copyright (c) 2013 architexture. All rights reserved.
//

//---Imports:---
#import "BarcelonaRingsProfile_VC.h"
//---------------


@interface BarcelonaRingsProfile_VC ()

@end

@implementation BarcelonaRingsProfile_VC



- (void)viewDidLoad
{
    // Do any additional setup after loading the view, typically from a nib.
    m_aBackGround = [[NSArray alloc] initWithObjects:
                        @"HAPPI",           //_01_HAPPINESS
                        @"REFLEX",          //_02_REFLEX
                        @"SKY",             //_03_SKY
                        @"CLOTHING",        //_04_CLOTHING
                        @"FANCY",           //_05_FANCY
                        @"EARTH",           //_06_EARTH
                        nil];
    
    m_aSmallTitle = [[NSArray alloc] initWithObjects:
                        @"HAPPI_TITLE_SMALL.png",           //_01_HAPPINESS
                        @"REFLEX_TITLE_SMALL.png",          //_02_REFLEX
                        @"SKY_TITLE_SMALL.png",             //_03_SKY
                        @"CLOTHING_TITLE_SMALL.png",        //_04_CLOTHING
                        @"FANCY_TITLE_SMALL.png",           //_05_FANCY
                        @"EARTH_TITLE_SMALL.png",           //_06_EARTH
                        nil];
    
    m_aBigTitle = [[NSArray alloc] initWithObjects:
                        @"HAPPI_TITLE_BIG.png",         //_01_HAPPINESS
                        @"REFLEX_TITLE_BIG.png",        //_02_REFLEX
                        @"SKY_TITLE_BIG.png",           //_03_SKY
                        @"CLOTHING_TITLE_BIG.png",      //_04_CLOTHING
                        @"FANCY_TITLE_BIG.png",         //_05_FANCY
                        @"EARTH_TITLE_BIG.png",         //_06_EARTH
                        nil];
    
    
    m_aCarouselImages = [[NSArray alloc] initWithObjects:
                        @"HAPPI_TIRA_IMATGES.png",          //_01_HAPPINESS
                        @"REFLEX_TIRA_IMATGES.png",         //_02_REFLEX
                        @"SKY_TIRA_IMATGES.png",            //_03_SKY
                        @"CLOTHING_TIRA_IMATGES.png",       //_04_CLOTHING
                        @"FANCY_TIRA_IMATGES.png",          //_05_FANCY
                        @"EARTH_TIRA_IMATGES.png",          //_06_EARTH
                        nil];

    
    m_aCarouselProducts = [[NSArray alloc] initWithObjects:
                        @"HAPPI_PRODUCT.png",           //_01_HAPPINESS
                        @"REFLEX_PRODUCT.png",          //_02_REFLEX
                        @"SKY_PRODUCT.png",             //_03_SKY
                        @"CLOTHING_PRODUCT.png",        //_04_CLOTHING
                        @"FANCY_PRODUCT.png",           //_05_FANCY
                        @"EARTH_PRODUCT.png",           //_06_EARTH
                        nil];
    
    
    m_aInfoProfiles = [[NSArray alloc] initWithObjects:
                        NSLocalizedString(@"HAPPI_INFO",nil),           //_01_HAPPINESS
                        NSLocalizedString(@"REFLEX_INFO",nil),          //_02_REFLEX
                        NSLocalizedString(@"SKY_INFO",nil),             //_03_SKY
                        NSLocalizedString(@"CLOTHING_INFO",nil),        //_04_CLOTHING
                        NSLocalizedString(@"FANCY_INFO",nil),           //_05_FANCY
                        NSLocalizedString(@"EARTH_INFO",nil),           //_06_EARTH
                        nil];
    
    
    m_aTitles = [[NSArray alloc] initWithObjects:
                        @"HAPPINESS.png",      //_01_HAPPINESS
                        @"REFLEX.png",         //_02_REFLEX
                        @"SKY.png",            //_03_SKY
                        @"CLOTHING.png",       //_04_CLOTHING
                        @"FANCY.png",          //_05_FANCY
                        @"EARTH.png",          //_06_EARTH
                        nil];

    
    m_aProfileNames = [NSArray arrayWithObjects:
                        _01_HAPPINESS,
                        _02_REFLEX,
                        _03_SKY,
                        _04_CLOTHING,
                        _05_FANCY,
                        _06_EARTH,
                        nil];
    
    
    m_aProfileRing_Views= [[NSArray alloc] initWithObjects:
                        _m_View_Ring_01,    //_01_HAPPINESS
                        _m_View_Ring_02,    //_02_REFLEX
                        _m_View_Ring_03,    //_03_SKY
                        _m_View_Ring_04,    //_04_CLOTHING
                        _m_View_Ring_05,    //_05_FANCY
                        _m_View_Ring_06,    //_06_EARTH
                        nil];
    
    
    m_aMap = [[NSArray alloc] initWithObjects:
                       @"HAPPI_MAP.jpg",        //_01_HAPPINESS
                       @"REFLEX_MAP.jpg",       //_02_REFLEX
                       @"SKY_MAP.jpg",          //_03_SKY
                       @"CLOTHING_MAP.jpg",     //_04_CLOTHING
                       @"FANCY_MAP.jpg",        //_05_FANCY
                       @"EARTH_MAP.jpg",        //_06_EARTH
                       nil];
    
    [super viewDidLoad];
}



- (void) notificationCallback:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"option_Clicked"])
    {
        NSString* index = [notification object];
        int l_iIndex = [index intValue];
        if (l_iIndex >= 10 && l_iIndex<20)
        {
            l_iIndex -= 10;
            NSString* l_sIndex = [NSString stringWithFormat:@"%d",l_iIndex];
            [AppDelegate mainAppDelegate].m_sRingToLoad = l_sIndex;
            RingProfile_View* ringProfileView =m_aProfileRing_Views[l_iIndex];
            [super.m_ScrollView_AllRings scrollRectToVisible:CGRectMake(WIDTH_RING_PROFILE*l_iIndex, 0, WIDTH_RING_PROFILE,ringProfileView.m_ScrollView_Profile.frame.size.height) animated:NO];
        }
        else if (l_iIndex >= 20 && l_iIndex<30)
        {
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_MATERIALS;
            NSString* l_sIndex = [NSString stringWithFormat:@"%d",l_iIndex- 20];
            [AppDelegate mainAppDelegate].m_sRingToLoad = l_sIndex;
            [AppDelegate mainAppDelegate].m_sGoToNewCollection  = @"YES";
            [self.navigationController popViewControllerAnimated:NO];
        }
        else if (l_iIndex >= 30 && l_iIndex<40)
        {
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_PARIS;
            NSString* l_sIndex = [NSString stringWithFormat:@"%d",l_iIndex- 30];
            [AppDelegate mainAppDelegate].m_sRingToLoad = l_sIndex;
            [AppDelegate mainAppDelegate].m_sGoToNewCollection  = @"YES";
            [self.navigationController popViewControllerAnimated:NO];
        }
        else if (l_iIndex >= 40 && l_iIndex<50)
        {
            if (l_iIndex == 40)
            {
                [AppDelegate mainAppDelegate].m_sCollectionToLoad = SP_COLLECTION_DALI;
            }
            else if (l_iIndex == 41)
            {
                [AppDelegate mainAppDelegate].m_sCollectionToLoad = SP_COLLECTION_BORN;
            }
            [AppDelegate mainAppDelegate].m_sRingToLoad = 0;
            [AppDelegate mainAppDelegate].m_sGoToNewCollection  = @"YES";
            [self.navigationController popViewControllerAnimated:NO];
        }
        else if (l_iIndex == 100)
        {
            [self performSegueWithIdentifier:@"FromRingsToCheckout" sender:nil];
        }
        else if (l_iIndex == 101)
        {
            [self performSegueWithIdentifier:@"FromViewController_To_WebLink" sender:@"http://www.architexture-online.com/"];
        }
        else if (l_iIndex == 101)
        {
            //CONTACT US
        }
    }
}

- (IBAction) addShop:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSLog(@"Add Shop: %d",btn.tag);
    switch(btn.tag)
    {
        case 0: //_01_HAPPINESS
        {
            [[AppDelegate mainAppDelegate].m_CheckOutInfo addAmmount:1 ToRing:@"HAPPINESS"];
        }
            break;
        case 1: //_02_REFLEX
        {
            [[AppDelegate mainAppDelegate].m_CheckOutInfo addAmmount:1 ToRing:@"REFLEX"];
        }
            break;
        case 2: //_03_SKY
        {
           [[AppDelegate mainAppDelegate].m_CheckOutInfo addAmmount:1 ToRing:@"SKY"];
        }
            break;

        case 3: //_04_CLOTHING
        {
           [[AppDelegate mainAppDelegate].m_CheckOutInfo addAmmount:1 ToRing:@"CLOTHING"];
        }
            break;

        case 4: //_05_FANCY
        {
           [[AppDelegate mainAppDelegate].m_CheckOutInfo addAmmount:1 ToRing:@"FANCY"];
        }
            break;

        case 5: //_06_EARTH
        {
            [[AppDelegate mainAppDelegate].m_CheckOutInfo addAmmount:1 ToRing:@"EARTH"];
        }
            break;
    }
    [self performSegueWithIdentifier:@"FromRingsToCheckout" sender:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    NSLog(@"Barcelona didReceiveMemoryWarning");
}




@end
