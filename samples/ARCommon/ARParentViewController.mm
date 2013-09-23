/*==============================================================================
 Copyright (c) 2012 QUALCOMM Austria Research Center GmbH.
 All Rights Reserved.
 Qualcomm Confidential and Proprietary
 ==============================================================================*/

#import "ARParentViewController.h"
#import "ARViewController.h"
#import "OverlayViewController.h"
#import "QCARutils.h"

@implementation ARParentViewController


@synthesize arViewRect;

// initialisation functions set up size of managed view
- (void)setup{
    QCARutils *qUtils = [QCARutils getInstance];

    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    // Provide a list of targets we're expecting - the first in the list is the default
    //[qUtils addTargetName:@"Stones & Chips" atPath:@"StonesAndChips.xml"];
    [qUtils addTargetName:@"Kike" atPath:@"Kike.xml"];
    
    arViewRect = screenBounds;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        [self setup];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setup];
    }
    return self;    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
        [self setup];
    }
    return self;
}

- (void) viewDidLoad{   
    [super viewDidLoad];
    
    NSLog(@"ARParentVC: viewDidLoad");
    parentView = [[UIView alloc] initWithFrame:arViewRect];
    
    // Add the EAGLView and the overlay view to the window
    arViewController = [[ARViewController alloc] init];
    
    // need to set size here to setup camera image size for AR
    arViewController.arViewSize = arViewRect.size;
    [parentView addSubview:arViewController.view];
    
    // Create an auto-rotating overlay view and its view controller (used for
    // displaying UI objects, such as the camera control menu)
    overlayViewController = [[OverlayViewController alloc] init];
    [parentView addSubview: overlayViewController.view];
    
    
    [self addChildViewController:arViewController];
    [self addChildViewController:overlayViewController];
    [self.view addSubview:parentView];
    
    // it's important to do this from here as arViewController has the wrong idea of orientation
    [arViewController handleARViewRotation:self.interfaceOrientation];
    // we also have to set the overlay view to the correct width/height for the orientation
    [overlayViewController handleViewRotation:self.interfaceOrientation];
}

- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
    
    NSLog(@"ARParentVC: viewWillAppear");
    // make sure we're oriented/sized properly before reappearing/restarting
    [arViewController handleARViewRotation:self.interfaceOrientation];
    [overlayViewController handleViewRotation:self.interfaceOrientation];
//    [arViewController viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(notificationCallback:)
												 name:nil
											   object:nil ];
    
    showOverlay = NO;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.f
                                     target:self
                                   selector:@selector(showHappinessDetected:)
                                   userInfo:nil
                                    repeats:YES];

}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"ARParentVC: viewDidAppear");
//    [arViewController viewDidAppear:animated];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    NSLog(@"ARParentVC: viewDidDisappear");
//    [arViewController viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:nil
                                                  object:nil];
    
    [timer invalidate];
    timer = nil;

}

- (void)viewDidUnload{
    [super viewDidUnload];
    
    NSLog(@"ARParentVC: viewDidUnload");
    overlayViewController = nil;
    arViewController = nil;
    parentView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Support all orientations
    return YES;
    
    // Support both portrait orientations
    //return (UIInterfaceOrientationPortrait == interfaceOrientation ||
    //        UIInterfaceOrientationPortraitUpsideDown == interfaceOrientation);

    // Support both landscape orientations
    //return (UIInterfaceOrientationLandscapeLeft == interfaceOrientation ||
    //        UIInterfaceOrientationLandscapeRight == interfaceOrientation);
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    // ensure overlay size and AR orientation is correct for screen orientation
    [overlayViewController handleViewRotation:self.interfaceOrientation];
    [arViewController handleARViewRotation:interfaceOrientation];
}


// touch handlers
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    
    if (1 == [touch tapCount])
    {
        // Show camera control action sheet
        //[overlayViewController showOverlay];
    }
}

- (void) notificationCallback:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"happinessDetected"])
    {
        showOverlay = YES;
    }
    else if ([[notification name] isEqualToString:@"GoRings"])
    {
        [self performSegueWithIdentifier:@"FromCameraToRings" sender:nil];
    }
}

- (void) showHappinessDetected:(NSTimer *)theTimer
{
    if (showOverlay)
    {
        [overlayViewController showOverlay];
        showOverlay = NO;
    }
}


- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // iOS requires all events handled if touchesBegan is handled and not forwarded
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // iOS requires all events handled if touchesBegan is handled and not forwarded
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    // iOS requires all events handled if touchesBegan is handled and not forwarded
}

@end
