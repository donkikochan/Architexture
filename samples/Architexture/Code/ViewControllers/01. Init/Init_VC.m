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
            break;
        case 2:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_BARCELONA;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"1";
            break;
        case 3:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_BARCELONA;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"2";
            break;
        case 4:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_BARCELONA;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"3";
            break;
        case 5:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_BARCELONA;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"4";
            break;
        case 6:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_BARCELONA;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"5";
            break;
        case 7:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_MATERIALS;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"0";
            break;
        case 8:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_MATERIALS;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"1";
            break;
        case 9:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_MATERIALS;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"2";
            break;
        case 10:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_MATERIALS;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"3";
            break;
        case 11:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_MATERIALS;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"4";
            break;
        case 12:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_MATERIALS;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"5";
            break;
        case 13:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_PARIS;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"0";
            break;
        case 14:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_PARIS;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"1";
            break;
        case 15:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_PARIS;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"2";
            break;
        case 16:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_PARIS;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"3";
            break;
        case 17:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_PARIS;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"4";
            break;
        case 18:
            [AppDelegate mainAppDelegate].m_sCollectionToLoad = COLLECTION_PARIS;
            [AppDelegate mainAppDelegate].m_sRingToLoad = @"5";
            break;
        default:
            break;
    }
    [self performSegueWithIdentifier:@"FromInitToLoading" sender:nil];
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
