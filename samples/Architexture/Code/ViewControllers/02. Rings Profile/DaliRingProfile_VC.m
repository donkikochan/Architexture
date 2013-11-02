//
//  DaliRingProfile_VC.m
//  Architexture
//
//  Created by Enric Vergara Carreras on 24/09/13.
//
//

#import "DaliRingProfile_VC.h"

@interface DaliRingProfile_VC ()

@end

@implementation DaliRingProfile_VC

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
    [_m_View_Ring.m_ScrollView_Profile setContentSize:CGSizeMake(1.f, 2345+height)];
    [_m_View_Ring.m_ScrollView_Profile setDelegate: self];
    [_m_View_Ring.m_ScrollView_Profile setScrollEnabled:YES];
    
    //---- Configurar la imatge inicial background de cada Ring Profile:
    _m_View_Ring.m_Image_Background.image       = [UIImage imageNamed:@"DALI00.jpg"];
    _m_View_Ring.m_Image_Background_AUX.image   = [UIImage imageNamed:@"DALI19.jpg"];
    _m_View_Ring.m_Image_Background_AUX.alpha   = 0.f;
    
    
    //---- Configure Titles:
    _m_View_Ring.m_Image_Title.image = [UIImage imageNamed:@"DALI.png"];
    
    
    //---- Configure Menu Button:
    [_m_View_Ring.m_Button_GoToMenu addTarget:self action:@selector(menu_Clicked:) forControlEvents:UIControlEventTouchDown];
    

    //---- Configure Info Image:
    _m_View_Ring.m_Image_Info.image = [UIImage imageNamed:@"DALI_INFO_EN.png"];
    
    
    //---- Configure Small and Big Title:
    _m_View_Ring.m_Image_TitleBig.image      = [UIImage imageNamed:@"DALI_TITLE_BIG.png"];
    _m_View_Ring.m_Image_TitleSmall.image    = [UIImage imageNamed:@"DALI_TITLE_SMALL.png"];
    _m_View_Ring.m_Image_TitleSmall.alpha    = 0.f;
    _m_View_Ring.m_Image_TitleBig.alpha      = 1.f;
 
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
                //Nothing todo.
            }
            else if (l_iIndex == 41)
            {
                [AppDelegate mainAppDelegate].m_sCollectionToLoad = SP_COLLECTION_BORN;
                [AppDelegate mainAppDelegate].m_sRingToLoad = 0;
                [AppDelegate mainAppDelegate].m_sGoToNewCollection  = @"YES";
                [self.navigationController popViewControllerAnimated:NO];
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
    
    NSLog(@"Dalí didReceiveMemoryWarning");
}

@end
