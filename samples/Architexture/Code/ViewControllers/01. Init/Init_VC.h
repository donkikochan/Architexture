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
    
}

//--- IBOutlets:
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView*   m_ActivityIndicator;
@property (weak, nonatomic) IBOutlet UIButton*                  m_Button_StartApp;
@property (weak, nonatomic) IBOutlet UIButton*                  m_Button_Camera;
@property (weak, nonatomic) IBOutlet UIImageView*               m_Image_BackGround;
@property (weak, nonatomic) IBOutlet UIView*                    m_ViewLoading;

//--- IBActions:
- (IBAction) catalog_Clicked:(id)sender;

@end
