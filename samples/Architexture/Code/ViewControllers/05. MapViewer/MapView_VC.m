//
//  MapView_VC.m
//  Architexture
//
//  Created by Enric Vergara Carreras on 06/09/13.
//
//

#import "MapView_VC.h"

@interface MapView_VC ()

@end

@implementation MapView_VC

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

    //CGPoint (lat, lon):
    m_aPositions[0]     = CGPointMake(2.174268f, 41.403551f);   //_01_HAPPINESS
    m_aPositions[1]     = CGPointMake(2.174268f, 41.403551f);   //_02_REFLEX
    m_aPositions[2]     = CGPointMake(2.174268f, 41.403551f);   //_03_SKY
    m_aPositions[3]     = CGPointMake(2.174268f, 41.403551f);   //_04_CLOTHING
    m_aPositions[4]     = CGPointMake(2.174268f, 41.403551f);   //_05_FANCY
    m_aPositions[5]     = CGPointMake(2.174268f, 41.403551f);   //_06_EARTH
    m_aPositions[6]     = CGPointMake(2.174268f, 41.403551f);   //_07_TRANSPARENCY
    m_aPositions[7]     = CGPointMake(2.174268f, 41.403551f);   //_08_RHYTHM
    m_aPositions[8]     = CGPointMake(2.174268f, 41.403551f);   //_09_FLOWER
    m_aPositions[9]     = CGPointMake(2.174268f, 41.403551f);   //_10_GOLD
    m_aPositions[10]    = CGPointMake(2.174268f, 41.403551f);   //_11_COLOURS
    m_aPositions[11]    = CGPointMake(2.174268f, 41.403551f);   //_12_LIGHT
    m_aPositions[12]    = CGPointMake(2.174268f, 41.403551f);   //_13_MOUNTAIN
    
    
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

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_m_MapView setMapType:MKMapTypeSatellite];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(m_aPositions[0].y, m_aPositions[0].x), 500, 500);
    [_m_MapView setRegion:region animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setM_MapView:nil];
    [self setM_Button_Back:nil];
    [super viewDidUnload];
}
- (IBAction)back_Clicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}
@end
