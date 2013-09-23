//
//  ViewLink_VC.h
//  achitexture
//
//  Created by Enric Vergara Carreras on 12/07/13.
//  Copyright (c) 2013 architexture. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewLink_VC : UIViewController <UIWebViewDelegate>
{
    
}

//--- IBOutlets:
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView    *m_ActivityIndicator;
@property (weak, nonatomic) IBOutlet UIWebView                  *m_WebView;

//--- IBOutlets Parameter:
@property (nonatomic, strong) NSString  *urlAddress;

//--- IBOActions:
- (IBAction)back_Clicked:(id)sender;


//---Functions:
//....
@end
