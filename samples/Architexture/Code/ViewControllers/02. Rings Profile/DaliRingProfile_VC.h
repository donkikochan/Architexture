//
//  DaliRingProfile_VC.h
//  Architexture
//
//  Created by Enric Vergara Carreras on 24/09/13.
//
//

//---Imports:---
#import <UIKit/UIKit.h>
#import "RingProfile_View.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
//---------------

//----Define new types:--
typedef enum {
    ACTION_SHEET_FACEBOOK,
    ACTION_SHEET_TWITTER,
    NONE
} TYPE_AS;
//------------------------

@interface DaliRingProfile_VC : UIViewController <UIScrollViewDelegate, UIActionSheetDelegate>
{
    UIActionSheet*              m_ActionSheet;
    TYPE_AS                     m_eTypeActionSheet;
    SLComposeViewController*    m_mySLComposerSheet;
}

//---IBOutlets:
@property (weak, nonatomic) IBOutlet RingProfile_View   *m_View_Ring;


//---IBActions:
//...

//---Functions:
//...

@end
