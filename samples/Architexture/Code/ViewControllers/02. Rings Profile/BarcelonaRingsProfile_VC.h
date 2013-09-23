//
//  ViewController.h
//  achitexture
//
//  Created by DonKikochan on 10/07/13.
//  Copyright (c) 2013 architexture. All rights reserved.
//

//---Imports:----
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "RingProfile_View.h"
//---------------

@interface BarcelonaRingsProfile_VC : UIViewController <UIScrollViewDelegate>
{
    NSArray *m_aBackGround;
    NSArray *m_aProfileRing_Views;
    NSArray *m_aProfileNames;
    NSArray *m_aTitles;
    NSArray *m_aInfoProfiles;
    NSArray *m_aCarouselImages;
    NSArray *m_aCarouselProducts;
    NSArray *m_aBigTitle;
    NSArray *m_aSmallTitle;
    NSArray *m_aMap;
    BOOL    m_bMenuClicked;
    
    //--Para mover los acrouselImage i Products:
    BOOL    m_bMoveCarouselImages;
    BOOL    m_bMoveCarouselProducts;
}

//---IBOutlets:
@property (weak, nonatomic) IBOutlet UIScrollView       *m_ScrollView_AllRings;
@property (weak, nonatomic) IBOutlet RingProfile_View   *m_View_Ring_01;
@property (weak, nonatomic) IBOutlet RingProfile_View   *m_View_Ring_02;
@property (weak, nonatomic) IBOutlet RingProfile_View   *m_View_Ring_03;
@property (weak, nonatomic) IBOutlet RingProfile_View   *m_View_Ring_04;
@property (weak, nonatomic) IBOutlet RingProfile_View   *m_View_Ring_05;
@property (weak, nonatomic) IBOutlet RingProfile_View   *m_View_Ring_06;

//---IBActions:
//...

@end
