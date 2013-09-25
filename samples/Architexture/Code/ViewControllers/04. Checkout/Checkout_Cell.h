//
//  Checkout_Cell.h
//  ArchiteXture
//
//  Created by DonKikochan on 27/07/13.
//
//

#import <UIKit/UIKit.h>

@interface Checkout_Cell : UITableViewCell
{
    NSString* _id;
}

//---IBOutlets:
@property (strong, nonatomic) IBOutlet UIButton*    m_Button_PhotoRing;
@property (strong, nonatomic) IBOutlet UILabel*     m_Label_Quantity;
@property (strong, nonatomic) IBOutlet UILabel*     m_Label_Ammount;
@property (strong, nonatomic) IBOutlet UIButton*    m_Button_Add;
@property (strong, nonatomic) IBOutlet UIButton*    m_Button_Remove;


//---IBActions:
- (IBAction)    imageRing_Clicked:(id)sender;
- (IBAction)    add_Clicked:(id)sender;
- (IBAction)    remove_Clicked:(id)sender;


//--Functions:
- (void)        setId:(NSString*)theID;
- (NSString*)   getId;
@end
