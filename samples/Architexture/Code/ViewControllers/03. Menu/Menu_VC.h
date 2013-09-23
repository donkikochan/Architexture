//
//  Menu_VC.h
//  achitexture
//
//  Created by DonKikochan on 10/07/13.
//  Copyright (c) 2013 architexture. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Menu_VC : UIViewController <UIGestureRecognizerDelegate>
{
    int m_iTag;
}

//---IBOutlets:
@property (strong, nonatomic) IBOutlet UITableView      *m_TableView;
@property (strong, nonatomic) IBOutlet UIImageView      *screenShotImageView;
@property (strong, nonatomic) UIImage                   *screenShotImage;
@property (strong, nonatomic) UITapGestureRecognizer    *tapGesture;
@property (strong, nonatomic) UIPanGestureRecognizer    *panGesture;

//---IBActions:
- (IBAction) option_Clicked:(id)sender;


//---Functions:
- (void) slideThenHide;
- (void) adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;
@end
