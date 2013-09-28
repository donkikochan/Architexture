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
    m_aPositions[0]     = CGPointMake(2.174284,     41.378845);     //_01_HAPPINESS
    m_aPositions[1]     = CGPointMake(2.190202,     41.383345);     //_02_REFLEX
    m_aPositions[2]     = CGPointMake(2.221102,     41.41124);      //_03_SKY
    m_aPositions[3]     = CGPointMake(2.161702,     41.394288);     //_04_CLOTHING
    m_aPositions[4]     = CGPointMake(2.178049,     41.386292);     //_05_FANCY
    m_aPositions[5]     = CGPointMake(2.150004,     41.370541);     //_06_EARTH
    m_aPositions[6]     = CGPointMake(10.752672,    59.907469);     //_07_RHYTHM
    m_aPositions[7]     = CGPointMake(-0.080062,    51.514378);     //_08_TRANSPARENCY
    m_aPositions[8]     = CGPointMake(13.370038,    52.510018);     //_09_GOLD
    m_aPositions[9]     = CGPointMake(-5.582273,    42.606674);     //_10_COLOURS
    m_aPositions[10]    = CGPointMake(-1.978662,    43.324491);     //_11_LIGHT
    m_aPositions[11]    = CGPointMake(9.181104,     46.621825);     //_12_MOUNTAIN
    m_aPositions[12]    = CGPointMake(2.29719,      48.86079);      //_13_FLOWER
    m_aPositions[13]    = CGPointMake(2.29502,      48.873663);     //_14_PLACE
    m_aPositions[14]    = CGPointMake(2.265326,     48.851861);     //_15_CALME
    m_aPositions[15]    = CGPointMake(2.335876,     48.860995);     //_16_ANGLE
    m_aPositions[16]    = CGPointMake(2.294658,     48.858207);     //_17_ICONE
    m_aPositions[17]    = CGPointMake(2.352435,     48.860529);     //_18_RGG
    
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
    
    int index = [[AppDelegate mainAppDelegate].m_sMapRing intValue];
    
    [_m_MapView setMapType:MKMapTypeSatellite];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(m_aPositions[index].y, m_aPositions[index].x), 500, 500);
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
