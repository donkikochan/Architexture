//
//  RingProfile_View.h
//  Architexture
//
//  Created by Enric Vergara Carreras on 30/08/13.
//
//

#import <UIKit/UIKit.h>

@interface RingProfile_View : UIView
{
    
}

//--- IBoutlets:
@property (weak, nonatomic) IBOutlet UIScrollView   *m_ScrollView_Profile;

//--- Carousel de imatges i producte:
@property (weak, nonatomic) IBOutlet UIScrollView   *m_ScrollView_Carousel;
@property (weak, nonatomic) IBOutlet UIScrollView   *m_ScrollView_Product;
@property (weak, nonatomic) IBOutlet UIImageView    *m_Image_Carousel;
@property (weak, nonatomic) IBOutlet UIImageView    *m_Image_Product;

//---- Images:
@property (weak, nonatomic) IBOutlet UIImageView    *m_Image_Info;
@property (weak, nonatomic) IBOutlet UIImageView    *m_Image_Background;
@property (weak, nonatomic) IBOutlet UIImageView    *m_Image_Background_AUX;
@property (weak, nonatomic) IBOutlet UIImageView    *m_Image_Title;
@property (weak, nonatomic) IBOutlet UIImageView    *m_Image_TitleBig;
@property (weak, nonatomic) IBOutlet UIImageView    *m_Image_TitleSmall;
@property (weak, nonatomic) IBOutlet UIImageView    *m_Image_Map;

//--- Buttons:
@property (weak, nonatomic) IBOutlet UIButton       *m_Button_SeeMoreInfo;
@property (weak, nonatomic) IBOutlet UIButton       *m_Button_GoToMenu;
@property (weak, nonatomic) IBOutlet UIButton       *m_Button_Like;
@property (weak, nonatomic) IBOutlet UIButton       *m_Button_Facebook;
@property (weak, nonatomic) IBOutlet UIButton       *m_Button_Twitter;
@property (weak, nonatomic) IBOutlet UIButton       *m_Button_MapView;
@property (weak, nonatomic) IBOutlet UIButton       *m_Button_Shop;
@property (weak, nonatomic) IBOutlet UIButton       *m_Button_Architexture_Online;



@property (weak, nonatomic) IBOutlet UIScrollView   *m_ScrollView_Product_Aux1;
@property (weak, nonatomic) IBOutlet UIScrollView   *m_ScrollView_Product_Aux2;
@property (weak, nonatomic) IBOutlet UIScrollView   *m_ScrollView_Product_Aux3;
@property (weak, nonatomic) IBOutlet UIScrollView   *m_ScrollView_Product_Aux4;
@property (weak, nonatomic) IBOutlet UIImageView    *m_Image_Product_Aux1;
@property (weak, nonatomic) IBOutlet UIImageView    *m_Image_Product_Aux2;
@property (weak, nonatomic) IBOutlet UIImageView    *m_Image_Product_Aux3;
@property (weak, nonatomic) IBOutlet UIImageView    *m_Image_Product_Aux4;
@property (weak, nonatomic) IBOutlet UIButton       *m_Button_Shop_Aux1;
@property (weak, nonatomic) IBOutlet UIButton       *m_Button_Shop_Aux2;
@property (weak, nonatomic) IBOutlet UIButton       *m_Button_Shop_Aux3;
@property (weak, nonatomic) IBOutlet UIButton       *m_Button_Shop_Aux4;



@end
