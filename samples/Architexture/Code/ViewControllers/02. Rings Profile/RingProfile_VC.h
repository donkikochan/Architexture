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
#import <Social/Social.h>
#import <Accounts/Accounts.h>
//---------------

//----Define new types:--
#define WIDTH_RING_PROFILE  320.f

typedef enum {
    ACTION_SHEET_FACEBOOK,
    ACTION_SHEET_TWITTER,
    NONE
} TYPE_AS;
//------------------------

@interface RingProfile_VC : UIViewController <UIScrollViewDelegate, UIActionSheetDelegate>
{
    NSArray*                    m_aBackGround;
    NSArray*                    m_aProfileRing_Views;
    NSArray*                    m_aProfileNames;
    NSArray*                    m_aTitles;
    NSArray*                    m_aInfoProfiles;
    NSArray*                    m_aCarouselImages;
    NSArray*                    m_aCarouselProducts;
    NSArray*                    m_aBigTitle;
    NSArray*                    m_aSmallTitle;
    NSArray*                    m_aMap;
    BOOL                        m_bMenuClicked;
    
    UIActionSheet*              m_ActionSheet;
    TYPE_AS                     m_eTypeActionSheet;
    int                         m_ButtonTag;
    
    SLComposeViewController*    m_mySLComposerSheet;
    
    //--Para mover los acrouselImage i Products:
    BOOL                        m_bMoveCarouselImages;
    BOOL                        m_bMoveCarouselProducts;
    
    int                         m_iTagButtonFacebookImage;
    NSString*                   m_sTagButtonFacebookImage;
    NSString*                   m_sTagButtonFacebookText;
}

//---IBOutlets:
@property (weak, nonatomic) IBOutlet UIScrollView*  m_ScrollView_AllRings;

//---IBActions:
- (IBAction) showActionSheetFacebook:(id)sender;
- (IBAction) showActionSheetTwitter:(id)sender;

//---Functions:
- (void) PostOnFacebook;
- (void) PostOnTwitter;

@end
