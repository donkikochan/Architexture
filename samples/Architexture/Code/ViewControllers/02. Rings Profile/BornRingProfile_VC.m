//
//  BornRingProfile_VC.m
//  Architexture
//
//  Created by DonKikochan on 25/09/13.
//
//

#import "BornRingProfile_VC.h"

@interface BornRingProfile_VC ()

@end

@implementation BornRingProfile_VC

#define TITLE_MIN_Y         347.f
#define TITLE_MAX_Y         425.f

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
    
    float height = self.view.frame.size.height;
    [_m_View_Ring.m_ScrollView_Profile setContentSize:CGSizeMake(1.f, 3214+height)];
    [_m_View_Ring.m_ScrollView_Profile setDelegate: self];
    [_m_View_Ring.m_ScrollView_Profile setScrollEnabled:YES];
    
    //---- Configurar la imatge inicial background de cada Ring Profile:
    _m_View_Ring.m_Image_Background.image       = [UIImage imageNamed:@"BORN00.jpg"];
    _m_View_Ring.m_Image_Background_AUX.image   = [UIImage imageNamed:@"BORN19.jpg"];
    _m_View_Ring.m_Image_Background_AUX.alpha   = 0.f;
    
    
    //---- Configure Titles:
    _m_View_Ring.m_Image_Title.image = [UIImage imageNamed:@"BORN.png"];
    
    
    //---- Configure Menu Button:
    [_m_View_Ring.m_Button_GoToMenu addTarget:self action:@selector(menu_Clicked:) forControlEvents:UIControlEventTouchDown];
    
    
    //---- Configure Info Image:
    _m_View_Ring.m_Image_Info.image = [UIImage imageNamed:@"BORN_INFO_AN.png"];
    
    
    //---- Configure Small and Big Title:
    _m_View_Ring.m_Image_TitleBig.image      = [UIImage imageNamed:@"BORN_TITLE_BIG.png"];
    _m_View_Ring.m_Image_TitleSmall.image    = [UIImage imageNamed:@"BORN_TITLE_SMALL.png"];
    _m_View_Ring.m_Image_TitleSmall.alpha    = 0.f;
    _m_View_Ring.m_Image_TitleBig.alpha      = 1.f;
    
    
    //---- Configure Product carousel:
    _m_View_Ring.m_Image_Product_Aux1.image = [UIImage imageNamed:@"TEULA_PRODUCT.png"];
    _m_View_Ring.m_Image_Product_Aux2.image = [UIImage imageNamed:@"ANTIC_PRODUCT.png"];
    _m_View_Ring.m_Image_Product_Aux3.image = [UIImage imageNamed:@"MUR_PRODUCT.png"];
    _m_View_Ring.m_Image_Product_Aux4.image = [UIImage imageNamed:@"BORN_PRODUCT.png"];
    [_m_View_Ring.m_ScrollView_Product_Aux1 setContentSize:CGSizeMake(1091, 1.f)];
    [_m_View_Ring.m_ScrollView_Product_Aux2 setContentSize:CGSizeMake(1091, 1.f)];
    [_m_View_Ring.m_ScrollView_Product_Aux3 setContentSize:CGSizeMake(1091, 1.f)];
    [_m_View_Ring.m_ScrollView_Product_Aux4 setContentSize:CGSizeMake(1091, 1.f)];
    
    //---- Configure Button Shop:
    _m_View_Ring.m_Button_Shop_Aux1.tag = 1;
    [_m_View_Ring.m_Button_Shop_Aux1 addTarget:self action:@selector(addShop:) forControlEvents:UIControlEventTouchDown];
    [_m_View_Ring.m_Button_Shop_Aux1 setTitle:NSLocalizedString(@"ADD_TO_CART",nil) forState:UIControlStateNormal];
    
    _m_View_Ring.m_Button_Shop_Aux2.tag = 2;
    [_m_View_Ring.m_Button_Shop_Aux2 addTarget:self action:@selector(addShop:) forControlEvents:UIControlEventTouchDown];
    [_m_View_Ring.m_Button_Shop_Aux2 setTitle:NSLocalizedString(@"ADD_TO_CART",nil) forState:UIControlStateNormal];
    
    _m_View_Ring.m_Button_Shop_Aux3.tag = 3;
    [_m_View_Ring.m_Button_Shop_Aux3 addTarget:self action:@selector(addShop:) forControlEvents:UIControlEventTouchDown];
    [_m_View_Ring.m_Button_Shop_Aux3 setTitle:NSLocalizedString(@"ADD_TO_CART",nil) forState:UIControlStateNormal];
    
    _m_View_Ring.m_Button_Shop_Aux4.tag = 4;
    [_m_View_Ring.m_Button_Shop_Aux4 addTarget:self action:@selector(addShop:) forControlEvents:UIControlEventTouchDown];
    [_m_View_Ring.m_Button_Shop_Aux4 setTitle:NSLocalizedString(@"ADD_TO_CART",nil) forState:UIControlStateNormal];
    
    [_m_View_Ring.m_Button_Facebook addTarget:self action:@selector(showActionSheetFacebook:) forControlEvents:UIControlEventTouchDown];
    [_m_View_Ring.m_Button_Twitter addTarget:self action:@selector(showActionSheetTwitter:) forControlEvents:UIControlEventTouchDown];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
    {
        // iOS 7
        [self setNeedsStatusBarAppearanceUpdate];
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
    
    if ([[AppDelegate mainAppDelegate].m_sGoToNewCollection isEqualToString:@"YES"])
    {
        [AppDelegate mainAppDelegate].m_sGoToNewCollection = @"NO";
    }
    
    if ([[AppDelegate mainAppDelegate] haveToOpenMenu])
    {
        [[AppDelegate mainAppDelegate] showSideMenu];
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(notificationCallback:)
												 name:nil
											   object:nil ];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIImageView*image       = _m_View_Ring.m_Image_Background;
    UIImageView*image_aux   = _m_View_Ring.m_Image_Background_AUX;
    
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
        _m_View_Ring.m_Image_TitleBig.alpha      = 1.f;
        _m_View_Ring.m_Image_TitleSmall.alpha    = 0.f;
    }
    
    if (scrollView.contentOffset.y >= TITLE_MIN_Y && scrollView.contentOffset.y <= TITLE_MAX_Y)
    {
        float value = (scrollView.contentOffset.y - TITLE_MIN_Y)/(TITLE_MAX_Y-TITLE_MIN_Y); //value from 0 to 1.
        if (value <= 0.5)
        {
            _m_View_Ring.m_Image_TitleBig.alpha      = 1.f -(value * 2.f);
            _m_View_Ring.m_Image_TitleSmall.alpha    = 0.f;
        }
        else{
            _m_View_Ring.m_Image_TitleBig.alpha      = 1.f - (value * 2.f);
            _m_View_Ring.m_Image_TitleSmall.alpha    = (value - 0.5f) * 2.f;
        }
    }
    
    if (scrollView.contentOffset.y > TITLE_MAX_Y)
    {
        _m_View_Ring.m_Image_TitleBig.alpha     = 0.f;
        _m_View_Ring.m_Image_TitleSmall.alpha   = 1.f;
    }
    
    float value = _m_View_Ring.m_ScrollView_Profile.contentOffset.y /300.f;
    if (value < 0.f) value = 0.f;
    if (value > 1.f) value = 1.f;
    _m_View_Ring.m_Image_Background_AUX.alpha = value;
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
                [AppDelegate mainAppDelegate].m_sRingToLoad = 0;
                [AppDelegate mainAppDelegate].m_sGoToNewCollection  = @"YES";
                [self.navigationController popViewControllerAnimated:NO];
            }
            else if (l_iIndex == 41)
            {
                //Nothing todo.
            }
            
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


- (IBAction)menu_Clicked:(id)sender
{
    [[AppDelegate mainAppDelegate] showSideMenu];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    NSLog(@"Born didReceiveMemoryWarning");
}


- (IBAction) addShop:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSLog(@"Add Shop: %d",btn.tag);
    switch(btn.tag)
    {
        case 1: //TEULA
        {
            [[AppDelegate mainAppDelegate].m_CheckOutInfo addAmmount:1 ToRing:@"TEULA"];
            [[AppDelegate mainAppDelegate].m_CheckOutInfo jumpToRing:@"TEULA"];
        }
            break;
        case 2: //ANTIC
        {
            [[AppDelegate mainAppDelegate].m_CheckOutInfo addAmmount:1 ToRing:@"ANTIC"];
            [[AppDelegate mainAppDelegate].m_CheckOutInfo jumpToRing:@"ANTIC"];
        }
            break;
        case 3: //MUR
        {
            [[AppDelegate mainAppDelegate].m_CheckOutInfo addAmmount:1 ToRing:@"MUR"];
            [[AppDelegate mainAppDelegate].m_CheckOutInfo jumpToRing:@"MUR"];
        }
            break;
            
        case 4: //BORN
        {
            [[AppDelegate mainAppDelegate].m_CheckOutInfo addAmmount:1 ToRing:@"BORN"];
            [[AppDelegate mainAppDelegate].m_CheckOutInfo jumpToRing:@"BORN"];
        }
            break;
    }
    [self performSegueWithIdentifier:@"FromRingsToCheckout" sender:nil];
}

- (IBAction) showActionSheetFacebook:(id)sender
{
    m_eTypeActionSheet = ACTION_SHEET_FACEBOOK;
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
        [m_mySLComposerSheet setInitialText:NSLocalizedString(@"FACEBOOK_BORN", nil)];
        
        UIImage* img = [UIImage imageNamed:@"DISPLAY born.jpg"];
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
        [m_mySLComposerSheet setInitialText:NSLocalizedString(@"FACEBOOK_BORN", nil)];
        
        UIImage* img = [UIImage imageNamed:@"DISPLAY born.jpg"];
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
