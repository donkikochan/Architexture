//
//  MapView_VC.h
//  Architexture
//
//  Created by Enric Vergara Carreras on 06/09/13.
//
//

//---Imports:----
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
//----------------

@interface MapView_VC : UIViewController <MKMapViewDelegate>
{
    CGPoint m_aPositions[18];
}


//--- IBOutlets:
@property (weak, nonatomic) IBOutlet MKMapView* m_MapView;
@property (weak, nonatomic) IBOutlet UIButton*  m_Button_Back;


//--- IBActions:
- (IBAction) back_Clicked:(id)sender;

@end
