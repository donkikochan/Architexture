//
//  DeliveryAddress_VC.h
//  ArchiteXture
//
//  Created by DonKikochan on 28/07/13.
//
//

//---Imports:--
#import <UIKit/UIKit.h>
#import "SyncHandler.h"
#import "PayPalMobile.h"
#import "Payment.h"
//-------------

//---Define new types:---
#define DELIVERY_NAME           @"DELIVERY_NAME"
#define DELIVERY_ADDRESS        @"DELIVERY_ADDRESS"
#define DELIVERY_CITY           @"DELIVERY_CITY"
#define DELIVERY_ZIP            @"DELIVERY_ZIP"
#define DELIVERY_PROVINCE       @"DELIVERY_PROVINCE"
#define DELIVERY_EMAIL          @"DELIVERY_EMAIL"
#define DELIVERY_PHONE          @"DELIVERY_PHONE"
#define DELIVERY_ORDER_NOTES    @"DELIVERY_ORDER_NOTES"
#define DELIVERY_COUNTRY        @"DELIVERY_COUNTRY"
//-----------------------


@interface DeliveryAddress_VC : BaseViewController <    PayPalPaymentDelegate, UITextFieldDelegate, UITextViewDelegate,
                                                        UIActionSheetDelegate, UINavigationControllerDelegate,
                                                        UIPickerViewDelegate, SyncHandlerDelegate   >
{
    NSMutableArray* m_aCountries;
    NSString*       m_sCountryCodeSelected;
    float           m_fShippingPrize;
    float           m_fShippingPrize_0;
    float           m_fShippingPrize_1;
    UIActionSheet*  m_ActionSheet;
    UIPickerView*   m_PickerView;
    int             m_iCurrentPicker;
    float           m_BeginScrollPointY;
    Payment*        m_Payment;
    BOOL            m_bCheckingCoupon;
    BOOL            m_bSendingPaymentInfo;
    NSString*       m_sCouponID;
    float           m_fCouponAmmount;
}

//---IBOutlets:
@property (strong, nonatomic) IBOutlet UIScrollView*        m_ScrollView;
@property (strong, nonatomic) IBOutlet UITextField*         m_TextField_Name;
@property (strong, nonatomic) IBOutlet UITextField*         m_TextField_Address;
@property (strong, nonatomic) IBOutlet UITextField*         m_TextField_City;
@property (strong, nonatomic) IBOutlet UITextField*         m_TextField_ZIP;
@property (strong, nonatomic) IBOutlet UITextField*         m_TextField_Province;
@property (strong, nonatomic) IBOutlet UITextField*         m_TextField_EMail;
@property (strong, nonatomic) IBOutlet UITextField*         m_TextField_Coupon;
@property (strong, nonatomic) IBOutlet UITextField*         m_TextField_Phone;
@property (strong, nonatomic) IBOutlet UITextView*          m_TextView_OrderNotes;
@property (strong, nonatomic) IBOutlet UILabel*             m_Label_EMail;
@property (strong, nonatomic) IBOutlet UILabel*             m_Label_Province;
@property (strong, nonatomic) IBOutlet UILabel*             m_Label_ZIP;
@property (strong, nonatomic) IBOutlet UILabel*             m_Label_Country;
@property (strong, nonatomic) IBOutlet UILabel*             m_Label_Title;
@property (strong, nonatomic) IBOutlet UILabel*             m_Label_Name;
@property (strong, nonatomic) IBOutlet UILabel*             m_Label_Address;
@property (strong, nonatomic) IBOutlet UILabel*             m_Label_City;
@property (strong, nonatomic) IBOutlet UILabel*             m_Label_InfoShipping;
@property (strong, nonatomic) IBOutlet UILabel*             m_Label_Summary;
@property (strong, nonatomic) IBOutlet UILabel*             m_Label_Rings;
@property (strong, nonatomic) IBOutlet UILabel*             m_Label_Shipping;
@property (strong, nonatomic) IBOutlet UILabel*             m_Label_Coupon;
@property (strong, nonatomic) IBOutlet UILabel*             m_Label_Phone;
@property (strong, nonatomic) IBOutlet UILabel*             m_Label_OrderNotes;
@property (strong, nonatomic) IBOutlet UILabel*             m_Label_ContinueShopping;
@property (strong, nonatomic) IBOutlet UILabel*             m_Label_Total;
@property (strong, nonatomic) IBOutlet UILabel*             m_Label_RingPrize;
@property (strong, nonatomic) IBOutlet UILabel*             m_Label_ShippingPrize;
@property (strong, nonatomic) IBOutlet UILabel*             m_Label_TotalPrize;
@property (strong, nonatomic) IBOutlet UIButton*            m_Button_Back;
@property (strong, nonatomic) IBOutlet UIButton*            m_TextField_Country;
@property (strong, nonatomic) IBOutlet UIButton*            m_Button_Apply;
@property (strong, nonatomic) IBOutlet UIButton*            m_Button_Back2;
@property (strong, nonatomic) IBOutlet UIButton*            m_Button_Paypal;
@property (strong, nonatomic) IBOutlet UIButton*            m_Button_Country;
@property (strong, nonatomic) IBOutlet UIScrollView*        m_RingScroll;
@property (strong, nonatomic) IBOutlet UISegmentedControl*  m_Segmented_ShippingType;
@property (strong, nonatomic) IBOutlet UILabel*             m_Label_FieldsNotOptionals;

//---IBActions:
- (IBAction) country_Cicked:(id)sender;
- (IBAction) segmentedChangeValue:(id)sender;
- (IBAction) coupon_Clicked:(id)sender;
- (IBAction) back2_Clicked:(id)sender;
- (IBAction) paypal_Clicked:(id)sender;

//---Functions:
//...

@end
