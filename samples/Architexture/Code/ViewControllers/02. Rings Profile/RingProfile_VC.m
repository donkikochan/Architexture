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
    if (self) {
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
        ringProfileView.m_ScrollView_Product.tag = 999;
        ringProfileView.m_ScrollView_Carousel.tag = 888;
        
        
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
        
        
        //---- Configure Button Shop:
        ringProfileView.m_Image_Map.image = [UIImage imageNamed:m_aMap[i]];
        
        //---- Configure Button Shop:
        ringProfileView.m_Button_MapView.tag = i;
        [ringProfileView.m_Button_MapView addTarget:self action:@selector(viewMap:) forControlEvents:UIControlEventTouchDown];
    }
    
    //GO TO RING PROFILE in pos ringIndex
    int ringIndex = 0; //from [0 to m_aProfileRing_Views.count-1]
    RingProfile_View* ringProfileView =m_aProfileRing_Views[0];
    [_m_ScrollView_AllRings scrollRectToVisible:CGRectMake(WIDTH_RING_PROFILE*ringIndex, 0, WIDTH_RING_PROFILE , ringProfileView.m_ScrollView_Profile.frame.size.height) animated:YES];
    
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
        int l_index = [[AppDelegate mainAppDelegate].m_sRingToLoad intValue];
        RingProfile_View* ringProfileView =m_aProfileRing_Views[l_index];
        [_m_ScrollView_AllRings scrollRectToVisible:CGRectMake(WIDTH_RING_PROFILE*l_index, 0, WIDTH_RING_PROFILE ,ringProfileView.m_ScrollView_Profile.frame.size.height) animated:NO];
        
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
    
    
    m_bMoveCarouselImages   = YES;
    m_bMoveCarouselProducts = YES;
    [self moveCarousels];
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

- (IBAction) addShop:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSLog(@"Add Shop: %d",btn.tag);
    [self performSegueWithIdentifier:@"FromRingsToCheckout" sender:nil];
}


- (IBAction) viewMap:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSLog(@"Add Shop: %d",btn.tag);
    [self performSegueWithIdentifier:@"FromViewController_To_MapView" sender:nil];
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
        [ringProfileView.m_ScrollView_Profile scrollRectToVisible:CGRectMake(0, 1948.f, WIDTH_RING_PROFILE , ringProfileView.m_ScrollView_Profile.frame.size.height) animated:YES];
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

@end
