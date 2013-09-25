//
//  Checkout_VC.h
//  ArchiteXture
//
//  Created by DonKikochan on 27/07/13.
//
//

//---Imports:---
#import <UIKit/UIKit.h>
#import "CheckoutInfo.h"
//--------------



@interface Checkout_VC : UIViewController
{
    float           m_fTotalPrize;
    float           m_fRingPrize;
    int             m_iTotalAmmount;
}

//---IBOutlets:
@property (strong, nonatomic) IBOutlet UITableView* m_TableView;
@property (strong, nonatomic) IBOutlet UIButton*    m_Button_Clear;
@property (strong, nonatomic) IBOutlet UIButton*    m_Button_Back;
@property (strong, nonatomic) IBOutlet UIButton*    m_Button_Order;
@property (strong, nonatomic) IBOutlet UILabel*     m_Label_TotalAmmount;
@property (strong, nonatomic) IBOutlet UILabel*     m_Label_RingPrize;
@property (strong, nonatomic) IBOutlet UILabel*     m_Label_Total;
@property (strong, nonatomic) IBOutlet UILabel*     m_Label_TotalPrize;
@property (strong, nonatomic) IBOutlet UILabel*     m_Label_Title;
@property (strong, nonatomic) IBOutlet UILabel*     m_Label_NotShipping;


//---IBActions:
- (IBAction) clear_Clicked:(id)sender;
- (IBAction) order_Clicked:(id)sender;
- (IBAction) back_Clicked:(id)sender;


//--Functions:

@end
