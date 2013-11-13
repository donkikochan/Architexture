//
//  RingProfile_VC.m
//  Architexture
//
//  Created by DonKikochan on 24/09/13.
//
//


//---Imports:---
#import "RingProfile_VC.h"
#import "ViewLink_VC.h"
#import <QuartzCore/QuartzCore.h>
//---------------

@interface RingProfile_VC ()

@end

#define TIME_SCROLL_IMAGES  100.f
#define TITLE_MIN_Y         347.f
#define TITLE_MAX_Y         425.f


@implementation RingProfile_VC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    m_bMoveCarouselImages   = YES;
    m_bMoveCarouselProducts = YES;
    
    m_bMenuClicked = NO;
    [_m_ScrollView_AllRings setContentSize:CGSizeMake(WIDTH_RING_PROFILE * m_aProfileRing_Views.count, 1.f)];
    [_m_ScrollView_AllRings setDelegate: self];
    [_m_ScrollView_AllRings setScrollEnabled:YES];
    _m_ScrollView_AllRings.bounces = NO;
    
    
    //UIImage* image = [UIImage imageNamed:NSLocalizedString(@"HAPPI_INFO",nil)];
    //float height_InfoRing = image.size.height;
    
    for (int i=0; i < m_aProfileRing_Views.count; i++)
    {
        //---- Configurar la posicio de la view en el scrollview Generic:
        RingProfile_View* ringProfileView =m_aProfileRing_Views[i];
        ringProfileView.m_ScrollView_Profile.tag = i;
        CGRect frame = ringProfileView.frame;
        frame.origin.x = WIDTH_RING_PROFILE*i;
        [ringProfileView setFrame:frame];
        
        
        //---- Configurar el scrollview de cada Ring Profile
        float height = _m_ScrollView_AllRings.frame.size.height;
        [ringProfileView.m_ScrollView_Profile setContentSize:CGSizeMake(1.f, 2095+height)];
        [ringProfileView.m_ScrollView_Profile setDelegate: self];
        [ringProfileView.m_ScrollView_Profile setScrollEnabled:YES];
        
        
        //---- Configurar la imatge inicial background de cada Ring Profile:
        NSString * name = m_aBackGround[i];
        ringProfileView.m_Image_Background.image        = [UIImage imageNamed:[NSString stringWithFormat:@"%@00.jpg",name]];
        ringProfileView.m_Image_Background_AUX.image    = [UIImage imageNamed:[NSString stringWithFormat:@"%@19.jpg",name]];
        ringProfileView.m_Image_Background_AUX.alpha = 0.f;
        
        
        //---- Configure Titles:
        ringProfileView.m_Image_Title.image = [UIImage imageNamed:m_aTitles[i]];
        
        
        //---- Configure Menu Button:
        [ringProfileView.m_Button_GoToMenu addTarget:self action:@selector(menu_Clicked:) forControlEvents:UIControlEventTouchDown];
        
        
        //---- Configure Carousels Image/Producte i l'scrollview que conte les imatges:
        UIImage *img = [UIImage imageNamed:m_aCarouselImages[i]];
        ringProfileView.m_Image_Carousel.image = img;
        [ringProfileView.m_ScrollView_Carousel setContentSize:CGSizeMake(1413, 1.f)];
        
        
        img = [UIImage imageNamed:m_aCarouselProducts[i]];
        ringProfileView.m_Image_Product.image = img;
        [ringProfileView.m_ScrollView_Product setContentSize:CGSizeMake(1091, 1.f)];
        
        
        
        [ringProfileView.m_ScrollView_Product setDelegate: self];
        [ringProfileView.m_ScrollView_Carousel setDelegate: self];
        ringProfileView.m_ScrollView_Product.tag    = 999;
        ringProfileView.m_ScrollView_Carousel.tag   = 888;
        
        
        //---- Configure Info Image:
        ringProfileView.m_Image_Info.image = [UIImage imageNamed:m_aInfoProfiles[i]];
        
        
        //---- Configure Button More Info:
        ringProfileView.m_Button_SeeMoreInfo.tag = i;
        [ringProfileView.m_Button_SeeMoreInfo addTarget:self action:@selector(moreInfo_Clicked:) forControlEvents:UIControlEventTouchDown];
        
        
        //---- Configure Small and Big Title:
        ringProfileView.m_Image_TitleBig.image      = [UIImage imageNamed:m_aBigTitle[i]];
        ringProfileView.m_Image_TitleSmall.image    = [UIImage imageNamed:m_aSmallTitle[i]];
        ringProfileView.m_Image_TitleSmall.alpha    = 0.f;
        ringProfileView.m_Image_TitleBig.alpha      = 1.f;
        
        
        //---- Configure Button Architexture WEB:¡
        [ringProfileView.m_Button_Architexture_Online addTarget:self action:@selector(viewArchitextureWeb:) forControlEvents:UIControlEventTouchDown];
        
        
        //---- Configure Button Shop:
        ringProfileView.m_Button_Shop.tag = i;
        [ringProfileView.m_Button_Shop addTarget:self action:@selector(addShop:) forControlEvents:UIControlEventTouchDown];
        [ringProfileView.m_Button_Shop setTitle:NSLocalizedString(@"ADD_TO_CART",nil) forState:UIControlStateNormal];
        
        
        //---- Configure Image Map:
        ringProfileView.m_Image_Map.image = [UIImage imageNamed:m_aMap[i]];
        
        //---- Configure Button Map:
        ringProfileView.m_Button_MapView.tag = i;
        [ringProfileView.m_Button_MapView addTarget:self action:@selector(viewMap:) forControlEvents:UIControlEventTouchDown];
        
        ringProfileView.m_Button_Facebook.tag = i;
        ringProfileView.m_Button_Twitter.tag = i;
        [ringProfileView.m_Button_Facebook addTarget:self action:@selector(showActionSheetFacebook:) forControlEvents:UIControlEventTouchDown];
        [ringProfileView.m_Button_Twitter addTarget:self action:@selector(showActionSheetTwitter:) forControlEvents:UIControlEventTouchDown];
    }
    
    
    
    m_bFinishedJump = NO;
    
    //GO TO RING PROFILE in pos ringIndex
    int ringIndex = 0; //from [0 to m_aProfileRing_Views.count-1]
    RingProfile_View* ringProfileView =m_aProfileRing_Views[0];
    [_m_ScrollView_AllRings scrollRectToVisible:CGRectMake(WIDTH_RING_PROFILE*ringIndex, 0, WIDTH_RING_PROFILE , ringProfileView.m_ScrollView_Profile.frame.size.height) animated:NO];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
    {
        // iOS 7
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (void) addInfoRings
{
    NSString* showRingoInfo = [ECommon getUserDefaultValueStringForKey:SHOW_RING_INFO];
    if (showRingoInfo == nil || [showRingoInfo isEqualToString:@""])
    {
        m_aInfoRings = [[NSMutableArray alloc]init];
        for (int i=0; i < m_aProfileRing_Views.count; i++)
        {
            //---- Configurar la posicio de la view en el scrollview Generic:
            RingProfile_View* ringProfileView =m_aProfileRing_Views[i];
            
            float posX = (320*0.5) - (187*0.5);
            CGRect rect = CGRectMake(posX, 20, 187, 151);
            InfoRings* l_InfoRings = [[InfoRings alloc] initWithFrame:rect];
            CALayer * l = l_InfoRings.layer;
            [l setMasksToBounds:YES];
            [l setCornerRadius:5.0];
            [m_aInfoRings addObject:l_InfoRings];
            
            [ringProfileView.m_ScrollView_Profile addSubview:l_InfoRings];
            [l_InfoRings setFrame:rect];
        }
    }
}

-(UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidDisappear:(BOOL)animated;
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:nil
                                                  object:nil];
    
    [super viewDidDisappear:animated];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([[AppDelegate mainAppDelegate] haveToOpenMenu])
    {
        m_bMenuClicked = YES;
        [[AppDelegate mainAppDelegate] showSideMenu];
    }
    
    [self addInfoRings];
    m_bFinishedJump = YES;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(notificationCallback:)
												 name:nil
											   object:nil ];
    
    
    m_bMoveCarouselImages   = YES;
    m_bMoveCarouselProducts = YES;
    //[self moveCarousels];
    
    
    if ([[AppDelegate mainAppDelegate].m_sGoToNewCollection isEqualToString:@"YES"])
    {
        int l_index = [[AppDelegate mainAppDelegate].m_sRingToLoad intValue];
        RingProfile_View* ringProfileView =m_aProfileRing_Views[l_index];
        [_m_ScrollView_AllRings scrollRectToVisible:CGRectMake(WIDTH_RING_PROFILE*l_index, 0, WIDTH_RING_PROFILE ,ringProfileView.m_ScrollView_Profile.frame.size.height) animated:NO];
        
        [AppDelegate mainAppDelegate].m_sGoToNewCollection = @"NO";
    }
    
}

- (void) moveCarousels
{
    for (int i = 0; i < m_aProfileRing_Views.count; i++)
    {
        RingProfile_View* ringProfileView = m_aProfileRing_Views[i];
        UIImage *img = [UIImage imageNamed:m_aCarouselImages[i]];
        ringProfileView.m_ScrollView_Carousel.contentOffset = CGPointMake(0.f, 0.f);
        [UIView animateWithDuration:TIME_SCROLL_IMAGES
                              delay:0
                            options: UIViewAnimationCurveLinear | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse
                         animations:^{
                             ringProfileView.m_ScrollView_Carousel.contentOffset = CGPointMake(img.size.width - ringProfileView.m_ScrollView_Carousel.frame.size.width, 0.f);
                         }
                         completion:^(BOOL finished) {
                             
                             
                         }];
        
        
        img = [UIImage imageNamed:m_aCarouselProducts[i]];
        ringProfileView.m_ScrollView_Product.contentOffset = CGPointMake(0.f, 0.f);
        [UIView animateWithDuration:TIME_SCROLL_IMAGES
                              delay:0
                            options: UIViewAnimationCurveLinear | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse
                         animations:^{
                             ringProfileView.m_ScrollView_Product.contentOffset = CGPointMake(img.size.width - ringProfileView.m_ScrollView_Product.frame.size.width, 0.f);
                         }
                         completion:^(BOOL finished) {
                             
                         }];
        
    }
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    /*
    for (int i = 0; i < m_aProfileRing_Views.count; i++)
    {
        RingProfile_View* ringProfileView = m_aProfileRing_Views[i];
        [ringProfileView.m_ScrollView_Carousel.layer removeAllAnimations];
    }
    for (int i = 0; i < m_aProfileRing_Views.count; i++)
    {
        RingProfile_View* ringProfileView = m_aProfileRing_Views[i];
        [ringProfileView.m_ScrollView_Product.layer removeAllAnimations];
    }
     */
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    int tag = scrollView.tag;
    
    if (tag == 888 || tag == 999)
    {
        return;
    }
    
    
    if (tag>= 0 && tag<= m_aProfileRing_Views.count)
    {
        NSString* showRingoInfo = [ECommon getUserDefaultValueStringForKey:SHOW_RING_INFO];
        if (m_bFinishedJump && (showRingoInfo == nil || [showRingoInfo isEqualToString:@""]))
        {
            [ECommon setUserDefaultString:@"NO" forKey:SHOW_RING_INFO];
            for(InfoRings*infoRing in m_aInfoRings)
            {
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1.f];
                [UIView setAnimationDelay:0.0];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                infoRing.alpha = 0.f;
                [UIView commitAnimations];
            }
        }

        
        for (int i = 0; i < m_aProfileRing_Views.count; i++)
        {
            RingProfile_View* ringProfileView = m_aProfileRing_Views[i];
            ringProfileView.m_ScrollView_Profile.delegate = nil;
            [ringProfileView.m_ScrollView_Profile setContentOffset:scrollView.contentOffset];
            UIImageView*image = ringProfileView.m_Image_Background;
            UIImageView*image_aux = ringProfileView.m_Image_Background_AUX;
            
            //---Move image vertically:
            CGRect frame = image.frame;
            frame.origin.y = 0;
            
            if (scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < 300.f)
            {
                float value = scrollView.contentOffset.y /300.f; //value from 0 to 1.
                frame.origin.y = -value*20;
                image.frame = frame;
                image_aux.frame = frame;
            }
            
            if (scrollView.contentOffset.y < TITLE_MIN_Y)
            {
                ringProfileView.m_Image_TitleBig.alpha      = 1.f;
                ringProfileView.m_Image_TitleSmall.alpha    = 0.f;
            }
            
            if (scrollView.contentOffset.y >= TITLE_MIN_Y && scrollView.contentOffset.y <= TITLE_MAX_Y)
            {
                float value = (scrollView.contentOffset.y - TITLE_MIN_Y)/(TITLE_MAX_Y-TITLE_MIN_Y); //value from 0 to 1.
                if (value <= 0.5)
                {
                    ringProfileView.m_Image_TitleBig.alpha      = 1.f -(value * 2.f);
                    ringProfileView.m_Image_TitleSmall.alpha    = 0.f;
                }
                else{
                    ringProfileView.m_Image_TitleBig.alpha      = 1.f - (value * 2.f);
                    ringProfileView.m_Image_TitleSmall.alpha    = (value - 0.5f) * 2.f;
                }
            }
            
            if (scrollView.contentOffset.y > TITLE_MAX_Y)
            {
                ringProfileView.m_Image_TitleBig.alpha      = 0.f;
                ringProfileView.m_Image_TitleSmall.alpha    = 1.f;
            }
        }
        
        [self configureFilterAtIndex:tag];
        
        for (int i = 0; i < m_aProfileRing_Views.count; i++)
        {
            RingProfile_View* ringProfileView = m_aProfileRing_Views[i];
            ringProfileView.m_ScrollView_Profile.delegate = self;
        }
        
    }
    
    
    if (tag == 666)
    {
        NSString* showRingoInfo = [ECommon getUserDefaultValueStringForKey:SHOW_RING_INFO];
        if (m_bFinishedJump && (showRingoInfo == nil || [showRingoInfo isEqualToString:@""]))
        {
            [ECommon setUserDefaultString:@"NO" forKey:SHOW_RING_INFO];
            for(InfoRings*infoRing in m_aInfoRings)
            {
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1.f];
                [UIView setAnimationDelay:0.0];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                infoRing.alpha = 0.f;
                [UIView commitAnimations];
            }
        }
        
        
        //---Move image horizontally:
        for (int i = 0; i < m_aProfileRing_Views.count; i++)
        {
            if (scrollView.contentOffset.x >= WIDTH_RING_PROFILE*i && scrollView.contentOffset.x < WIDTH_RING_PROFILE*(i+1))
            {
                if( i<m_aProfileRing_Views.count-1)[self configureFilterAtIndex:i+1];
                [self configureFilterAtIndex:i];
                if (i>= 2) [self resetPositionImgs:i-1];
                if (i==m_aProfileRing_Views.count-1) return;
                float offsetX = (scrollView.contentOffset.x - WIDTH_RING_PROFILE*i)/ WIDTH_RING_PROFILE;
                RingProfile_View* ringProfileView = m_aProfileRing_Views[i];
                UIImageView* imageView      = ringProfileView.m_Image_Background;
                UIImageView* imageView_aux  = ringProfileView.m_Image_Background_AUX;
                CGRect frame = imageView.frame;
                frame.origin.x = offsetX*100.f;
                imageView.frame = frame;
                imageView_aux.frame = frame;
                return;
            }
        }
    }
}

/*
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    int tag = scrollView.tag;
    
    if (tag == 888 && m_bMoveCarouselImages)
    {
        [NSTimer scheduledTimerWithTimeInterval:0.5
                                         target:self
                                       selector:@selector(setupCarouselImage)
                                       userInfo:nil
                                        repeats:NO];
        
        m_bMoveCarouselImages   = NO;
        for (int i = 0; i < m_aProfileRing_Views.count; i++)
        {
            RingProfile_View* ringProfileView = m_aProfileRing_Views[i];
            [ringProfileView.m_ScrollView_Carousel.layer removeAllAnimations];
            [ringProfileView.m_ScrollView_Carousel scrollRectToVisible:CGRectMake(0, 0, ringProfileView.m_ScrollView_Carousel.frame.size.width , ringProfileView.m_ScrollView_Carousel.frame.size.height) animated:NO];
            
        }
        
    }
    else if (tag== 999 && m_bMoveCarouselProducts)
    {
        m_bMoveCarouselProducts   = NO;
        for (int i = 0; i < m_aProfileRing_Views.count; i++)
        {
            RingProfile_View* ringProfileView = m_aProfileRing_Views[i];
            [ringProfileView.m_ScrollView_Product.layer removeAllAnimations];
            [ringProfileView.m_ScrollView_Product scrollRectToVisible:CGRectMake(0, 0, ringProfileView.m_ScrollView_Carousel.frame.size.width , ringProfileView.m_ScrollView_Carousel.frame.size.height) animated:NO];
        }
    }
}

- (void) setupCarouselImage
{
    for (int i = 0; i < m_aProfileRing_Views.count; i++)
    {
        RingProfile_View* ringProfileView = m_aProfileRing_Views[i];
        ringProfileView.m_ScrollView_Carousel.scrollEnabled = YES;
    }
    
}
 */

- (void) configureFilterAtIndex:(int) _index
{
    RingProfile_View* ringProfileView = m_aProfileRing_Views[_index];
    float value = ringProfileView.m_ScrollView_Profile.contentOffset.y /300.f;
    if (value < 0.f) value = 0.f;
    if (value > 1.f) value = 1.f;
    ringProfileView.m_Image_Background_AUX.alpha = value;
}



- (void) resetPositionImgs:(int)index
{
    float width = 320;
    for (int i =0; i < index;++i)
    {
        RingProfile_View* ringProfileView =m_aProfileRing_Views[i];
        UIImageView*img = ringProfileView.m_Image_Background;
        UIImageView*img_aux = ringProfileView.m_Image_Background_AUX;
        CGRect frame = img.frame;
        frame.origin.x = i*width;
        img.frame = frame;
        img_aux.frame = frame;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction) viewArchitextureWeb:(id)sender
{
    [self performSegueWithIdentifier:@"FromViewController_To_WebLink" sender:@"http://www.architexture-online.com"];
}



- (IBAction)menu_Clicked:(id)sender
{
    m_bMenuClicked = YES;
    [[AppDelegate mainAppDelegate] showSideMenu];
}

- (IBAction) moreInfo_Clicked:(id) sender
{
    for (int i = 0; i < m_aProfileRing_Views.count; i++)
    {
        RingProfile_View* ringProfileView = m_aProfileRing_Views[i];
        ringProfileView.m_ScrollView_Profile.delegate = nil;
        ringProfileView.m_ScrollView_Profile.scrollEnabled = NO;
        [ringProfileView.m_ScrollView_Profile scrollRectToVisible:CGRectMake(0, 2020.f, WIDTH_RING_PROFILE , ringProfileView.m_ScrollView_Profile.frame.size.height) animated:YES];
        ringProfileView.m_Image_TitleBig.alpha = 0.f;
        ringProfileView.m_Image_TitleSmall.alpha = 1.f;
    }
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(setupDelegateScrolls:)
                                   userInfo:nil
                                    repeats:NO];
}
- (void) setupDelegateScrolls:(NSTimer *)timer
{
    for (int i = 0; i < m_aProfileRing_Views.count; i++)
    {
        RingProfile_View* ringProfileView = m_aProfileRing_Views[i];
        ringProfileView.m_ScrollView_Profile.delegate = self;
        ringProfileView.m_ScrollView_Profile.scrollEnabled = YES;
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"FromViewController_To_WebLink"])
    {
        NSString *url = (NSString*)sender;
        ViewLink_VC * vc = [segue destinationViewController];
        vc.urlAddress = url;
    }
}

- (IBAction) showActionSheetFacebook:(id)sender
{
    m_eTypeActionSheet = ACTION_SHEET_FACEBOOK;
    UIButton*btn = (UIButton*)sender;
    m_iTagButtonFacebookImage = btn.tag;
    m_ActionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"FACEBOOK_OPTION", @"")
                                                delegate:self
                                       cancelButtonTitle:NSLocalizedString(@"CANCEL", @"")
                                  destructiveButtonTitle:nil
                                       otherButtonTitles:NSLocalizedString(@"POST_FACEBOOK", @""),
                                        NSLocalizedString(@"ARCHITEXTURE_FACEBOOK", @""),nil];
    
    [m_ActionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
}

- (IBAction) showActionSheetTwitter:(id)sender
{
    UIButton* btn = (UIButton*) sender;
    m_ButtonTag = btn.tag;
    m_eTypeActionSheet = ACTION_SHEET_TWITTER;
    
    m_ActionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"TWITTER_OPTION", @"")
                                                delegate:self
                                       cancelButtonTitle:NSLocalizedString(@"CANCEL", @"")
                                  destructiveButtonTitle:nil
                                       otherButtonTitles:NSLocalizedString(@"POST_TWEET", @""),
                     NSLocalizedString(@"ARCHITEXTURE_TWITTER", @""),nil];
    
    [m_ActionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0: //POST
        {
            if (m_eTypeActionSheet == ACTION_SHEET_TWITTER)
            {
                [self PostOnTwitter];
            }
            else if (m_eTypeActionSheet == ACTION_SHEET_FACEBOOK)
            {
                [self PostOnFacebook];
            }
        }
            break;
            
        case 1: //VISIT WEB
        {
            if (m_eTypeActionSheet == ACTION_SHEET_TWITTER)
            {
                [self performSegueWithIdentifier:@"FromViewController_To_WebLink" sender:@"https://twitter.com/rchitexture"];
            }
            else if (m_eTypeActionSheet == ACTION_SHEET_FACEBOOK)
            {
                [self performSegueWithIdentifier:@"FromViewController_To_WebLink" sender:@"https://www.facebook.com/pages/architexture-online/399183696843071"];
            }
        }
            break;
        case 2:
        {
            //CANCEL
            //Nothing todo
        }
        default:
            break;
    }//END switch (buttonIndex)
}

- (void) PostOnFacebook
{
    //check if Facebook Account is linked
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        m_mySLComposerSheet = [[SLComposeViewController alloc] init];
        m_mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [m_mySLComposerSheet setInitialText:m_sTagButtonFacebookText];
        
        UIImage* img = [UIImage imageNamed:m_sTagButtonFacebookImage];
        [m_mySLComposerSheet addImage:img];
        [self presentViewController:m_mySLComposerSheet animated:YES completion:nil];
    }
    else
    {
        [ECommon showAlertInfo:NSLocalizedString(@"FACEBOOK_NOT_LINKED",nil) title:NSLocalizedString(@"WARNING", nil)];
        return;
    }
    
    [m_mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result)
     {
        switch (result)
         {
            case SLComposeViewControllerResultCancelled:
                [ECommon showAlertInfo:NSLocalizedString(@"FACEBOOK_POST_CANCELLED",nil) title:@"FACEBOOK"];
                break;
            case SLComposeViewControllerResultDone:
                [ECommon showAlertInfo:NSLocalizedString(@"FACEBOOK_POST_SUCCESSFULL",nil) title:@"FACEBOOK"];
                break;
            default:
                break;
        }
    }];
}

- (void) PostOnTwitter
{
    //check if Facebook Account is linked
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        m_mySLComposerSheet = [[SLComposeViewController alloc] init];
        m_mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [m_mySLComposerSheet setInitialText:m_sTagButtonFacebookText];
        
        UIImage* img = [UIImage imageNamed:m_sTagButtonFacebookImage];
        [m_mySLComposerSheet addImage:img];
        [self presentViewController:m_mySLComposerSheet animated:YES completion:nil];
    }
    else
    {
        [ECommon showAlertInfo:NSLocalizedString(@"TWITTER_NOT_LINKED",nil) title:NSLocalizedString(@"WARNING", nil)];
        return;
    }
    
    [m_mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result)
     {
         switch (result)
         {
             case SLComposeViewControllerResultCancelled:
                 [ECommon showAlertInfo:NSLocalizedString(@"FACEBOOK_POST_CANCELLED",nil) title:@"TWITTER"];
                 break;
             case SLComposeViewControllerResultDone:
                 [ECommon showAlertInfo:NSLocalizedString(@"FACEBOOK_POST_SUCCESSFULL",nil) title:@"TWITTER"];
                 break;
             default:
                 break;
         }
     }];
}

@end
