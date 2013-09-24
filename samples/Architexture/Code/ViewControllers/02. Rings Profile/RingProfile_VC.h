//
//  RingProfile_VC.h
//  Architexture
//
//  Created by DonKikochan on 24/09/13.
//
//

//---Imports:----
#import <UIKit/UIKit.h>
#import "RingProfile_View.h"
//---------------

//----Define new types:--
#define WIDTH_RING_PROFILE  320.f
//------------------------

@interface RingProfile_VC : UIViewController <UIScrollViewDelegate>
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
@property (weak, nonatomic) IBOutlet UIScrollView*  m_ScrollView_AllRings;
@end
