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
    NSTimer* m_pTimer;
    int m_iLastRingAnimated;
}

//--- IBOutlets:
@property (strong, nonatomic) IBOutlet UIImageView *m_Image_SplashScreen;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *m_aButtonsAux;


//--- IBActions:
- (IBAction) catalog_Clicked:(id)sender;

@end
                            