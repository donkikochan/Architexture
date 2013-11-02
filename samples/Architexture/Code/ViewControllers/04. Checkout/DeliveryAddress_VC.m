//
//  DeliveryAddress_VC.m
//  ArchiteXture
//
//  Created by DonKikochan on 28/07/13.
//
//

//---Imports:--
#import "DeliveryAddress_VC.h"
#import "CheckoutRing.h"
//-------------

#define PRIZE_SHIPPING_QUICK_SPAIN      2.5f
#define PRIZE_SHIPPING_SLOW_SPAIN       1.5f
#define PRIZE_SHIPPING_QUICK_NOT_SPAIN  5.99f
#define PRIZE_SHIPPING_SLOW_NOT_SPAIN   2.99f
#define TIME_SLOW_SHIPPING_SPAIN        @"7-8"
#define TIME_QUICK_SHIPPING_SPAIN       @"24-72h"
#define TIME_SLOW_SHIPPING_NOT_SPAIN    @"7-8"
#define TIME_QUICK_SHIPPING_NOT_SPAIN   @"24-72h"

#define HEIGHT_CONTENT_SCROLL           736.f

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
    
    int numBuyedRings = [[AppDelegate mainAppDelegate].m_CheckOutInfo getNumBuyedRings];
    m_BeginScrollPointY = 0.f;
    
    //----Localize Strings:-----
    _m_Label_Name.text          = NSLocalizedString(@"NAME",nil);
    _m_Label_Address.text       = NSLocalizedString(@"ADDRESS",nil);
    _m_Label_City.text          = NSLocalizedString(@"CITY",nil);
    _m_Label_Province.text      = NSLocalizedString(@"PROVINCE",nil);
    _m_Label_ZIP.text           = NSLocalizedString(@"ZIP",nil);
    _m_Label_EMail.text         = NSLocalizedString(@"EMAIL",nil);
    _m_Label_Country.text       = NSLocalizedString(@"COUNTRY",nil);
    _m_Label_Coupon.text        = NSLocalizedString(@"COUPON",nil);
    _m_Label_Title.text         = NSLocalizedString(@"TITLE_DELIVERY",nil);
    _m_Label_Rings.text         = [NSString stringWithFormat:@"%@ (%dx)",NSLocalizedString(@"RINGS",nil),numBuyedRings];
    _m_Label_Shipping.text      = NSLocalizedString(@"SHIPPING",nil);
    _m_Label_Coupon.text        = NSLocalizedString(@"COUPON",nil);
    _m_Label_Total.text         = NSLocalizedString(@"TOTAL",nil);
    _m_Label_ShippingPrize.text = NSLocalizedString(@"SHIPPING_PRIZE",nil);
    _m_Label_InfoShipping.text  = NSLocalizedString(@"INFO_SHIPPING_2",nil);
    _m_Label_Summary.text       = NSLocalizedString(@"SUMMARY_SHIPPING",nil);
    _m_Label_FieldsNotOptionals.text = NSLocalizedString(@"FIELD_NOT_OPTIONAL",nil);
    
    [_m_Button_Apply    setTitle:NSLocalizedString(@"APPLY",nil) forState:UIControlStateNormal];
    [_m_Button_Back     setTitle:NSLocalizedString(@"BACK",nil) forState:UIControlStateNormal];
    [_m_Button_Paypal   setTitle:NSLocalizedString(@"PLACE_ORDER",nil) forState:UIControlStateNormal];
    //--------------------------
    
    _m_TextField_Name.placeholder       = NSLocalizedString(@"INSERT_NAME",nil);
    _m_TextField_Address.placeholder    = NSLocalizedString(@"INSERT_ADDRESS",nil);
    _m_TextField_City.placeholder       = NSLocalizedString(@"INSERT_CITY",nil);
    _m_TextField_ZIP.placeholder        = NSLocalizedString(@"INSERT_ZIP",nil);
    _m_TextField_Province.placeholder   = NSLocalizedString(@"INSERT_PROVINCE",nil);
    _m_TextField_EMail.placeholder      = NSLocalizedString(@"INSERT_EMAIL",nil);
    _m_TextField_Coupon.placeholder     = NSLocalizedString(@"INSERT_COUPON",nil);
    
    _m_TextField_Name.text      =
    _m_TextField_Address.text   =
    _m_TextField_City.text      =
    _m_TextField_ZIP.text       =
    _m_TextField_Province.text  =
    _m_TextField_EMail.text     =
    _m_TextField_Coupon.text    = @"";
    
    m_sCouponID = @"";
    m_fCouponAmmount = 0.f;
    
    //--- Si ja s'han introduit dades reutilitzar-les:----
    NSString* _name = [ECommon getUserDefaultValueStringForKey:DELIVERY_NAME];
    if (_name!= nil && ![_name isEqualToString:@""])
    {
        _m_TextField_Name.text = _name;
    }
    
    NSString* _adddress = [ECommon getUserDefaultValueStringForKey:DELIVERY_ADDRESS];
    if (_adddress != nil && ![_adddress isEqualToString:@""])
    {
        _m_TextField_Address.text = _adddress;
    }
    
    NSString* _city = [ECommon getUserDefaultValueStringForKey:DELIVERY_CITY];
    if (_city != nil && ![_city isEqualToString:@""])
    {
        _m_TextField_City.text = _city;
    }
    
    NSString* _zip = [ECommon getUserDefaultValueStringForKey:DELIVERY_ZIP];
    if (_zip != nil && ![_zip isEqualToString:@""])
    {
        _m_TextField_ZIP.text = _zip;
    }
    
    NSString* _province = [ECommon getUserDefaultValueStringForKey:DELIVERY_PROVINCE];
    if (_province != nil && ![_province isEqualToString:@""])
    {
        _m_TextField_Province.text = _province;
    }
    
    NSString* _email = [ECommon getUserDefaultValueStringForKey:DELIVERY_EMAIL];
    if (_email != nil && ![_email isEqualToString:@""])
    {
        _m_TextField_EMail.text = _email;
    }
    
    NSString* _country = [ECommon getUserDefaultValueStringForKey:DELIVERY_COUNTRY];
    if ( _country!=nil && ![_country isEqualToString:@""])
    {
        m_sCountryCodeSelected  = _country;
    }
    else
    {
        //default value:
        m_sCountryCodeSelected = @"ES";
    }
    //----------------------------------------------------------
    
    
    m_ActionSheet = nil;
    
    [_m_ScrollView setContentSize:CGSizeMake(1.f, HEIGHT_CONTENT_SCROLL)];
    
    
    
    //-----------------Load Countries:---------------------------------
    m_aCountries = [[NSMutableArray alloc] init];
    
    NSArray *countryArray = [NSLocale ISOCountryCodes];
    
    for (NSString *countryCode in countryArray)
    {
        NSString *displayNameString = [[NSLocale currentLocale] displayNameForKey:NSLocaleCountryCode value:countryCode];
        
        NSDictionary *dataItem = [NSMutableDictionary new];
        
        NSLog(@"%@ = %@", countryCode, displayNameString);
        
        [dataItem setValue:[NSString stringWithFormat:@"%@", countryCode] forKey:@"code"];
        [dataItem setValue:displayNameString forKey:@"label"];
        
        [m_aCountries addObject:dataItem ];
    }
    
    [m_aCountries sortWithOptions: 0 usingComparator: ^(id inObj1, id inObj2) {
        NSString    *str1 = [inObj1 objectForKey: @"label"];
        NSString    *str2 = [inObj2 objectForKey: @"label"];
        
        return [str1 compare: str2];
    }];
    
    m_iCurrentPicker = 0;
    for (NSDictionary *country in m_aCountries)
    {
        if([[country objectForKey:@"code"] isEqualToString:m_sCountryCodeSelected])
        {
            [_m_Button_Country setTitle:[country objectForKey:@"label"] forState:UIControlStateNormal];
            break;
        }
        m_iCurrentPicker++;
    }
    //------------------------------------------------------------
    
    
    [self setupKeyboardControls:self textFields:[NSArray arrayWithObjects:
                                                 _m_TextField_Name,     _m_TextField_Address,
                                                 _m_TextField_City,     _m_TextField_ZIP ,
                                                 _m_TextField_Province, _m_TextField_EMail,
                                                 _m_TextField_Coupon,   nil]];
    
    [self updateRingScroll];
    
    
    m_bCheckingCoupon       =
    m_bSendingPaymentInfo   = NO;
    m_Payment = nil;
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
    {
        // iOS 7
        [self setNeedsStatusBarAppearanceUpdate];
    }
}


- (void) updateRingScroll
{
    float w = 50;
    float h = 50;
    int x = 0;
    
    NSString* txtRingBuyed = NSLocalizedString(@"RINGS_BUYED",nil);
    UIFont* font = [UIFont systemFontOfSize:17.f];
    int txt_width = [txtRingBuyed sizeWithFont:font].width;
    UILabel *ringsBuyed = [[UILabel alloc]initWithFrame:CGRectMake(x, 0.0, txt_width, _m_RingScroll.frame.size.height)];
    ringsBuyed.textColor = [UIColor whiteColor];
    ringsBuyed.font = font;
    ringsBuyed.text = txtRingBuyed;
    ringsBuyed.textAlignment = NSTextAlignmentLeft;
    ringsBuyed.backgroundColor = [UIColor clearColor];
    [_m_RingScroll addSubview:ringsBuyed];
    x+= txt_width;
    x+=10;
    
    NSMutableArray*collections =  [[AppDelegate mainAppDelegate].m_CheckOutInfo getCollections];
    for (NSArray* collection in collections)
    {
        for (CheckoutRing* ring in collection)
        {
            if ([ring getAmmount] >0)
            {
                //1. Add ring image:
                CGRect frame = CGRectMake(x, 0.f, w, h);
                UIImageView* imgView = [[UIImageView alloc] initWithFrame:frame];
                imgView.image = [ring getImg];
                [_m_RingScroll addSubview:imgView];
                
                //2. Add background number
                CGRect backgroundFrame = CGRectMake(x+10, 5.f, 30, 40);
                UIView *backgroundNumber = [[UIView alloc] initWithFrame:backgroundFrame];
                backgroundNumber.backgroundColor = [UIColor blackColor];
                backgroundNumber.alpha = 0.4f;
                CALayer * l = backgroundNumber.layer;
                [l setMasksToBounds:YES];
                [l setCornerRadius:5.0];
                [_m_RingScroll addSubview:backgroundNumber];
                
                //3. Add number
                UIFont* font = [UIFont boldSystemFontOfSize:30.f];
                UILabel *ringAmmount = [[UILabel alloc]initWithFrame:frame];
                ringAmmount.textColor = [UIColor whiteColor];
                ringAmmount.font = font;
                ringAmmount.text = [NSString stringWithFormat:@"%d",[ring getAmmount]];
                ringAmmount.textAlignment = NSTextAlignmentCenter;
                ringAmmount.backgroundColor = [UIColor clearColor];
                [_m_RingScroll addSubview:ringAmmount];
                
                x += w + 10;
            }
        }
    }
    [_m_RingScroll setContentSize:CGSizeMake(x, 1.f)];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
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
    if (textField != _m_TextField_Coupon)
    {
        pt.y = m_BeginScrollPointY - 30;
    }
    else{
        pt.y = HEIGHT_CONTENT_SCROLL - _m_ScrollView.frame.size.height;
    }
    [_m_ScrollView setContentOffset:pt animated:YES];
    
    
    if (textField == _m_TextField_Name && _m_TextField_Name.text.length != 0)
    {
        [ECommon setUserDefaultString:_m_TextField_Name.text    forKey:DELIVERY_NAME];
        [ECommon syncUserDefalts];
    }
    else if(textField == _m_TextField_Address && _m_TextField_Address.text.length != 0)
    {
        [ECommon setUserDefaultString:_m_TextField_Address.text forKey:DELIVERY_ADDRESS];
        [ECommon syncUserDefalts];
    }
    else if(textField == _m_TextField_City && _m_TextField_City.text.length != 0)
    {
        [ECommon setUserDefaultString:_m_TextField_City.text    forKey:DELIVERY_CITY];
        [ECommon syncUserDefalts];
    }
    else if(textField == _m_TextField_ZIP && _m_TextField_ZIP.text.length != 0)
    {
        [ECommon setUserDefaultString:_m_TextField_ZIP.text forKey:DELIVERY_ZIP];
        [ECommon syncUserDefalts];
    }
    else if(textField == _m_TextField_Province && _m_TextField_Province.text.length != 0)
    {
        [ECommon setUserDefaultString:_m_TextField_Province.text    forKey:DELIVERY_PROVINCE];
        [ECommon syncUserDefalts];
    }
    else if(textField == _m_TextField_EMail && [ECommon isValidEmail:_m_TextField_EMail.text])
    {
        [ECommon setUserDefaultString:_m_TextField_EMail.text   forKey:DELIVERY_EMAIL];
        [ECommon syncUserDefalts];
    }

}

- (void) ressignAllTxtFields
{
    [_m_TextField_Name      resignFirstResponder];
    [_m_TextField_Address   resignFirstResponder];
    [_m_TextField_City      resignFirstResponder];
    [_m_TextField_ZIP       resignFirstResponder];
    [_m_TextField_Province  resignFirstResponder];
    [_m_TextField_EMail     resignFirstResponder];
    [_m_TextField_Coupon    resignFirstResponder];
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupShippingWithCountryCode:m_sCountryCodeSelected];
    
    float l_ringAmmount = [self getRingsValue];
    _m_Label_RingPrize.text = [NSString stringWithFormat:@"%.02f €",l_ringAmmount];
}


- (void) setupShippingWithCountryCode:(NSString*)code
{
    int numBuyedRings =  [[AppDelegate mainAppDelegate].m_CheckOutInfo getNumBuyedRings];
    
    if ([code isEqualToString:@"ES"])
    {
        _m_Label_InfoShipping.text  = NSLocalizedString(@"INFO_SHIPPING_2",nil);
        if (numBuyedRings >= 2)
        {
            m_fShippingPrize = 0.f;
            m_fShippingPrize_0 = 0.f;
            m_fShippingPrize_1 = 0.f;
            _m_Segmented_ShippingType.enabled = NO;
            _m_Segmented_ShippingType.selectedSegmentIndex = 1;
            NSString *title_segmented_0 = [NSString stringWithFormat:@"%@ %@ (0€)", TIME_SLOW_SHIPPING_SPAIN, NSLocalizedString(@"DAYS",nil)];
            NSString *title_segmented_1 = [NSString stringWithFormat:@"%@ (0€)",TIME_QUICK_SHIPPING_SPAIN];
            [_m_Segmented_ShippingType setTitle:title_segmented_0 forSegmentAtIndex:0];
            [_m_Segmented_ShippingType setTitle:title_segmented_1 forSegmentAtIndex:1];
        }
        else
        {
            m_fShippingPrize = PRIZE_SHIPPING_SLOW_SPAIN;
            _m_Segmented_ShippingType.enabled = YES;
            _m_Segmented_ShippingType.selectedSegmentIndex = 0;
            m_fShippingPrize_0 = PRIZE_SHIPPING_SLOW_SPAIN;
            m_fShippingPrize_1 = PRIZE_SHIPPING_QUICK_SPAIN;
            NSString *title_segmented_0 = [NSString stringWithFormat:@"%@ %@  (%.02f€)",TIME_SLOW_SHIPPING_SPAIN, NSLocalizedString(@"DAYS",nil), PRIZE_SHIPPING_SLOW_SPAIN];
            NSString *title_segmented_1 = [NSString stringWithFormat:@"%@ (%.02f €)",TIME_QUICK_SHIPPING_SPAIN, PRIZE_SHIPPING_QUICK_SPAIN];
            [_m_Segmented_ShippingType setTitle:title_segmented_0 forSegmentAtIndex:0];
            [_m_Segmented_ShippingType setTitle:title_segmented_1 forSegmentAtIndex:1];
        }
        
    }
    else
    {
        _m_Label_InfoShipping.text  = NSLocalizedString(@"INFO_SHIPPING_4",nil);
        
        if (numBuyedRings >= 4)
        {
            m_fShippingPrize = 0.f;
            m_fShippingPrize_0 = 0.f;
            m_fShippingPrize_1 = 0.f;
            _m_Segmented_ShippingType.enabled = NO;
            _m_Segmented_ShippingType.selectedSegmentIndex = 1;
            
            NSString *title_segmented_0 = [NSString stringWithFormat:@"%@ %@ (0€)", TIME_SLOW_SHIPPING_SPAIN, NSLocalizedString(@"DAYS",nil)];
            NSString *title_segmented_1 = [NSString stringWithFormat:@"%@ (0€)",TIME_QUICK_SHIPPING_SPAIN];
            [_m_Segmented_ShippingType setTitle:title_segmented_0 forSegmentAtIndex:0];
            [_m_Segmented_ShippingType setTitle:title_segmented_1 forSegmentAtIndex:1];
        }
        else
        {
            m_fShippingPrize = PRIZE_SHIPPING_SLOW_NOT_SPAIN;
            m_fShippingPrize_0 = PRIZE_SHIPPING_SLOW_NOT_SPAIN;
            m_fShippingPrize_1 = PRIZE_SHIPPING_QUICK_NOT_SPAIN;
            _m_Segmented_ShippingType.enabled = YES;
            _m_Segmented_ShippingType.selectedSegmentIndex = 0;
            
            NSString *title_segmented_0 = [NSString stringWithFormat:@"%@ %@ (%.02f€)",TIME_SLOW_SHIPPING_SPAIN,NSLocalizedString(@"DAYS",nil), PRIZE_SHIPPING_SLOW_NOT_SPAIN];
            NSString *title_segmented_1 = [NSString stringWithFormat:@"%@ (%.02f €)",TIME_QUICK_SHIPPING_SPAIN, PRIZE_SHIPPING_QUICK_NOT_SPAIN];
            [_m_Segmented_ShippingType setTitle:title_segmented_0 forSegmentAtIndex:0];
            [_m_Segmented_ShippingType setTitle:title_segmented_1 forSegmentAtIndex:1];
        }
    }
    
    _m_Label_ShippingPrize.text = [NSString stringWithFormat:@"%.02f €",m_fShippingPrize];
    _m_Label_TotalPrize.text = [NSString stringWithFormat:@"%.02f €",m_fShippingPrize + [self getRingsValue]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)country_Cicked:(id)sender
{
    [self showActionSheetPicker:NSLocalizedString(@"SELECT_COUNTRY", @"") selRow:m_iCurrentPicker];
}


- (void) resignResponderAll
{
    [_m_TextField_Address   resignFirstResponder];
    [_m_TextField_City      resignFirstResponder];
    [_m_TextField_Country   resignFirstResponder];
    [_m_TextField_Coupon    resignFirstResponder];
    [_m_TextField_EMail     resignFirstResponder];
    [_m_TextField_Name      resignFirstResponder];
    [_m_TextField_Province  resignFirstResponder];
    [_m_TextField_ZIP       resignFirstResponder];
}

- (void) showActionSheetPicker:(NSString*)title selRow:(int)row
{
    [self resignResponderAll];
    
    //http://stackoverflow.com/questions/1262574/add-uipickerview-a-button-in-action-sheet-how
    m_ActionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                delegate:self
                                       cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                       otherButtonTitles:nil];
    
    // Add the picker
    UIView *subView;
    if (m_PickerView == nil)
        m_PickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,40,0,0)];
    m_PickerView.delegate = self;
    m_PickerView.showsSelectionIndicator = YES;    // note this is default to NO
    if (row >= 0)
        [m_PickerView selectRow:row inComponent:0 animated:NO];
    subView = m_PickerView;
    
    
    UISegmentedControl *doneButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:NSLocalizedString(@"DONE",@"")]];
    doneButton.momentary = YES;
    doneButton.frame = CGRectMake(235, 7.0f, 60.0f, 30.0f);
    doneButton.segmentedControlStyle = UISegmentedControlStyleBar;
    doneButton.tintColor = [UIColor colorWithRed:72.f/255.f green:107.f/255.f blue:155.f/255.f alpha:1.f];
    [doneButton addTarget:self action:@selector(dismissActionSheetDone:) forControlEvents:UIControlEventValueChanged];
    [m_ActionSheet addSubview:doneButton];
    
    UISegmentedControl *cancelButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:NSLocalizedString(@"CANCEL",@"")]];
    cancelButton.momentary = YES;
    cancelButton.frame = CGRectMake(160, 7.0f, 60.0f, 30.0f);
    cancelButton.segmentedControlStyle = UISegmentedControlStyleBar;
    cancelButton.tintColor = [UIColor blackColor];
    [cancelButton addTarget:self action:@selector(dismissActionSheetCancel:) forControlEvents:UIControlEventValueChanged];
    [m_ActionSheet addSubview:cancelButton];
    
    
    UILabel *title_aux = [[m_ActionSheet subviews] objectAtIndex:0];
    title_aux.font = [UIFont boldSystemFontOfSize:20];
    title_aux.textAlignment = UITextAlignmentLeft;
    
    [m_ActionSheet addSubview:subView];
    [m_ActionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    [m_ActionSheet setBounds:CGRectMake(0,0,320,485)];
}

- (void) dismissActionSheetDone:(id)sender
{
    [m_ActionSheet dismissWithClickedButtonIndex:1 animated:YES];
}

- (void) dismissActionSheetCancel:(id)sender
{
    [m_ActionSheet dismissWithClickedButtonIndex:0 animated:YES];
}


- (IBAction)segmentedChangeValue:(id)sender
{
    if (_m_Segmented_ShippingType.selectedSegmentIndex == 0)
    {
        m_fShippingPrize = m_fShippingPrize_0;
    }
    else{
        m_fShippingPrize = m_fShippingPrize_1;
    }
    
    _m_Label_ShippingPrize.text = [NSString stringWithFormat:@"%.02f €",m_fShippingPrize];
    _m_Label_TotalPrize.text = [NSString stringWithFormat:@"%.02f €",m_fShippingPrize + [self getRingsValue]];
}

- (IBAction)coupon_Clicked:(id)sender
{
    if (_m_TextField_Coupon.text.length == 0)
    {
        [ECommon showAlertInfo:NSLocalizedString(@"WARNING",nil) title:NSLocalizedString(@"FIELD_NOT_OPTIONAL", nil)];
    }
    else
    {
        if (m_Payment == nil)
        {
            m_Payment = [[Payment alloc] init:self];
        }
        m_bCheckingCoupon = YES;
        [ECommon showProgressInView:self.view withText:NSLocalizedString(@"CHECKING_COUPON",nil)];
        [m_Payment checkCouponWithCode:_m_TextField_Coupon.text];
    }
}


- (IBAction)back2_Clicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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

- (BOOL) checkDeliveryInfo
{
    if (_m_TextField_Name.text.length == 0)
    {
        [ECommon showAlertInfo:NSLocalizedString(@"NAME_REQUIRED", nil) title:NSLocalizedString(@"ERROR_DELIVERY",nil)];
        [self jumptTotextField:_m_TextField_Name];
        [_m_TextField_Name becomeFirstResponder];
        return NO;
    }
    if (_m_TextField_Address.text.length == 0)
    {
        [ECommon showAlertInfo:NSLocalizedString(@"ADDRESS_REQUIRED", nil) title:NSLocalizedString(@"ERROR_DELIVERY",nil)];
        [self jumptTotextField:_m_TextField_Address];
        [_m_TextField_Address becomeFirstResponder];
        return NO;
    }
    if (_m_TextField_City.text.length == 0)
    {
        [ECommon showAlertInfo:NSLocalizedString(@"CITY_REQUIRED", nil) title:NSLocalizedString(@"ERROR_DELIVERY",nil)];
        [self jumptTotextField:_m_TextField_City];
        [_m_TextField_City becomeFirstResponder];
        return NO;
    }
    if (_m_TextField_ZIP.text.length == 0)
    {
        [ECommon showAlertInfo:NSLocalizedString(@"ZIP_REQUIRED", nil) title:NSLocalizedString(@"ERROR_DELIVERY",nil)];
        [self jumptTotextField:_m_TextField_City];
        [_m_TextField_ZIP becomeFirstResponder];
        return NO;
    }
    if (_m_TextField_Province.text.length == 0)
    {
        [ECommon showAlertInfo:NSLocalizedString(@"PROVINCE_REQUIRED", nil) title:NSLocalizedString(@"ERROR_DELIVERY",nil)];
        [self jumptTotextField:_m_TextField_Province];
        [_m_TextField_Province becomeFirstResponder];
        return NO;
    }
    if (_m_TextField_EMail.text.length == 0)
    {
        [ECommon showAlertInfo:NSLocalizedString(@"EMAIL_REQUIRED", nil) title:NSLocalizedString(@"ERROR_DELIVERY",nil)];
        [self jumptTotextField:_m_TextField_EMail];
        [_m_TextField_EMail becomeFirstResponder];
        return NO;
    }
    if (![ECommon isValidEmail:_m_TextField_EMail.text])
    {
        [ECommon showAlertInfo:NSLocalizedString(@"INTRODUCE_VALID_EMAIL", nil) title:NSLocalizedString(@"ERROR_DELIVERY",nil)];
        [self jumptTotextField:_m_TextField_EMail];
        [_m_TextField_EMail becomeFirstResponder];
        return NO;
    }
    
    
    return YES;
}

- (IBAction)paypal_Clicked:(id)sender
{
    if (![self checkDeliveryInfo])
    {
        return;
    }
    
    
    float l_fAmmount = [self getRingsValue];
    l_fAmmount += m_fShippingPrize;
    
    // Create a PayPalPayment
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    float value = [_m_Label_TotalPrize.text floatValue];
    payment.amount =  [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithFloat:value] decimalValue]];
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
    [PayPalPaymentViewController setEnvironment:PayPalEnvironmentSandbox];
    
    // Provide a payerId that uniquely identifies a user within the scope of your system,
    // such as an email address or user ID.
    NSString *aPayerId = _m_TextField_EMail.text;
    
    // Create a PayPalPaymentViewController with the credentials and payerId, the PayPalPayment
    // from the previous step, and a PayPalPaymentDelegate to handle the results.
    PayPalPaymentViewController *paymentViewController;
    paymentViewController = [[PayPalPaymentViewController alloc] initWithClientId:@"AW9_rRArXURSUv7WVIWkxQWvnBxQuPdMq8dsAXKmAAbDz2S1pWa4Tfp7LS_G"
                                                                    receiverEmail:@"enric.cipsa@gmail.com"
                                                                          payerId:aPayerId
                                                                          payment:payment
                                                                         delegate:self];
    
    // Present the PayPalPaymentViewController.
    [self presentViewController:paymentViewController animated:YES completion:nil];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) //Button DONE
    {
        m_iCurrentPicker = [m_PickerView selectedRowInComponent:0];
        
        NSDictionary *country = [m_aCountries objectAtIndex:m_iCurrentPicker];
        
        [_m_Button_Country setTitle:[country objectForKey:@"label"] forState:UIControlStateNormal];
        m_sCountryCodeSelected = [country objectForKey:@"code"];
        
        [ECommon setUserDefaultString:m_sCountryCodeSelected    forKey:DELIVERY_COUNTRY];
        [ECommon syncUserDefalts];
        
        [self setupShippingWithCountryCode:m_sCountryCodeSelected];
    }
    else if (buttonIndex == 0) //Button CANCEL
    {
        //Nothing to do.
    }
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSDictionary *country = [m_aCountries objectAtIndex:row];
    return [country objectForKey:@"label"];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (m_aCountries == nil)
        return 0;
    return [m_aCountries count];
}


- (void) syncDone:(BOOL)success object:(BaseObject*)obj
{
    if (success)
    {
         if ([obj isKindOfClass:[Payment class]])
         {
             if (m_bCheckingCoupon)
             {
                 m_bCheckingCoupon = NO;
                 //TODO.. hacer lo que pertoque con los datos...
                 NSString *msg = NSLocalizedString(@"COUPON_OK",nil);
                 [ECommon setProgressDoneAndHideWithText:msg andDelay:3.f];
                 
                 m_sCouponID        = m_Payment.couponID_DB;
                 m_fCouponAmmount   = [m_Payment.couponAmmount floatValue];
                 
                 float l_ringAmmount = [self getRingsValue];
                 _m_Label_RingPrize.text = [NSString stringWithFormat:@"%.02f € (-%.02f%%)",l_ringAmmount, m_fCouponAmmount];
                 
                 _m_Label_TotalPrize.text = [NSString stringWithFormat:@"%.02f €",m_fShippingPrize + [self getRingsValue]];
             }
             else if (m_bSendingPaymentInfo)
             {
                 m_bSendingPaymentInfo = NO;
                 [ECommon hideProgress];
                 [ECommon showAlertInfo:NSLocalizedString(@"THANKS_PURCHASE",nil) title:NSLocalizedString(@"PURCHASE_OK",nil)];
             }
         }
    }
    else
    {
        //Show error message
        if (obj!=nil && obj.msg != nil && obj.msg.length > 0)
        {
            if (m_bCheckingCoupon)
            {
                [ECommon setProgressErrorAndHideWithText:@"Cupon invalid o caducat" andDelay:2.f];
            }
            else if (m_bSendingPaymentInfo)
            {
                [ECommon hideProgress];
                [ECommon showAlertInfo:NSLocalizedString(@"CONTACT_ERROR_PURCHASE",nil) title:NSLocalizedString(@"PURCHASE_NO_OK",nil)];
            }
            else
            {
                [ECommon setProgressDetailsLabel:obj.msg];
                [ECommon setProgressErrorAndHideWithText:NSLocalizedString(@"PROBLEM_DETECTED", @"")];
            }
        }
        else
        {
            [ECommon setProgressErrorAndHideWithText:NSLocalizedString(@"CONNECTION_ERROR", @"")];
        }
        
        m_bSendingPaymentInfo   =
        m_bCheckingCoupon       = NO;
    }
}


#pragma mark - PayPalPaymentDelegate methods

- (void)payPalPaymentDidComplete:(PayPalPayment *)completedPayment
{
    // Payment was processed successfully; send to server for verification and fulfillment.
    [self verifyCompletedPayment:completedPayment];
    
    // Dismiss the PayPalPaymentViewController.
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) payPalPaymentDidCancel
{
    // The payment was canceled; dismiss the PayPalPaymentViewController.
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) verifyCompletedPayment:(PayPalPayment *)completedPayment
{
    // Send the entire confirmation dictionary
    NSData *confirmation = [NSJSONSerialization dataWithJSONObject:completedPayment.confirmation
                                                           options:0
                                                             error:nil];
    
    // Send confirmation to your server; your server should verify the proof of payment
    // and give the user their goods or services. If the server is not reachable, save
    // the confirmation and try again later.
    
    if (m_Payment == nil)
    {
        m_Payment = [[Payment alloc] init:self];
    }
    m_bSendingPaymentInfo = YES;
    [ECommon showProgressInView:self.view withText:NSLocalizedString(@"VERIFYING_PAYMENT",nil)];
    
    NSString* name          = _m_TextField_Name.text;
    NSString* email         = _m_TextField_EMail.text;
    NSString* address       = _m_TextField_Address.text;
    NSString* city          = _m_TextField_City.text;
    NSString* zip           = _m_TextField_ZIP.text;
    NSString* country       = [_m_Button_Country titleForState:UIControlStateNormal];
    
    NSString* slowShipping  = @"-1";
    if (_m_Segmented_ShippingType.selectedSegmentIndex == 0)
    {
        //Slow shipping:
        slowShipping = @"1";
    }
    else{
        //Quick Shipping
        slowShipping = @"0";
    }
   
    
    float l_fAmmount = [self getRingsValue];
    l_fAmmount += m_fShippingPrize;
    NSString* totalAmmount  = [NSString stringWithFormat:@"%f", l_fAmmount];
    
    NSArray* collections = [[AppDelegate mainAppDelegate].m_CheckOutInfo getCollections];
    
    [m_Payment sendPaymentInfoWithName:name withEmail:email withAddress:address withCity:city withZIP:zip withCountry:country withSlowShipping:slowShipping withTotalAmmount:totalAmmount withCollections:collections];
}


- (float) getRingsValue
{
    int numBuyedRings = [[AppDelegate mainAppDelegate].m_CheckOutInfo getNumBuyedRings];
    float l_fAmmount = numBuyedRings*RING_PRIZE;
    if (![m_sCouponID isEqualToString:@""])
    {
        l_fAmmount = l_fAmmount* ((100.f - m_fCouponAmmount)/100.f);
    }
    return l_fAmmount;
}

- (void) viewDidUnload
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

@end
