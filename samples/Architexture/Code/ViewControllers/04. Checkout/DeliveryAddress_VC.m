//
//  DeliveryAddress_VC.m
//  ArchiteXture
//
//  Created by DonKikochan on 28/07/13.
//
//

//---Imports:--
#import "DeliveryAddress_VC.h"
//-------------

#define PRIZE_SHIPPING_QUICK_SPAIN      2.5f
#define PRIZE_SHIPPING_SLOW_SPAIN       1.5f
#define PRIZE_SHIPPING_QUICK_NOT_SPAIN  2.99f
#define PRIZE_SHIPPING_SLOW_NOT_SPAIN   5.99f
#define TIME_SLOW_SHIPPING_SPAIN        @"7-8"
#define TIME_QUICK_SHIPPING_SPAIN       @"24-72h"
#define TIME_SLOW_SHIPPING_NOT_SPAIN    @"7-8"
#define TIME_QUICK_SHIPPING_NOT_SPAIN   @"24-72h"

@interface DeliveryAddress_VC ()

@end

@implementation DeliveryAddress_VC

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
    
    //----Localize Strings:-----
    _m_Label_Name.text      = NSLocalizedString(@"NAME",nil);
    _m_Label_Address.text   = NSLocalizedString(@"ADDRESS",nil);
    _m_Label_City.text      = NSLocalizedString(@"CITY",nil);
    _m_Label_Province.text  = NSLocalizedString(@"PROVINCE",nil);
    _m_Label_ZIP.text       = NSLocalizedString(@"ZIP",nil);
    _m_Label_EMail.text     = NSLocalizedString(@"EMAIL",nil);
    _m_Label_Country.text   = NSLocalizedString(@"COUNTRY",nil);
    _m_Label_Coupon.text    = NSLocalizedString(@"COUPON",nil);
    _m_Label_Title.text     = NSLocalizedString(@"TITLE_DELIVERY",nil);
    [_m_Button_Back setTitle:NSLocalizedString(@"BUTTON_BACK",nil) forState:UIControlStateNormal];
    
    _m_Label_InfoShipping.text  = NSLocalizedString(@"INFO_SHIPPING",nil);
    _m_Label_Summary.text       = NSLocalizedString(@"SUMMARY_SHIPPING",nil);
    //--------------------------

    [_m_ScrollView setContentSize:CGSizeMake(1.f, 650.f)];
    
    arrayCountries = [[NSMutableArray alloc] init];
    
    NSArray *countryArray = [NSLocale ISOCountryCodes];
    
    for (NSString *countryCode in countryArray)
    {
        NSString *displayNameString = [[NSLocale currentLocale] displayNameForKey:NSLocaleCountryCode value:countryCode];
        
        NSDictionary *dataItem = [NSMutableDictionary new];
        
        NSLog(@"%@ = %@", countryCode, displayNameString);
        
        [dataItem setValue:[NSString stringWithFormat:@"%@", countryCode] forKey:@"code"];
        [dataItem setValue:displayNameString forKey:@"label"];
        
        [arrayCountries addObject:dataItem ];
    }
    
    [arrayCountries sortWithOptions: 0 usingComparator: ^(id inObj1, id inObj2) {
        NSString    *str1 = [inObj1 objectForKey: @"label"];
        NSString    *str2 = [inObj2 objectForKey: @"label"];
        
        return [str1 compare: str2];
    }];
    
    m_sCountryCodeSelected = @"ES";
    for (NSDictionary *country in arrayCountries)
    {
        if([[country objectForKey:@"code"] isEqualToString:@"ES"])
        {
            [_m_Button_Country setTitle:[country objectForKey:@"label"] forState:UIControlStateNormal];
        }
    }
    
    [self setupKeyboardControls:self textFields:[NSArray arrayWithObjects:
                                                 _m_TextField_Name,     _m_TextField_Address,
                                                 _m_TextField_City,     _m_TextField_ZIP ,
                                                 _m_TextField_Province, _m_TextField_EMail,
                                                 _m_TextField_Coupon,   nil]];
    
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

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    int numBuyedRings =  [[AppDelegate mainAppDelegate].m_CheckOutInfo getNumBuyedRings];
    _m_Label_RingPrize.text = [NSString stringWithFormat:@"%d €",(int)(numBuyedRings*RING_PRIZE)];
    
    [self setupShippingWithCountryCode:@"ES"];
    
    int numRings = [[AppDelegate mainAppDelegate].m_CheckOutInfo getNumBuyedRings];
    _m_Label_RingPrize.text = [NSString stringWithFormat:@"%.02f €",numRings*RING_PRIZE];
}


- (void) setupShippingWithCountryCode:(NSString*)code
{
    int numBuyedRings =  [[AppDelegate mainAppDelegate].m_CheckOutInfo getNumBuyedRings];
    
    if ([code isEqualToString:@"ES"])
    {
        if (numBuyedRings >= 2)
        {
            m_fShippingPrize = 0.f;
            _m_Segmented_ShippingType.enabled = NO;
            _m_Segmented_ShippingType.selectedSegmentIndex = 1;
            NSString *title_segmented_0 = [NSString stringWithFormat:@"%@ días (0€)",TIME_SLOW_SHIPPING_SPAIN];
            NSString *title_segmented_1 = [NSString stringWithFormat:@"%@ (0€)",TIME_QUICK_SHIPPING_SPAIN];
            [_m_Segmented_ShippingType setTitle:title_segmented_0 forSegmentAtIndex:0];
            [_m_Segmented_ShippingType setTitle:title_segmented_1 forSegmentAtIndex:1];
        }
        else
        {
            m_fShippingPrize = PRIZE_SHIPPING_SLOW_SPAIN;
            _m_Segmented_ShippingType.enabled = YES;
            _m_Segmented_ShippingType.selectedSegmentIndex = 0;
            
            NSString *title_segmented_0 = [NSString stringWithFormat:@"%@ días (%.02f €)",TIME_SLOW_SHIPPING_SPAIN, PRIZE_SHIPPING_SLOW_SPAIN];
            NSString *title_segmented_1 = [NSString stringWithFormat:@"%@ (%.02f €)",TIME_QUICK_SHIPPING_SPAIN, PRIZE_SHIPPING_QUICK_SPAIN];
            [_m_Segmented_ShippingType setTitle:title_segmented_0 forSegmentAtIndex:0];
            [_m_Segmented_ShippingType setTitle:title_segmented_1 forSegmentAtIndex:1];
        }
        _m_Label_ShippingPrize.text = [NSString stringWithFormat:@"%.02f €",m_fShippingPrize];
    }
    else
    {
        if (numBuyedRings >= 4)
        {
            m_fShippingPrize = 0.f;
            _m_Segmented_ShippingType.enabled = NO;
            _m_Segmented_ShippingType.selectedSegmentIndex = 1;
            
            NSString *title_segmented_0 = [NSString stringWithFormat:@"%@ días (0€)",TIME_SLOW_SHIPPING_SPAIN];
            NSString *title_segmented_1 = [NSString stringWithFormat:@"%@ (0€)",TIME_QUICK_SHIPPING_SPAIN];
            [_m_Segmented_ShippingType setTitle:title_segmented_0 forSegmentAtIndex:0];
            [_m_Segmented_ShippingType setTitle:title_segmented_1 forSegmentAtIndex:1];
        }
        else
        {
            m_fShippingPrize = PRIZE_SHIPPING_SLOW_NOT_SPAIN;
            _m_Segmented_ShippingType.enabled = YES;
            _m_Segmented_ShippingType.selectedSegmentIndex = 0;
            
            NSString *title_segmented_0 = [NSString stringWithFormat:@"%@ días (%.02f €)",TIME_SLOW_SHIPPING_SPAIN, PRIZE_SHIPPING_SLOW_NOT_SPAIN];
            NSString *title_segmented_1 = [NSString stringWithFormat:@"%@ (%.02f €)",TIME_QUICK_SHIPPING_SPAIN, PRIZE_SHIPPING_QUICK_NOT_SPAIN];
            [_m_Segmented_ShippingType setTitle:title_segmented_0 forSegmentAtIndex:0];
            [_m_Segmented_ShippingType setTitle:title_segmented_1 forSegmentAtIndex:1];
        }
        _m_Label_ShippingPrize.text = [NSString stringWithFormat:@"%.02f €",m_fShippingPrize];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setM_Button_Back:nil];
    [self setM_Label_Title:nil];
    [self setM_Label_Name:nil];
    [self setM_TextField_Name:nil];
    [self setM_Label_Address:nil];
    [self setM_TextField_Address:nil];
    [self setM_Label_City:nil];
    [self setM_TextField_City:nil];
    [self setM_Label_ZIP:nil];
    [self setM_TextField_ZIP:nil];
    [self setM_Label_Province:nil];
    [self setM_TextField_Province:nil];
    [self setM_Label_EMail:nil];
    [self setM_TextField_EMail:nil];
    [self setM_Label_Country:nil];
    [self setM_TextField_Country:nil];
    [self setM_Segmented_ShippingType:nil];
    [self setM_Label_InfoShipping:nil];
    [self setM_Label_Summary:nil];
    [self setM_Label_Rings:nil];
    [self setM_Label_Shipping:nil];
    [self setM_Label_Coupon:nil];
    [self setM_Label_Total:nil];
    [self setM_Label_RingPrize:nil];
    [self setM_Label_ShippingPrize:nil];
    [self setM_TextField_Coupon:nil];
    [self setM_Button_Apply:nil];
    [self setM_Label_TotalPrize:nil];
    [self setM_Button_Back:nil];
    [self setM_Button_Back2:nil];
    [self setM_Button_Paypal:nil];
    [self setM_Button_Country:nil];
    [self setM_ScrollView:nil];
    [super viewDidUnload];
}


- (IBAction)country_Cicked:(id)sender
{
    
}


- (IBAction)segmentedChangeValue:(id)sender
{
    
}

- (IBAction)coupon_Clicked:(id)sender
{
    
}


- (IBAction)back2_Clicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)paypal_Clicked:(id)sender
{
    // Create a PayPalPayment
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = [[NSDecimalNumber alloc] initWithString:@"39.95"];
    payment.currencyCode = @"EUR";
    payment.shortDescription = NSLocalizedString(@"ARCHITEXTURE_PRODUCT",nil);
    
    // Check whether payment is processable.
    if (!payment.processable)
    {
        // If, for example, the amount was negative or the shortDescription was empty, then
        // this payment would not be processable. You would want to handle that here.
        return;
    }
    
    
    // Start out working with the test environment! When you are ready, remove this line to switch to live.
    [PayPalPaymentViewController setEnvironment:PayPalEnvironmentNoNetwork];
    
    // Provide a payerId that uniquely identifies a user within the scope of your system,
    // such as an email address or user ID.
    NSString *aPayerId = @"someuser@somedomain.com";
    
    // Create a PayPalPaymentViewController with the credentials and payerId, the PayPalPayment
    // from the previous step, and a PayPalPaymentDelegate to handle the results.
    PayPalPaymentViewController *paymentViewController;
    paymentViewController = [[PayPalPaymentViewController alloc] initWithClientId:@"YOUR_CLIENT_ID"
                                                                    receiverEmail:@"YOUR_PAYPAL_EMAIL_ADDRESS@gmail.com"
                                                                          payerId:aPayerId
                                                                          payment:payment
                                                                         delegate:self];
    
    // Present the PayPalPaymentViewController.
    [self presentViewController:paymentViewController animated:YES completion:nil];
}

// SomeViewController.m

#pragma mark - PayPalPaymentDelegate methods

- (void)payPalPaymentDidComplete:(PayPalPayment *)completedPayment
{
    // Payment was processed successfully; send to server for verification and fulfillment.
    [self verifyCompletedPayment:completedPayment];
    
    // Dismiss the PayPalPaymentViewController.
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel
{
    // The payment was canceled; dismiss the PayPalPaymentViewController.
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)verifyCompletedPayment:(PayPalPayment *)completedPayment
{
    // Send the entire confirmation dictionary
    NSData *confirmation = [NSJSONSerialization dataWithJSONObject:completedPayment.confirmation
                                                           options:0
                                                             error:nil];
    
    // Send confirmation to your server; your server should verify the proof of payment
    // and give the user their goods or services. If the server is not reachable, save
    // the confirmation and try again later.
}

@end
