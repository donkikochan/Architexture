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
    

    _m_Button_StartApp.hidden   =
    _m_Button_Camera.hidden     = NO;
    _m_ViewLoading.hidden       = YES;
    _m_Image_BackGround.image = [UIImage imageNamed:NSLocalizedString(@"BACKGROUND_INIT", nil)];
}

- (IBAction) catalog_Clicked:(id)sender
{
//    _m_ViewLoading.hidden       = NO;
//    [_m_ActivityIndicator startAnimating];
//    [NSTimer scheduledTimerWithTimeInterval:0.5f
//                                     target:self
//                                   selector:@selector(gotoRingProfiles:)
//                                   userInfo:nil
//                                    repeats:NO];
//    
}

- (void) gotoRingProfiles:(NSTimer *)timer
{
    [self performSegueWithIdentifier:@"FromInitToRingProfiles" sender:nil];
}

    
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setM_ActivityIndicator:nil];
    [self setM_Button_StartApp:nil];
    [self setM_Button_Camera:nil];
    [self setM_Image_BackGround:nil];
    [self setM_ViewLoading:nil];
    [super viewDidUnload];
}
@end
