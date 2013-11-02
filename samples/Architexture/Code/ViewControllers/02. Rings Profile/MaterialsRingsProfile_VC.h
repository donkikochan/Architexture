//
//  MaterialsRingsProfile_VC.h
//  Architexture
//
//  Created by Enric Vergara Carreras on 10/09/13.
//
//

//---Imports:----
#import <UIKit/UIKit.h>
#import "RingProfile_VC.h"
//---------------

@interface MaterialsRingsProfile_VC : RingProfile_VC
{}

//---IBOutlets:
@property (weak, nonatomic) IBOutlet RingProfile_View   *m_View_Ring_01;
@property (weak, nonatomic) IBOutlet RingProfile_View   *m_View_Ring_02;
@property (weak, nonatomic) IBOutlet RingProfile_View   *m_View_Ring_03;
@property (weak, nonatomic) IBOutlet RingProfile_View   *m_View_Ring_04;
@property (weak, nonatomic) IBOutlet RingProfile_View   *m_View_Ring_05;
@property (weak, nonatomic) IBOutlet RingProfile_View   *m_View_Ring_06;

//---IBActions:
//...

//---Functions:
- (void) PostOnFacebook;
- (void) PostOnTwitter;

@end
