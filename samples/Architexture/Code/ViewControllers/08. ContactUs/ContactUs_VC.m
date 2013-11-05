//
//  ContactUs_VC.m
//  Architexture
//
//  Created by DonKikochan on 16/10/13.
//
//

//---Imports:-----
#import "ContactUs_VC.h"
#import "PlacePin.h"
//-----------------

@interface ContactUs_VC ()

@end

@implementation ContactUs_VC

#define HEIGHT_TEXT_VIEW_EDIT 560.f

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
    
    [_m_ScrollView setContentSize:CGSizeMake(1, 800)];
    
    //---Localized String:----
    _m_Label_Title.text                 = NSLocalizedString(@"CONTACT_US", nil);
    _m_Label_Info.text                  = NSLocalizedString(@"INFO_CONTACT", nil);
    _m_Label_Name.text                  = NSLocalizedString(@"NAME_CONTACT", nil);
    _m_Label_Subject.text               = NSLocalizedString(@"SUBJECT_CONTACT", nil);
    _m_Label_Text.text                  = NSLocalizedString(@"TEXT_CONTACT", nil);

    _m_TxtField_Name.placeholder       = NSLocalizedString(@"INSERT_NAME", nil);
    _m_TxtField_Subject.placeholder    = NSLocalizedString(@"INSERT_SUBJECT", nil);

    _m_TxtField_Name.text               =
    _m_TxtField_Subject.text            = @"";
    
    [_m_Button_Send setTitle:NSLocalizedString(@"SEND_REQUEST",nil) forState:UIControlStateNormal];
    //-----------------------
   
    m_BeginScrollPointY = 0.f;
    
    [self setupKeyboardControls:self textFields:[NSArray arrayWithObjects:
                                                 _m_TxtField_Name,
                                                 _m_TxtField_Subject,   _m_TxtView , nil]];
    
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
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [_m_MapView setMapType:MKMapTypeStandard];
    CGPoint point = CGPointMake(2.174284, 41.378845);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(point.y, point.x), 3500, 3500);
    [_m_MapView setRegion:region animated:YES];
    
    CLLocationCoordinate2D annotationCoord;
    annotationCoord.latitude    = point.y;
    annotationCoord.longitude   = point.x;
    
    PlacePin *annotationPoint = [[PlacePin alloc] init];
    annotationPoint.pointColor = 0;
    
    annotationPoint.pointID = 0;
    annotationPoint.coordinate = annotationCoord;
    annotationPoint.title = @"ArchiteXture";
    annotationPoint.subtitle = @"info@architexture-online.com";
    
    [_m_MapView addAnnotation:annotationPoint];
    
    _m_MapView.delegate = self;
}

- (MKAnnotationView *)mapView:(MKMapView *)_mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	static NSString *defaultPinID = @"annotationViewId";
	MKAnnotationView *retval = nil;
    //annotation
	if(annotation != _m_MapView.userLocation)
    {
        
		retval = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        PlacePin* kk = (PlacePin*)annotation;
        
        if (kk.pointID == 0)
        {
            retval.image = [UIImage imageNamed:@"google maps.png"];
            //30 × 52 pixels
            float w_offest = 0;
            float h_offset = -13;
            retval.centerOffset = CGPointMake(w_offest, h_offset);
            
        }//128 × 220
    }
    return retval;
}


- (IBAction)back_Clicked:(id)sender
{
    [[AppDelegate mainAppDelegate] setOpenMenu];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)send_Clicked:(id)sender
{
    if ([_m_TxtField_Name.text isEqual:@""])
    {
        [ECommon showAlertInfo:NSLocalizedString(@"NAME_REQUIRED", nil) title:NSLocalizedString(@"ERROR_CONTACTUS",nil)];
        [self jumptTotextField:_m_TxtField_Name];
        [_m_TxtField_Name becomeFirstResponder];
    }
    else if ([_m_TxtField_Subject.text isEqual:@""])
    {
        [ECommon showAlertInfo:NSLocalizedString(@"SUBJECT_REQUIRED", nil) title:NSLocalizedString(@"ERROR_CONTACTUS",nil)];
        [self jumptTotextField:_m_TxtField_Subject];
        [_m_TxtField_Subject becomeFirstResponder];
    }
    else if ([_m_TxtView.text isEqual:@""])
    {
        [ECommon showAlertInfo:NSLocalizedString(@"MESSAGE_REQUIRED", nil) title:NSLocalizedString(@"ERROR_CONTACTUS",nil)];
        CGPoint pt;
        pt.x = 0;
        pt.y = HEIGHT_TEXT_VIEW_EDIT;
        [_m_ScrollView setContentOffset:pt animated:YES];
        [_m_TxtView becomeFirstResponder];
    }
    else
    {
        Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
        
        if (mailClass != nil)
        {
            // We must always check whether the current device is configured for sending emails
            if ([mailClass canSendMail])
            {
                [self displayComposerSheet];
            }
            else{
               [ECommon showAlertInfo:NSLocalizedString(@"EMAIL_NOT_AVAILABLE", nil) title:NSLocalizedString(@"ERROR_CONTACTUS",nil)];
            }
        }
    }
}

-(void)displayComposerSheet
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    
    [picker setSubject:_m_TxtField_Subject.text];
    
    // Set up recipients
    //NSArray *toRecipients = [NSArray arrayWithObject:@"info@architexture-online.com"];
    NSArray *toRecipients = [NSArray arrayWithObject:@"donkikochan@gmail.com"];
    //NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
    //NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
    NSArray *ccRecipients = [[NSArray alloc]init];
    NSArray *bccRecipients = [[NSArray alloc]init];
    
    [picker setToRecipients:toRecipients];
    [picker setCcRecipients:ccRecipients];
    [picker setBccRecipients:bccRecipients];
    
    // Attach an image to the email
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"png"];
    //NSData *myData = [NSData dataWithContentsOfFile:path];
    //[picker addAttachmentData:myData mimeType:@"image/png" fileName:@"rainy"];
    
    // Fill out the email body text
    
    NSString *emailBody = [NSString stringWithFormat:@"Name: %@\n\n-------------\n %@",_m_TxtField_Name.text,
                           _m_TxtView.text];
    [picker setMessageBody:emailBody isHTML:NO];
    
    
    [self presentViewController:picker animated:YES completion:nil];
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
           [ECommon showAlertInfo:NSLocalizedString(@"RESULT_CANCELED", nil) title:@"EMAIL"];
            break;
            
        case MFMailComposeResultSaved:
            [ECommon showAlertInfo:NSLocalizedString(@"RESULT_SAVED", nil) title:@"EMAIL"];
            break;
            
        case MFMailComposeResultSent:
            [ECommon showAlertInfo:NSLocalizedString(@"RESULT_SENT", nil) title:@"EMAIL"];
            break;
            
        case MFMailComposeResultFailed:
            [ECommon showAlertInfo:NSLocalizedString(@"RESULT_FAILED", nil) title:@"EMAIL"];
            break;
            
        default:
            [ECommon showAlertInfo:NSLocalizedString(@"RESULT_NOT_SENT", nil) title:@"EMAIL"];
            break;
            
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void) jumptTotextField:(UITextField*) _txtField
{
    CGPoint pt;
    CGRect rc = [_txtField bounds];
    rc = [_txtField convertRect:rc toView:_m_ScrollView];
    pt = rc.origin;
    pt.x = 0;
    pt.y -= 60;
    [_m_ScrollView setContentOffset:pt animated:YES];
}

- (void) textViewDidBeginEditing:(UITextView *)textView
{
    [super textViewDidBeginEditing:textView];
    
    CGPoint pt;
    pt.x = 0;
    pt.y = HEIGHT_TEXT_VIEW_EDIT;
    [_m_ScrollView setContentOffset:pt animated:YES];
    
    
    [textView becomeFirstResponder];
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    [super textFieldDidBeginEditing:textField];
    
    CGPoint pt;
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:_m_ScrollView];
    pt = rc.origin;
    m_BeginScrollPointY = pt.y;
    pt.x = 0;
    pt.y -= 60;
    [_m_ScrollView setContentOffset:pt animated:YES];
    
    
    [textField becomeFirstResponder];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //svos = scrollView.contentOffset;
    CGPoint pt;
    pt.x = 0;
    pt.y = m_BeginScrollPointY - 30;
}


@end
