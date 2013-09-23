//
//  ViewLink_VC.m
//  achitexture
//
//  Created by Enric Vergara Carreras on 12/07/13.
//  Copyright (c) 2013 architexture. All rights reserved.
//

#import "ViewLink_VC.h"

@interface ViewLink_VC ()

@end

@implementation ViewLink_VC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [_m_WebView setDelegate:self];
    [_m_WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlAddress]]];
    [_m_ActivityIndicator startAnimating];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
    {
        // iOS 7
        [self setNeedsStatusBarAppearanceUpdate];
    }

}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [_m_ActivityIndicator stopAnimating];
    _m_ActivityIndicator.hidden = YES;
}



- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"ERROR LOADING WEBPAGE: %@", error);
}
- (void) webViewDidFinishLoad:(UIWebView*)webView
{
    NSLog(@"finished");
    [_m_ActivityIndicator stopAnimating];
    _m_ActivityIndicator.hidden = YES;
}

- (IBAction)back_Clicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
