//
//  AboutUs_VC.m
//  Architexture
//
//  Created by DonKikochan on 16/10/13.
//
//

//----Imports:--
#import "AboutUs_VC.h"
//--------------


@interface AboutUs_VC ()

@end

@implementation AboutUs_VC

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
    
    [_m_ScrollView setContentSize:CGSizeMake(1, 670)];
    
    //---Localized String:----
    _m_Label_Info.text      = NSLocalizedString(@"INFO_ABOUT", nil);
    _m_Label_AboutUs.text   = NSLocalizedString(@"ABOUT_US",nil);
    //-----------------------
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *movieUrl = [NSURL fileURLWithPath:[bundle pathForResource:@"architexture-online" ofType:@"mp4"]];
    
    _m_pMoviePlayer =  [[MPMoviePlayerController alloc]
                     initWithContentURL:movieUrl];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:_m_pMoviePlayer];
    
    _m_pMoviePlayer.controlStyle    = MPMovieControlStyleDefault;
    _m_pMoviePlayer.scalingMode     = MPMovieScalingModeAspectFit;
    _m_pMoviePlayer.shouldAutoplay  = NO;
    CGRect frame = _m_View_Video.frame;
    frame.origin.x = frame.origin.y = 0;
    _m_pMoviePlayer.view.frame = frame;
    [_m_View_Video addSubview:_m_pMoviePlayer.view];
    [_m_pMoviePlayer setFullscreen:YES animated:YES];

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

- (void)moviePlayBackDidFinish:(id)selector
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back_Clicked:(id)sender
{
    [[AppDelegate mainAppDelegate] setOpenMenu];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
