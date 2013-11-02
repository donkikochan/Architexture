//
//  Init_VC.h
//  ImageTargets
//
//  Created by Enric Vergara Carreras on 14/07/13.
//
//


//---Imports:--
#import <UIKit/UIKit.h>
//--------------

@interface Init_VC : UIViewController
{
    NSTimer*    m_pTimer;
    int         m_iLastRingAnimated;
    float       m_fCounter;
    float       m_fCounterAux;
    NSArray*    m_SortedButtonsAux;
}

//--- IBOutlets:
@property (strong, nonatomic) IBOutlet UIImageView*                 m_Image_SplashScreen;
@property (strong, nonatomic) IBOutlet UILabel*                     m_Label_Info;
@property (strong, nonatomic) IBOutlet UIView*                      m_View_Info;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray* m_aButtonsAux;


//--- IBActions:
- (IBAction) catalog_Clicked:(id)sender;

@end
                            