//
//  DeliveryAddress_VC.h
//  ArchiteXture
//
//  Created by DonKikochan on 28/07/13.
//
//

#import <UIKit/UIKit.h>

@interface DeliveryAddress_VC : UIViewController
{
    NSMutableArray  *arrayCountries;
    NSString* m_sCountryCodeSelected;
    
    float m_fShippingPrize;
}

//---IBOutlets:
@property (strong, nonatomic) IBOutlet UIScrollView         *m_ScrollView;
@property (strong, nonatomic) IBOutlet UIButton             *m_Button_Back;
@property (strong, nonatomic) IBOutlet UILabel              *m_Label_Title;
@property (strong, nonatomic) IBOutlet UILabel              *m_Label_Name;
@property (strong, nonatomic) IBOutlet UITextField          *m_TextField_Name;
@property (strong, nonatomic) IBOutlet UILabel              *m_Label_Address;
@property (strong, nonatomic) IBOutlet UITextField          *m_TextField_Address;
@property (strong, nonatomic) IBOutlet UILabel              *m_Label_City;
@property (strong, nonatomic) IBOutlet UITextField          *m_TextField_City;
@property (strong, nonatomic) IBOutlet UILabel              *m_Label_ZIP;
@property (strong, nonatomic) IBOutlet UITextField          *m_TextField_ZIP;
@property (strong, nonatomic) IBOutlet UILabel              *m_Label_Province;
@property (strong, nonatomic) IBOutlet UITextField          *m_TextField_Province;
@property (strong, nonatomic) IBOutlet UILabel              *m_Label_EMail;
@property (strong, nonatomic) IBOutlet UITextField          *m_TextField_EMail;
@property (strong, nonatomic) IBOutlet UILabel              *m_Label_Country;
@property (strong, nonatomic) IBOutlet UIButton             *m_TextField_Country;
@property (strong, nonatomic) IBOutlet UISegmentedControl   *m_Segmented_ShippingType;
@property (strong, nonatomic) IBOutlet UILabel              *m_Label_InfoShipping;
@property (strong, nonatomic) IBOutlet UILabel              *m_Label_Summary;
@property (strong, nonatomic) IBOutlet UILabel              *m_Label_Rings;
@property (strong, nonatomic) IBOutlet UILabel              *m_Label_Shipping;
@property (strong, nonatomic) IBOutlet UILabel              *m_Label_Coupon;
@property (strong, nonatomic) IBOutlet UILabel              *m_Label_Total;
@property (strong, nonatomic) IBOutlet UILabel              *m_Label_RingPrize;
@property (strong, nonatomic) IBOutlet UILabel              *m_Label_ShippingPrize;
@property (strong, nonatomic) IBOutlet UITextField          *m_TextField_Coupon;
@property (strong, nonatomic) IBOutlet UIButton             *m_Button_Apply;
@property (strong, nonatomic) IBOutlet UILabel              *m_Label_TotalPrize;
@property (strong, nonatomic) IBOutlet UIButton             *m_Button_Back2;
@property (strong, nonatomic) IBOutlet UIButton             *m_Button_Paypal;
@property (strong, nonatomic) IBOutlet UIButton             *m_Button_Country;


//---IBActions:
- (IBAction) country_Cicked:(id)sender;
- (IBAction) segmentedChangeValue:(id)sender;
- (IBAction) coupon_Clicked:(id)sender;
- (IBAction) back2_Clicked:(id)sender;
- (IBAction) paypal_Clicked:(id)sender;

//---Functions:

@end
