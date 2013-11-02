//
//  ContactUs_VC.h
//  Architexture
//
//  Created by DonKikochan on 16/10/13.
//
//

//---Imports:---
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
//--------------

@interface ContactUs_VC  : BaseViewController <MKMapViewDelegate, MFMailComposeViewControllerDelegate>
{
    float m_BeginScrollPointY;
}

//---IBOutlets:
@property (strong, nonatomic) IBOutlet UIScrollView*    m_ScrollView;
@property (strong, nonatomic) IBOutlet UILabel*         m_Label_Title;
@property (strong, nonatomic) IBOutlet MKMapView*       m_MapView;
@property (strong, nonatomic) IBOutlet UILabel*         m_Label_Info;
@property (strong, nonatomic) IBOutlet UILabel*         m_Label_Name;
@property (strong, nonatomic) IBOutlet UILabel*         m_Label_Email;
@property (strong, nonatomic) IBOutlet UILabel*         m_Label_Subject;
@property (strong, nonatomic) IBOutlet UILabel*         m_Label_Text;
@property (strong, nonatomic) IBOutlet UITextField*     m_TxtField_Name;
@property (strong, nonatomic) IBOutlet UITextField*     m_TxtField_Email;
@property (strong, nonatomic) IBOutlet UITextField*     m_TxtField_Subject;
@property (strong, nonatomic) IBOutlet UITextView*      m_TxtView;
@property (strong, nonatomic) IBOutlet UIButton*        m_Button_Send;

//---IBActions:
- (IBAction) back_Clicked:(id)sender;
- (IBAction) send_Clicked:(id)sender;

//---Functions:

@end
