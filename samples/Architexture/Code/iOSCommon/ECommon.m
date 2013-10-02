//
//  ECommon.m
//
//  Created by Jordi Badia Santaulària on 24/02/12.
//  Copyright (c) 2012 Endepro Software. All rights reserved.
//

#import "ECommon.h"
#import "EConsts.h"
#import "Base64.h"

@implementation ECommon

#pragma mark - Database Functions
+ (EDatabase*) createDatabaseSqlite3
{
#if !OBJC_ARC_ENABLED
    return [[[EDatabase alloc] initWithScript:DATABASE_SCRIPT] autorealease];
#else
    return [[EDatabase alloc] initWithScript:DATABASE_SCRIPT];
#endif
}

+ (EDatabase*) createDatabaseSqlite3AndOpen
{
    EDatabase* db = [self createDatabaseSqlite3];
    if (![db openWithName:DB_NAME])
        return nil;
    else
        return db;
}

#pragma mark - Date Functions
+ (NSString*) formatDate:(NSDate*)date withFormat:(NSString*)format
{
    if (date == nil)
        return @"";
    
    @try
    {
#if !OBJC_ARC_ENABLED
        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
#else
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
#endif
        
        formatter.dateFormat = format;
        return [formatter stringFromDate:date];
    }
    @catch (NSException *exception)
    {
#ifdef DEBUG_ECOMMON
        NSLog(@"%@", exception.description);
#endif
        return @"";
    }
}

+ (NSString*) formatDate:(NSDate*)date withStyle:(NSDateFormatterStyle)style
{
    if (date == nil)
        return @"";
    
    @try
    {
#if !OBJC_ARC_ENABLED
        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
#else
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
#endif
        formatter.dateStyle = style;
        return [formatter stringFromDate:date];
    }
    @catch (NSException *exception)
    {
#ifdef DEBUG_ECOMMON
        NSLog(@"%@", exception.description);
#endif
        return @"";
    }
}

+ (NSString*) formatDate:(NSDate*)date
{
    return [self formatDate:date withStyle:NSDateFormatterMediumStyle];
}

+ (NSString*) formatDateTime:(NSDate*)date withDateStyle:(NSDateFormatterStyle)dateStyle andTimeStyle:(NSDateFormatterStyle)timeStyle
{
    if (date == nil)
        return @"";
    
    @try
    {
#if !OBJC_ARC_ENABLED
        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
#else
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
#endif
        formatter.dateStyle = dateStyle;
        formatter.timeStyle = timeStyle;
        return [formatter stringFromDate:date];
    }
    @catch (NSException *exception)
    {
#ifdef DEBUG_ECOMMON
        NSLog(@"%@", exception.description);
#endif
        return @"";
    }
}

+ (NSString*) formatDateTime:(NSDate*)date
{
    return [self formatDateTime:date withDateStyle:NSDateFormatterMediumStyle andTimeStyle:NSDateFormatterShortStyle];
}

+ (NSDate*) dateFromString:(NSString*)str withFormat:(NSString*)format
{
    return [self dateFromString:str withFormat:format andLocale:DATE_DEFAULT_LOCALE];
}

+ (NSDate*) dateFromString:(NSString*)str withFormat:(NSString*)format andLocale:(NSString*)locale
{
    if (str == nil || str.length == 0)
        return nil;
    
    @try
    {
#if !OBJC_ARC_ENABLED
        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
#else
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
#endif
        formatter.dateFormat = format;
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:locale];
        return [formatter dateFromString:str];
    }
    @catch (NSException *exception)
    {
#ifdef DEBUG_ECOMMON
        NSLog(@"%@", exception.description);
#endif
        return nil;
    }
}

#pragma mark - StatusBar Functions
+ (void) showNetworkActivityIndicator
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

+ (void) hideNetworkActivityIndicator
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

+ (void) showStatusBar
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}

+ (void) hideStatusBar
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

#pragma mark - User Defaults
+ (void) setUserDefaultValue:(id)value forKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (value != nil)
        [defaults setObject:value forKey:key];
    else
        [defaults setNilValueForKey:key];
}

+ (void) setUserDefaultString:(NSString*)value forKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:value forKey:key];
}

+ (void) setUserDefaultInt:(NSInteger)value forKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:value forKey:key];
}

+ (void) setUserDefaultFloat:(float)value forKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:value forKey:key];
}

+ (void) setUserDefaultDouble:(double)value forKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setDouble:value forKey:key];
}

+ (void) setUserDefaultBool:(BOOL)value forKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:value forKey:key];
}

+ (void) setUserDefaultDate:(NSDate*)value forKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (value != nil)
        [defaults setObject:value forKey:key];
    else
        [defaults setNilValueForKey:key];
}

+ (id) getUserDefaultValueForKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults valueForKey:key];
}

+ (NSString*) getUserDefaultValueStringForKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id res = [defaults stringForKey:key];
    if (res == nil)
        return @"";
    else
        return res;
}

+ (NSInteger) getUserDefaultValueIntForKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults integerForKey:key];
}

+ (float) getUserDefaultValueFloatForKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults floatForKey:key];
}

+ (double) getUserDefaultValueDoubleForKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults doubleForKey:key];
}

+ (BOOL) getUserDefaultValueBoolForKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:key];
}

+ (NSDate*) getUserDefaultValueDateForKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults valueForKey:key];
}

+ (BOOL) syncUserDefalts
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults synchronize];
}

#pragma mark - MBProgressHUD Functions

static MBProgressHUD *_HUD=nil;
static EProgressDelegate *_HUDDelegate=nil;

+ (MBProgressHUD*) HUD
{
    return _HUD;
}

+ (BOOL) createProgress:(UIView*)view
{
    if (_HUD == nil)
    {
#ifdef DEBUG_ECOMMON
        NSLog(@"ECommon >> Creating Progress");
#endif
        _HUDDelegate = [[EProgressDelegate alloc] init];
        _HUD = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:_HUD];
        _HUD.dimBackground = PROGRESS_BACKGROUND;
        _HUD.delegate = _HUDDelegate;
        _HUD.minSize = PROGRESS_MIN_SIZE;
#ifdef DEBUG_ECOMMON
        NSLog(@"ECommon >> Progress Created");
#endif
        return YES;
    }
    return NO;
}

+ (BOOL) showProgressWhileExecuting:(SEL)selector onTarget:(id)target inView:(UIView*)view withText:(NSString*)text andObject:(NSObject*)obj
{
    if (![self createProgress:view])
        return NO;
    
    if (text != nil)
        _HUD.labelText = text;
	
    [_HUD showWhileExecuting:selector onTarget:target withObject:obj animated:YES];
    return YES;
}

+ (BOOL) showProgressWhileExecuting:(SEL)selector onTarget:(id)target inView:(UIView*)view withText:(NSString*)text
{
    return [self showProgressWhileExecuting:selector onTarget:target inView:view withText:text andObject:nil];
}

+ (BOOL) showProgressWhileExecuting:(SEL)selector onTarget:(id)target inView:(UIView*)view
{
    return [self showProgressWhileExecuting:selector onTarget:target inView:view withText:nil andObject:nil];
}

+ (BOOL) showProgressInView:(UIView*)view withText:(NSString*)text
{
    if (![self createProgress:view])
        return NO;
    
    if (text != nil)
        _HUD.labelText = text;
	
    [_HUD show:YES];
    return YES;
}

+ (BOOL) showProgressInView:(UIView*)view
{
    return [self showProgressInView:view withText:nil];
}

+ (void) hideProgress
{
    if (_HUD != nil)
        [_HUD hide:YES];
}

+ (void) hideProgressAfterDelay:(NSTimeInterval)delay
{
    if (_HUD != nil)
        [_HUD hide:YES afterDelay:delay];
}

+ (void) setProgressDoneAndHideWithText:(NSString*)text andDelay:(NSTimeInterval)delay
{
    if (_HUD != nil)
    {
        [self setProgressLabel:text];
        [self setProgressModeImage:[UIImage imageNamed:@"progress_done.png"]];
        [self hideProgressAfterDelay:delay];
    }
}

+ (void) setProgressDoneAndHideWithText:(NSString*)text
{
    [self setProgressDoneAndHideWithText:text andDelay:PROGRESS_DONE_HIDE_DELAY];
}

+ (void) setProgressDoneWithText:(NSString*)text
{
    if (_HUD != nil)
    {
        [self setProgressLabel:text];
        [self setProgressModeImage:[UIImage imageNamed:@"progress_done.png"]];
        sleep(PROGRESS_DONE_HIDE_DELAY);
    }
}

+ (void) setProgressErrorAndHideWithText:(NSString*)text andDelay:(NSTimeInterval)delay
{
    if (_HUD != nil)
    {
        [self setProgressLabel:text];
        [self setProgressModeImage:[UIImage imageNamed:@"progress_error.png"]];
        [self hideProgressAfterDelay:delay];
    }
}

+ (void) setProgressErrorAndHideWithText:(NSString*)text
{
    [self setProgressErrorAndHideWithText:text andDelay:PROGRESS_DONE_HIDE_DELAY];
}

+ (void) setProgressErrorWithText:(NSString*)text
{
    if (_HUD != nil)
    {
        [self setProgressLabel:text];
        [self setProgressModeImage:[UIImage imageNamed:@"progress_error.png"]];
        sleep(PROGRESS_DONE_HIDE_DELAY);
    }
}

+ (void) setProgressLabel:(NSString*)text
{
    if (_HUD != nil)
        _HUD.labelText = text;
}

+ (void) setProgressDetailsLabel:(NSString*)text
{
    if (_HUD != nil)
        _HUD.detailsLabelText = text;
}

+ (void) setProgressBackground:(BOOL)background
{
    if (_HUD != nil)
        _HUD.dimBackground = background;
}

+ (void) setProgressModeIndeterminate
{
    if (_HUD != nil)
        _HUD.mode = MBProgressHUDModeIndeterminate;
}

+ (void) setProgressModeDeterminate
{
    if (_HUD != nil)
        _HUD.mode = MBProgressHUDModeDeterminate;
}

+ (void) setProgressModeCustomView:(UIView*)view
{
    if (_HUD != nil)
        _HUD.customView = view;
        _HUD.mode = MBProgressHUDModeCustomView;
}

+ (void) setProgressModeImage:(UIImage*)image
{
    if (_HUD != nil)
    {
#if !OBJC_ARC_ENABLED
        _HUD.customView = [[[UIImageView alloc] initWithImage:image] autorelease];
#else
        _HUD.customView = [[UIImageView alloc] initWithImage:image];
#endif
        _HUD.mode = MBProgressHUDModeCustomView;
    }
}

+ (void) setProgressDeterminateValue:(float)val
{
    if (_HUD != nil)
        _HUD.progress = val;
}

+ (void) showWorkDoneInView:(UIView*)view withText:(NSString*)text andDelay:(NSTimeInterval)delay
{
    if (![self createProgress:view])
        return;
    
    _HUD.dimBackground = NO;
    [_HUD show:YES];
    [self setProgressDoneAndHideWithText:text andDelay:delay];
}

+ (void) showWorkDoneInView:(UIView*)view withText:(NSString*)text
{
    [self showWorkDoneInView:view withText:text andDelay:PROGRESS_DONE_HIDE_DELAY];
}

+ (void) showWorkErrorInView:(UIView*)view withText:(NSString*)text andDelay:(NSTimeInterval)delay
{
    if (![self createProgress:view])
        return;
    
    _HUD.dimBackground = NO;
    [_HUD show:YES];
    [self setProgressErrorAndHideWithText:text andDelay:delay];
}

+ (void) showWorkErrorInView:(UIView*)view withText:(NSString*)text andDetails:(NSString*)details andDelay:(NSTimeInterval)delay
{
    if (![self createProgress:view])
        return;
    
    _HUD.dimBackground = NO;
    [_HUD show:YES];
    _HUD.detailsLabelText = details;
    [self setProgressErrorAndHideWithText:text andDelay:delay];
}

+ (void) showWorkErrorInView:(UIView*)view withText:(NSString*)text
{
    [self showWorkErrorInView:view withText:text andDelay:PROGRESS_DONE_HIDE_DELAY];
}

#pragma mark - UIAlertView
+ (void) showAlertInfo:(NSString*)message title:(NSString*)title cancelButtonTitle:(NSString*)cancelText
{
#if !OBJC_ARC_ENABLED
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelText otherButtonTitles:nil] autorelease];
#else
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelText otherButtonTitles:nil];
#endif
    [alert show]; 
}

+ (void) showAlertInfo:(NSString*)message title:(NSString*)title
{
    [self showAlertInfo:message title:title cancelButtonTitle:ALERT_OK_TEXT];
}

#pragma mark - Language

static NSBundle *bundle = nil;

+(void)initAppLanguage
{
	NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
	NSArray* languages = [defs objectForKey:@"AppleLanguages"];
#if !OBJC_ARC_ENABLED
	NSString *current = [[languages objectAtIndex:0] retain];
#else
    NSString *current = [languages objectAtIndex:0];
#endif
	[self setAppLanguage:current];
}

/*
 example calls:
 [Language setLanguage:@"it"];
 [Language setLanguage:@"de"];
 */
+(void)setAppLanguage:(NSString *)l
{
#ifdef DEBUG_ECOMMON
	NSLog(@"preferredLang: %@", l);
#endif
	NSString *path = [[ NSBundle mainBundle ] pathForResource:l ofType:@"lproj" ];
#if !OBJC_ARC_ENABLED
	bundle = [[NSBundle bundleWithPath:path] retain];
#else
    bundle = [NSBundle bundleWithPath:path];
#endif
}

+(NSString *)getLocalizedKey:(NSString *)key alter:(NSString *)alternate
{
#ifdef DEBUG_ECOMMON
    NSLog(@"KEY: %@ VALOR: %@", key, alternate);
    NSLog(@"Translation:%@", [bundle localizedStringForKey:key value:alternate table:nil]);
#endif
	return [bundle localizedStringForKey:key value:alternate table:nil];
}

#pragma mark - General Functions

+ (BOOL)isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

+ (BOOL)isNumeric:(NSString*)inputString
{
    BOOL isValid = NO;
    NSCharacterSet *alphaNumbersSet = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *stringSet = [NSCharacterSet characterSetWithCharactersInString:inputString];
    isValid = [alphaNumbersSet isSupersetOfSet:stringSet];
    return isValid;
}

+ (NSString*)encodeBase64Bytes:(NSData*)rawBytes
{
    return [Base64 encode:rawBytes];
}

/*+ (NSString*)encodeBase64String:(NSString*)str
{
    return [Base64 encode:str];
}
 
+ (NSString*)decodeBase64String:(NSString*)str
{
    return [Base64 decode:str];
}*/

+ (NSData*)decodeBase64Bytes:(NSString*)str
{
    return [Base64 decode:str];
}

+ (NSString*) documentsPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	return [paths objectAtIndex:0];
    
    //return [NSString stringWithFormat:@"%@/Documents", NSHomeDirectory()];
    
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //return [paths objectAtIndex:0];
}

+ (NSString *) getStringDateAgo:(NSString *)since_date
{
	int since = [since_date intValue];
	int current = [[NSDate date] timeIntervalSince1970];
    
#ifdef DEBUG_ECOMMON
	NSLog(@"Since:%d | Current:%d", since, current);
#endif
    
	int segons_ago = current - since; //Es calcula la diferencia
    
	int minuts_ago = (segons_ago / 60);
	int hores_ago = (minuts_ago / 60);
	int dies_ago = (hores_ago / 24);
	int setmanes_ago = (dies_ago / 7);
	int mesos_ago = (setmanes_ago / 4);
	int anys_ago = (mesos_ago / 12);
    
	if(anys_ago == 1)			return [[NSString alloc] initWithFormat:NSLocalizedString(@"Hace %d año", @""), anys_ago];
	else if(anys_ago)			return [[NSString alloc] initWithFormat:NSLocalizedString(@"Hace %d años", @""), anys_ago];
	else if(mesos_ago == 1)		return [[NSString alloc] initWithFormat:NSLocalizedString(@"Hace %d mes", @""), mesos_ago];
	else if(mesos_ago)			return [[NSString alloc] initWithFormat:NSLocalizedString(@"Hace %d meses", @""), mesos_ago];
	else if(setmanes_ago == 1)	return [[NSString alloc] initWithFormat:NSLocalizedString(@"Hace %d semana", @""), setmanes_ago];
	else if(setmanes_ago)		return [[NSString alloc] initWithFormat:NSLocalizedString(@"Hace %d semanas", @""), setmanes_ago];
	else if(dies_ago == 1)		return [[NSString alloc] initWithFormat:NSLocalizedString(@"Hace %d día", @""), dies_ago];
	else if(dies_ago)			return [[NSString alloc] initWithFormat:NSLocalizedString(@"Hace %d días", @""), dies_ago];
	else if(hores_ago == 1)		return [[NSString alloc] initWithFormat:NSLocalizedString(@"Hace %d hora", @""), hores_ago];
	else if(hores_ago)			return [[NSString alloc] initWithFormat:NSLocalizedString(@"Hace %d horas", @""), hores_ago];
	else if(minuts_ago == 1)	return [[NSString alloc] initWithFormat:NSLocalizedString(@"Hace %d minuto", @""), minuts_ago];
	else if(minuts_ago)			return [[NSString alloc] initWithFormat:NSLocalizedString(@"Hace %d minutos", @""), minuts_ago];
	else						return NSLocalizedString(@"Hace un momento", @"");
}

+ (NSURL*) getResourcesBasePathForWebView
{
#if !OBJC_ARC_ENABLED
    NSString *resPath = [[[NSBundle mainBundle] resourcePath] autorelease];
    return [NSURL fileURLWithPath:[NSString stringWithFormat:@"file:/%@/",resPath] autorelease];
#else
    NSString *resPath = [[NSBundle mainBundle] resourcePath];
    return [NSURL fileURLWithPath:[NSString stringWithFormat:@"file:/%@/",resPath]];
#endif
}

+ (NSURLConnection*) createURLConnectionTo:(NSString*)host path:(NSString*)path delegate:(id)delegate
{
    return [self createURLConnectionTo:host path:path delegate:delegate timeout:CONNECTION_TIMEOUT];
}

+ (NSURLConnection*) createURLConnectionTo:(NSString*)host path:(NSString*)path delegate:(id)delegate timeout:(NSTimeInterval)timeout
{
    return [self createURLConnectionTo:host path:path delegate:delegate body:nil contentType:nil timeout:timeout];
}

+ (NSURLConnection*) createURLConnectionJSONTo:(NSString*)host path:(NSString*)path delegate:(id)delegate body:(NSData*)body
{
    return [self createURLConnectionTo:host path:path delegate:delegate body:body contentType:@"application/json" timeout:CONNECTION_TIMEOUT];
}

+ (NSURLConnection*) createURLConnectionTo:(NSString*)host path:(NSString*)path delegate:(id)delegate body:(NSData*)body contentType:(NSString*)contentType timeout:(NSTimeInterval)timeout
{
#if !OBJC_ARC_ENABLED
    NSString* url = [[NSString stringWithFormat:@"%@%@",host,path] autorelease];
#else
    NSString* url = [NSString stringWithFormat:@"%@%@",host,path];
#endif
    
#ifdef DEBUG_ECOMMON
	NSLog(@"url: %@", url);
#endif

#if !OBJC_ARC_ENABLED
    NSMutableURLRequest *theRequest=[[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                              cachePolicy:NSURLRequestReloadIgnoringCacheData 
                                          timeoutInterval:timeout] autorelease];
#else
    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                              cachePolicy:NSURLRequestReloadIgnoringCacheData 
                                          timeoutInterval:timeout];
#endif
    
    if (body != nil)
    {
#ifdef DEBUG_ECOMMON
        NSLog(@"body: %@", body);
#endif
        NSString* requestDataLengthString = [[NSString alloc] initWithFormat:@"%d", [body length]];

        theRequest.HTTPMethod = @"POST";
        theRequest.HTTPBody = body;
        [theRequest setValue:contentType
          forHTTPHeaderField:@"Content-Type"];
        [theRequest setValue:requestDataLengthString
          forHTTPHeaderField:@"Content-Length"];
        
#if !OBJC_ARC_ENABLED
        [requestDataLengthString release];
#endif
    }
    
#if !OBJC_ARC_ENABLED
    NSURLConnection *theConnection=[[[NSURLConnection alloc] initWithRequest:theRequest
                                                                    delegate:delegate] autorelease];
#else
    
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest
                                                                   delegate:delegate];
#endif
    
    return theConnection;
}

+ (NSString*) getURLFilename:(NSString*)str
{
    return [str lastPathComponent];
}

+ (void) logNSDictionary:(NSDictionary*)dict
{
    for (id key in dict)
    {
        NSLog(@"key: %@, value: %@", key, [dict objectForKey:key]);
    }
}

+ (NSString*) getAppVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString*) getAppVersionBuild
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (BOOL) isWideScreen
{
    return [UIScreen mainScreen].bounds.size.height > 500;
}

@end

#pragma mark - EProgressDelegate

@implementation EProgressDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud
{
#ifdef DEBUG_ECOMMON
    NSLog(@"EProgressDelegate >> Progress Was Hidden");
#endif
    [_HUD removeFromSuperview];
#if !OBJC_ARC_ENABLED
    [_HUD release];
    [_HUDDelegate release];
#endif
    _HUD = nil;
    _HUDDelegate = nil;
}

@end

@implementation UIColor (EndeproExtras)

+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha
{
    return [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:alpha];
}

@end

