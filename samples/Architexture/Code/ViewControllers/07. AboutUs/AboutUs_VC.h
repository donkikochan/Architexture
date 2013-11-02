//
//  AboutUs_VC.h
//  Architexture
//
//  Created by DonKikochan on 16/10/13.
//
//

//---Imports:----------
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
//---------------------

@interface AboutUs_VC : UIViewController
{
    
}

//---IBOutlets:
@property (strong, nonatomic) MPMoviePlayerController*  m_pMoviePlayer;
@property (strong, nonatomic) IBOutlet UIScrollView*    m_ScrollView;
@property (strong, nonatomic) IBOutlet UILabel*         m_Label_Info;
@property (strong, nonatomic) IBOutlet UIView*          m_View_Video;
@property (strong, nonatomic) IBOutlet UILabel*         m_Label_AboutUs;

//---IBActions:
- (IBAction)back_Clicked:(id)sender;


//---Function:
//...

@end
