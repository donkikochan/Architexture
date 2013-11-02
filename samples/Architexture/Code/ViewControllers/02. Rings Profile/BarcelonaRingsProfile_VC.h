//
//  ViewController.h
//  achitexture
//
//  Created by DonKikochan on 10/07/13.
//  Copyright (c) 2013 architexture. All rights reserved.
//

//---Imports:----
#import <UIKit/UIKit.h>
#import "RingProfile_VC.h"
//---------------

@interface BarcelonaRingsProfile_VC : RingProfile_VC
{}

//---IBOutlets:
@property (weak, nonatomic) IBOutlet RingProfile_View   *m_View_Ring_01;
@property (weak, nonatomic) IBOutlet RingProfile_View   *m_View_Ring_02;
@property (weak, nonatomic) IBOutlet RingProfile_View   *m_View_Ring_03;
@property (weak, nonatomic) IBOutlet RingProfile_View   *m_View_Ring_04;
@property (weak, nonatomic) IBOutlet RingProfile_View   *m_View_Ring_05;
@property (weak, nonatomic) IBOutlet RingProfile_View   *m_View_Ring_06;

//---Functions:
- (void) PostOnFacebook;
- (void) PostOnTwitter;

@end
