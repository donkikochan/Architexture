//
//  ViewController.m
//  achitexture
//
//  Created by DonKikochan on 10/07/13.
//  Copyright (c) 2013 architexture. All rights reserved.
//

//---Imports:---
#import "ParisRingsProfile_VC.h"
//---------------


@interface ParisRingsProfile_VC ()

@end

@implementation ParisRingsProfile_VC



- (void)viewDidLoad
{
	// Do any additional setup after loading the view, typically from a nib.
    m_aBackGround = [[NSArray alloc] initWithObjects:
                @"FLOWER", //_01_FLOWER
                @"PLACE",  //_02_PLACE
                @"CALME",  //_03_CALME
                @"ANGLE",  //_04_ANGLE
                @"ICONE",  //_05_ICONE
                @"RGB",    //_06_RGB
                nil];
    
    m_aSmallTitle = [[NSArray alloc] initWithObjects:
                @"FLOWER_TITLE_SMALL.png", //_01_FLOWER
                @"PLACE_TITLE_SMALL.png",  //_02_PLACE
                @"CALME_TITLE_SMALL.png",  //_03_CALME
                @"ANGLE_TITLE_SMALL.png",  //_04_ANGLE
                @"ICONE_TITLE_SMALL.png",  //_05_ICONE
                @"RGB_TITLE_SMALL.png",    //_06_RGB
                nil];
    
    m_aBigTitle = [[NSArray alloc] initWithObjects:
                @"FLOWER_TITLE_BIG.png", //_01_FLOWER
                @"PLACE_TITLE_BIG.png",  //_02_PLACE
                @"CALME_TITLE_BIG.png",  //_03_CALME
                @"ANGLE_TITLE_BIG.png",  //_04_ANGLE
                @"ICONE_TITLE_BIG.png",  //_05_ICONE
                @"RGB_TITLE_BIG.png",    //_06_RGB
                nil];
    
    
    m_aCarouselImages = [[NSArray alloc] initWithObjects:
                @"FLOWER_TIRA_IMATGES.png", //_01_FLOWER
                @"PLACE_TIRA_IMATGES.png",  //_02_PLACE
                @"CALME_TIRA_IMATGES.png",  //_03_CALME
                @"ANGLE_TIRA_IMATGES.png",  //_04_ANGLE
                @"ICONE_TIRA_IMATGES.png",  //_05_ICONE
                @"RGB_TIRA_IMATGES.png",    //_06_RGB
                nil];
    
    
    m_aCarouselProducts = [[NSArray alloc] initWithObjects:
                @"FLOWER_PRODUCT.png",  //_01_FLOWER
                @"PLACE_PRODUCT.png",   //_02_PLACE
                @"CALME_PRODUCT.png",   //_03_CALME
                @"ANGLE_PRODUCT.png",   //_04_ANGLE
                @"ICONE_PRODUCT.png",   //_05_ICONE
                @"RGB_PRODUCT.png",     //_06_RGB
                nil];
    
    
    m_aInfoProfiles = [[NSArray alloc] initWithObjects:
                NSLocalizedString(@"FLOWER_INFO",nil),   //_01_FLOWER
                NSLocalizedString(@"PLACE_INFO",nil),   //_02_PLACE
                NSLocalizedString(@"CALME_INFO",nil),   //_03_CALME
                NSLocalizedString(@"ANGLE_INFO",nil),   //_04_ANGLE
                NSLocalizedString(@"ICONE_INFO",nil),   //_05_ICONE
                NSLocalizedString(@"RGB_INFO",nil),     //_06_RGB
                nil];
    
    
    m_aTitles = [[NSArray alloc] initWithObjects:
                @"FLOWER.png",  //_01_FLOWER
                @"PLACE.png",   //_02_PLACE
                @"CALME.png",   //_03_CALME
                @"ANGLE.png",   //_04_ANGLE
                @"ICONE.png",   //_05_ICONE
                @"RGB.png",     //_06_RGB
                nil];
    
    
    m_aProfileNames = [NSArray arrayWithObjects:
                _13_FLOWER,
                _14_PLACE,
                _15_CALME,
                _16_ANGLE,
                _17_ICONE,
                _18_RGG,
                nil];
    
    m_aProfileRing_Views= [[NSArray alloc] initWithObjects:
                _m_View_Ring_01,    //_01_FLOWER
                _m_View_Ring_02,    //_02_PLACE
                _m_View_Ring_03,    //_03_CALME
                _m_View_Ring_04,    //_04_ANGLE
                _m_View_Ring_05,    //_05_ICONE
                _m_View_Ring_06,    //_06_RGB
                nil];
    
    
    m_aMap = [[NSArray alloc] initWithObjects:
                @"FLOWER_MAP.jpg",  //_01_FLOWER
                @"PLACE_MAP.jpg",   //_02_PLACE
                @"CALME_MAP.jpg",   //_03_CALME
                @"ANGLE_MAP.jpg",   //_04_ANGLE
                @"ICONE_MAP.jpg",   //_05_ICONE
                @"RGB_MAP.jpg",     //_06_RGB
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
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_MATERIALS;
            NSString* l_sIndex = [NSString stringWithFormat:@"%d",l_iIndex- 20];
            [AppDelegate mainAppDelegate].m_sRingToLoad = l_sIndex;
            [AppDelegate mainAppDelegate].m_sGoToNewCollection  = @"YES";
            [self.navigationController popViewControllerAnimated:NO];
        }
        else if (l_iIndex >= 30 && l_iIndex<40)
        {
            l_iIndex -= 30;
            NSString* l_sIndex = [NSString stringWithFormat:@"%d",l_iIndex];
            [AppDelegate mainAppDelegate].m_sRingToLoad = l_sIndex;
            RingProfile_View* ringProfileView =m_aProfileRing_Views[l_iIndex];
            [super.m_ScrollView_AllRings scrollRectToVisible:CGRectMake(WIDTH_RING_PROFILE*l_iIndex, 0, WIDTH_RING_PROFILE , ringProfileView.m_ScrollView_Profile.frame.size.height) animated:NO];
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
        else if (l_iIndex == 102)
        {
            //CONTACT US
            [self performSegueWithIdentifier:@"FromRingProfileToAboutUs" sender:nil];
        }
        else if (l_iIndex == 103)
        {
            //CONTACT US
            [self performSegueWithIdentifier:@"FromRingProfileToContactUs" sender:nil];
        }
        else if (l_iIndex == 104)
        {
            //FACEBOOK WEB
            [self performSegueWithIdentifier:@"FromViewController_To_WebLink" sender:@"https://www.facebook.com/pages/architexture-online/399183696843071"];
        }
        else if (l_iIndex == 105)
        {
            //TWITTER WEB
            [self performSegueWithIdentifier:@"FromViewController_To_WebLink" sender:@"https://twitter.com/rchitexture"];
        }
        else if (l_iIndex == 106)
        {
            //I LIKE..
        }
    }
}


- (IBAction) addShop:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSLog(@"Add Shop: %d",btn.tag);
    switch(btn.tag)
    {
        case 0: //_01_FLOWER
        {
            [[AppDelegate mainAppDelegate].m_CheckOutInfo addAmmount:1 ToRing:@"FLOWER"];
            [[AppDelegate mainAppDelegate].m_CheckOutInfo jumpToRing:@"FLOWER"];
        }
            break;
        case 1: //_02_PLACE
        {
            [[AppDelegate mainAppDelegate].m_CheckOutInfo addAmmount:1 ToRing:@"PLACE"];
            [[AppDelegate mainAppDelegate].m_CheckOutInfo jumpToRing:@"PLACE"];
        }
            break;
        case 2: //_03_CALME
        {
            [[AppDelegate mainAppDelegate].m_CheckOutInfo addAmmount:1 ToRing:@"CALME"];
            [[AppDelegate mainAppDelegate].m_CheckOutInfo jumpToRing:@"CALME"];
        }
            break;
            
        case 3: //_04_ANGLE
        {
            [[AppDelegate mainAppDelegate].m_CheckOutInfo addAmmount:1 ToRing:@"ANGLE"];
            [[AppDelegate mainAppDelegate].m_CheckOutInfo jumpToRing:@"ANGLE"];
        }
            break;
            
        case 4: //_05_ICONE
        {
            [[AppDelegate mainAppDelegate].m_CheckOutInfo addAmmount:1 ToRing:@"ICONE"];
            [[AppDelegate mainAppDelegate].m_CheckOutInfo jumpToRing:@"ICONE"];
        }
            break;
            
        case 5: //_06_RGB
        {
            [[AppDelegate mainAppDelegate].m_CheckOutInfo addAmmount:1 ToRing:@"RGB"];
            [[AppDelegate mainAppDelegate].m_CheckOutInfo jumpToRing:@"RGB"];
        }
            break;
    }
    [self performSegueWithIdentifier:@"FromRingsToCheckout" sender:nil];
}

- (IBAction) viewMap:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSLog(@"ViewMap: %d",12+btn.tag);
    [AppDelegate mainAppDelegate].m_sMapRing = [NSString stringWithFormat:@"%d",12+btn.tag];
    [self performSegueWithIdentifier:@"FromViewController_To_MapView" sender:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"Materials didReceiveMemoryWarning");
}


//---Functions:
- (void) PostOnFacebook
{
    switch (m_iTagButtonFacebookImage)
    {
        case 0://_01_FLOWER
            m_sTagButtonFacebookImage = @"DISPLAY X EXPOSITOR FLOWER.jpg";
            m_sTagButtonFacebookText    = NSLocalizedString(@"FACEBOOK_FLOWER",nil);
            break;
        case 1://_02_PLACE
            m_sTagButtonFacebookImage = @"DISPLAY PLACE.jpg";
            m_sTagButtonFacebookText    = NSLocalizedString(@"FACEBOOK_PLACE",nil);
            break;
        case 2://_03_CALME
            m_sTagButtonFacebookImage = @"DISPLAY CALME.jpg";
            m_sTagButtonFacebookText    = NSLocalizedString(@"FACEBOOK_CALME",nil);
            break;
        case 3://_04_ANGLE
            m_sTagButtonFacebookImage = @"DISPLA ANGLE.jpg";
            m_sTagButtonFacebookText    = NSLocalizedString(@"FACEBOOK_ANGLE",nil);
            break;
        case 4://_05_ICONE
            m_sTagButtonFacebookImage = @"DISPLAY X EXPOSITOR LIGHT.jpg";
            m_sTagButtonFacebookText    = NSLocalizedString(@"FACEBOOK_LIGHT",nil);
            break;
        case 5://_06_RGB
            m_sTagButtonFacebookImage = @"DISPLAY ICONE.jpg";
            m_sTagButtonFacebookText    = NSLocalizedString(@"FACEBOOK_ICONE",nil);
            break;
        default:
            break;
    }
    [super PostOnFacebook];
}


- (void) PostOnTwitter
{
    switch (m_iTagButtonFacebookImage)
    {
        case 0://_01_FLOWER
            m_sTagButtonFacebookImage = @"DISPLAY X EXPOSITOR FLOWER.jpg";
            m_sTagButtonFacebookText    = NSLocalizedString(@"FACEBOOK_FLOWER",nil);
            break;
        case 1://_02_PLACE
            m_sTagButtonFacebookImage = @"DISPLAY PLACE.jpg";
            m_sTagButtonFacebookText    = NSLocalizedString(@"FACEBOOK_PLACE",nil);
            break;
        case 2://_03_CALME
            m_sTagButtonFacebookImage = @"DISPLAY CALME.jpg";
            m_sTagButtonFacebookText    = NSLocalizedString(@"FACEBOOK_CALME",nil);
            break;
        case 3://_04_ANGLE
            m_sTagButtonFacebookImage = @"DISPLA ANGLE.jpg";
            m_sTagButtonFacebookText    = NSLocalizedString(@"FACEBOOK_ANGLE",nil);
            break;
        case 4://_05_ICONE
            m_sTagButtonFacebookImage = @"DISPLAY X EXPOSITOR LIGHT.jpg";
            m_sTagButtonFacebookText    = NSLocalizedString(@"FACEBOOK_LIGHT",nil);
            break;
        case 5://_06_RGB
            m_sTagButtonFacebookImage = @"DISPLAY ICONE.jpg";
            m_sTagButtonFacebookText    = NSLocalizedString(@"FACEBOOK_ICONE",nil);
            break;
        default:
            break;
    }

    [super PostOnTwitter];
}

@end
