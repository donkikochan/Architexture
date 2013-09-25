//
//  ViewController.m
//  achitexture
//
//  Created by DonKikochan on 10/07/13.
//  Copyright (c) 2013 architexture. All rights reserved.
//

//---Imports:---
#import "MaterialsRingsProfile_VC.h"
//---------------


@interface MaterialsRingsProfile_VC ()

@end

@implementation MaterialsRingsProfile_VC


- (void)viewDidLoad
{

	// Do any additional setup after loading the view, typically from a nib.
    m_aBackGround = [[NSArray alloc] initWithObjects:
                    @"RHYTHM",          //_01_RHYTHM
                    @"TRANSPARENCY",    //_02_TRANSPARENCY
                    @"GOLD",            //_03_GOLD
                    @"COLOURS",         //_04_COLOURS
                    @"LIGHT",           //_05_LIGHT
                    @"MOUNTAIN",        //_06_MOUNTAIN
                    nil];
    
    m_aSmallTitle = [[NSArray alloc] initWithObjects:
                    @"RHYTHM_TITLE_SMALL.png",          //_01_RHYTHM
                    @"TRANSPARENCY_TITLE_SMALL.png",    //_02_TRANSPARENCY
                    @"GOLD_TITLE_SMALL.png",            //_03_GOLD
                    @"COLOURS_TITLE_SMALL.png",         //_04_COLOURS
                    @"LIGHT_TITLE_SMALL.png",           //_05_LIGHT
                    @"MOUNTAIN_TITLE_SMALL.png",        //_06_MOUNTAIN
                    nil];
    
    m_aBigTitle = [[NSArray alloc] initWithObjects:
                   @"RHYTHM_TITLE_BIG.png",        //_01_RHYTHM
                   @"TRANSPARENCY_TITLE_BIG.png",  //_02_TRANSPARENCY
                   @"GOLD_TITLE_BIG.png",          //_03_GOLD
                   @"COLOURS_TITLE_BIG.png",       //_04_COLOURS
                   @"LIGHT_TITLE_BIG.png",         //_05_LIGHT
                   @"MOUNTAIN_TITLE_BIG.png",      //_06_MOUNTAIN
                   nil];
    
    
    m_aCarouselImages = [[NSArray alloc] initWithObjects:
                    @"RHYTHM_TIRA_IMATGES.png",         //_01_RHYTHM
                    @"TRANSPARENCY_TIRA_IMATGES.png",   //_02_TRANSPARENCY
                    @"GOLD_TIRA_IMATGES.png",           //_03_GOLD
                    @"COLOURS_TIRA_IMATGES.png",        //_04_COLOURS
                    @"LIGHT_TIRA_IMATGES.png",          //_05_LIGHT
                    @"MOUNTAIN_TIRA_IMATGES.png",       //_06_MOUNTAIN
                    nil];
    
    
    m_aCarouselProducts = [[NSArray alloc] initWithObjects:
                    @"RHYTHM_PRODUCT.png",          //_01_RHYTHM
                    @"TRANSPARENCY_PRODUCT.png",    //_02_TRANSPARENCY
                    @"GOLD_PRODUCT.png",            //_03_GOLD
                    @"COLOURS_PRODUCT.png",         //_04_COLOURS
                    @"LIGHT_PRODUCT.png",           //_05_LIGHT
                    @"MOUNTAIN_PRODUCT.png",        //_06_MOUNTAIN
                    nil];
    
    
    m_aInfoProfiles = [[NSArray alloc] initWithObjects:
                    NSLocalizedString(@"RHYTHM_INFO",nil),          //_01_RHYTHM
                    NSLocalizedString(@"TRANSPARENCY_INFO",nil),    //_02_TRANSPARENCY
                    NSLocalizedString(@"GOLD_INFO",nil),            //_03_GOLD
                    NSLocalizedString(@"COLOURS_INFO",nil),         //_04_COLOURS
                    NSLocalizedString(@"LIGHT_INFO",nil),           //_05_LIGHT
                    NSLocalizedString(@"MOUNTAIN_INFO",nil),        //_06_MOUNTAIN
                    nil];
    
    
    m_aTitles = [[NSArray alloc] initWithObjects:
                    @"RHYTHM.png",         //_01_RHYTHM
                    @"TRANSPARENCY.png",   //_02_TRANSPARENCY
                    @"GOLD.png",           //_03_GOLD
                    @"COLOURS.png",        //_04_COLOURS
                    @"LIGHT.png",          //_05_LIGHT
                    @"MOUNTAIN.png",       //_06_MOUNTAIN
                    nil];
    
    
    m_aProfileNames = [NSArray arrayWithObjects:
                    _07_RHYTHM,
                    _08_TRANSPARENCY,
                    _09_GOLD,
                    _10_COLOURS,
                    _11_LIGHT,
                    _12_MOUNTAIN,
                    nil];
    
    
    m_aProfileRing_Views= [[NSArray alloc] initWithObjects:
                    _m_View_Ring_01,    //_01_RHYTHM
                    _m_View_Ring_02,    //_02_TRANSPARENCY
                    _m_View_Ring_03,    //_03_GOLD
                    _m_View_Ring_04,    //_04_COLOURS
                    _m_View_Ring_05,    //_05_LIGHT
                    _m_View_Ring_06,    //_06_MOUNTAIN
                    nil];
    
    
    m_aMap = [[NSArray alloc] initWithObjects:
              @"RHYTHM_MAP.jpg",        //_01_RHYTHM
              @"TRANSPARENCY_MAP.jpg",  //_02_TRANSPARENCY
              @"GOLD_MAP.jpg",          //_03_GOLD
              @"COLOURS_MAP.jpg",       //_04_COLOURS
              @"LIGHT_MAP.jpg",         //_05_LIGHT
              @"MOUNTAIN_MAP.jpg",      //_06_MOUNTAIN
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
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_BARCELONA;
            NSString* l_sIndex = [NSString stringWithFormat:@"%d",l_iIndex- 10];
            [AppDelegate mainAppDelegate].m_sRingToLoad = l_sIndex;
            [AppDelegate mainAppDelegate].m_sGoToNewCollection  = @"YES";
            [self.navigationController popViewControllerAnimated:NO];
        }
        else if (l_iIndex >= 20 && l_iIndex<30)
        {
            l_iIndex -= 20;
            NSString* l_sIndex = [NSString stringWithFormat:@"%d",l_iIndex];
            [AppDelegate mainAppDelegate].m_sRingToLoad = l_sIndex;
            RingProfile_View* ringProfileView =m_aProfileRing_Views[l_iIndex];
            [super.m_ScrollView_AllRings scrollRectToVisible:CGRectMake(WIDTH_RING_PROFILE*l_iIndex, 0, WIDTH_RING_PROFILE , ringProfileView.m_ScrollView_Profile.frame.size.height) animated:NO];
        }
        else if (l_iIndex >= 30 && l_iIndex<40)
        {
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_PARIS;
            NSString* l_sIndex = [NSString stringWithFormat:@"%d",l_iIndex- 30];
            [AppDelegate mainAppDelegate].m_sRingToLoad = l_sIndex;
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"Materials didReceiveMemoryWarning");
}

@end