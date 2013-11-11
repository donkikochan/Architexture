//
//  Init_VC.m
//  ImageTargets
//
//  Created by Enric Vergara Carreras on 14/07/13.
//
//

//---Imports:---
#import "Init_VC.h"
//--------------

//---New Defines:----
#define TIME_ALPHA_ANIMATION    1.5
#define TIME_INTERVAL_ANIMATION 0.1
//-------------------

@interface Init_VC ()

@end

@implementation Init_VC

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

    m_pTimer = nil;
    
    CALayer * l = _m_View_Info.layer;
    [l setMasksToBounds:YES];
    [l setCornerRadius:15.0];
    _m_Label_Info.text = NSLocalizedString(@"PRESS_ANY_RING", nil);
    
    m_iLastRingAnimated = 0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5];
    [UIView setAnimationDelay:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    _m_Image_SplashScreen.alpha = 0.f;
    
    [UIView commitAnimations];
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
    {
        // iOS 7
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
    for(UIButton*btn in _m_aButtonsAux)
    {
        btn.alpha = 0.f;
    }
    
    m_fCounter      =
    m_fCounterAux   = 0.f;
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"tag" ascending:YES];
    m_SortedButtonsAux = [self.m_aButtonsAux sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
}


- (void) viewDidAppear:(BOOL)animated
{
    if (m_pTimer == nil)
    {
        m_pTimer = [NSTimer scheduledTimerWithTimeInterval:TIME_INTERVAL_ANIMATION
                                                    target:self
                                                  selector:@selector(animateRing:)
                                                  userInfo:nil
                                                   repeats:YES];
    }
}

- (void) viewWillDisappear:(BOOL)animated
{
    [m_pTimer invalidate];
    m_pTimer = nil;
}

- (void) alphaAnimation:(int) index
{
    UIButton* btn = m_SortedButtonsAux[index];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:TIME_ALPHA_ANIMATION];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        btn.alpha = 1.f;
    [UIView commitAnimations];
    
    if (index != 0)
    {
        index--;
    }
    else{
        index =m_SortedButtonsAux.count -1;
    }
    btn = m_SortedButtonsAux[index];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:TIME_ALPHA_ANIMATION];
    [UIView setAnimationDelay:TIME_ALPHA_ANIMATION*2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        btn.alpha = 0.f;
    [UIView commitAnimations];
}

- (void) animateRing:(NSTimer *)timer
{
    m_fCounter += TIME_INTERVAL_ANIMATION;
    if (m_fCounter > 1.f)
    {
        m_fCounter = 0.f;
        [self alphaAnimation:m_iLastRingAnimated];
        m_iLastRingAnimated = (m_iLastRingAnimated +1) % _m_aButtonsAux.count;
    }
    
    if (m_fCounterAux >= 0 && m_fCounterAux < 3.f)
    {
        m_fCounterAux += TIME_INTERVAL_ANIMATION;
    }
    else
    {
        m_fCounterAux = -1;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:TIME_ALPHA_ANIMATION];
        [UIView setAnimationDelay:0.0];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            _m_View_Info.alpha = 0.f;
        [UIView commitAnimations];
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction) catalog_Clicked:(id)sender
{
    UIButton* btn = (UIButton*) sender;
    switch (btn.tag) {
        case 1:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_BARCELONA;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"0";
            [AppDelegate mainAppDelegate].m_sGoToNewCollection = @"YES";
            break;
        case 2:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_BARCELONA;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"1";
            [AppDelegate mainAppDelegate].m_sGoToNewCollection = @"YES";
            break;
        case 3:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_BARCELONA;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"2";
            [AppDelegate mainAppDelegate].m_sGoToNewCollection = @"YES";
            break;
        case 4:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_BARCELONA;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"3";
            [AppDelegate mainAppDelegate].m_sGoToNewCollection = @"YES";
            break;
        case 5:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_BARCELONA;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"4";
            [AppDelegate mainAppDelegate].m_sGoToNewCollection = @"YES";
            break;
        case 6:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_BARCELONA;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"5";
            [AppDelegate mainAppDelegate].m_sGoToNewCollection = @"YES";
            break;
        case 7:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_MATERIALS;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"0";
            [AppDelegate mainAppDelegate].m_sGoToNewCollection = @"YES";
            break;
        case 8:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_MATERIALS;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"1";
            [AppDelegate mainAppDelegate].m_sGoToNewCollection = @"YES";
            break;
        case 9:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_MATERIALS;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"2";
            [AppDelegate mainAppDelegate].m_sGoToNewCollection = @"YES";
            break;
        case 10:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_MATERIALS;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"3";
            [AppDelegate mainAppDelegate].m_sGoToNewCollection = @"YES";
            break;
        case 11:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_MATERIALS;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"4";
            [AppDelegate mainAppDelegate].m_sGoToNewCollection = @"YES";
            break;
        case 12:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_MATERIALS;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"5";
            [AppDelegate mainAppDelegate].m_sGoToNewCollection = @"YES";
            break;
        case 13:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_PARIS;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"0";
            [AppDelegate mainAppDelegate].m_sGoToNewCollection = @"YES";
            break;
        case 14:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_PARIS;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"1";
            [AppDelegate mainAppDelegate].m_sGoToNewCollection = @"YES";
            break;
        case 15:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_PARIS;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"2";
            [AppDelegate mainAppDelegate].m_sGoToNewCollection = @"YES";
            break;
        case 16:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_PARIS;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"3";
            [AppDelegate mainAppDelegate].m_sGoToNewCollection = @"YES";
            break;
        case 17:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_PARIS;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"4";
            [AppDelegate mainAppDelegate].m_sGoToNewCollection = @"YES";
            break;
        case 18:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_PARIS;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"5";
            [AppDelegate mainAppDelegate].m_sGoToNewCollection = @"YES";
            break;
        default:
            break;
    }
    [self performSegueWithIdentifier:@"FromInitToLoading" sender:nil];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"FromInitToLoading"])
    {
        [m_pTimer invalidate];
        m_pTimer = nil;
    }
}
    
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}
@end
