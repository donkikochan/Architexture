//
//  ECommon.h
//
//  Created by Jordi Badia Santaulària on 24/02/12.
//  Copyright (c) 2012 Endepro Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDatabase.h"
#import "MBProgressHUD.h"

@interface ECommon : NSObject

+ (EDatabase*) createDatabaseSqlite3;
+ (EDatabase*) createDatabaseSqlite3AndOpen;

+ (NSString*) formatDate:(NSDate*)date withFormat:(NSString*)format;
+ (NSString*) formatDate:(NSDate*)date withStyle:(NSDateFormatterStyle)style;
+ (NSString*) formatDate:(NSDate*)date;
+ (NSString*) formatDateTime:(NSDate*)date withDateStyle:(NSDateFormatterStyle)dateStyle andTimeStyle:(NSDateFormatterStyle)timeStyle;
+ (NSString*) formatDateTime:(NSDate*)date;
+ (NSDate*) dateFromString:(NSString*)str withFormat:(NSString*)format;
+ (NSDate*) dateFromString:(NSString*)str withFormat:(NSString*)format andLocale:(NSString*)locale;

+ (void) showNetworkActivityIndicator;
+ (void) hideNetworkActivityIndicator;
+ (void) showStatusBar;
+ (void) hideStatusBar;

+ (void) setUserDefaultValue:(id)value forKey:(NSString*)key;
+ (void) setUserDefaultString:(NSString*)value forKey:(NSString*)key;
+ (void) setUserDefaultInt:(NSInteger)value forKey:(NSString*)key;
+ (void) setUserDefaultFloat:(float)value forKey:(NSString*)key;
+ (void) setUserDefaultDouble:(double)value forKey:(NSString*)key;
+ (void) setUserDefaultBool:(BOOL)value forKey:(NSString*)key;
+ (void) setUserDefaultDate:(NSDate*)value forKey:(NSString*)key;
+ (id) getUserDefaultValueForKey:(NSString*)key;
+ (NSString*) getUserDefaultValueStringForKey:(NSString*)key;
+ (NSInteger) getUserDefaultValueIntForKey:(NSString*)key;
+ (float) getUserDefaultValueFloatForKey:(NSString*)key;
+ (double) getUserDefaultValueDoubleForKey:(NSString*)key;
+ (BOOL) getUserDefaultValueBoolForKey:(NSString*)key;
+ (NSDate*) getUserDefaultValueDateForKey:(NSString*)key;
+ (BOOL) syncUserDefalts;

+ (MBProgressHUD*) HUD;
+ (BOOL) createProgress:(UIView*)view;
+ (BOOL) showProgressWhileExecuting:(SEL)selector onTarget:(id)target inView:(UIView*)view withText:(NSString*)text andObject:(NSObject*)obj;
+ (BOOL) showProgressWhileExecuting:(SEL)selector onTarget:(id)target inView:(UIView*)view withText:(NSString*)text;
+ (BOOL) showProgressWhileExecuting:(SEL)selector onTarget:(id)target inView:(UIView*)view;
+ (BOOL) showProgressInView:(UIView*)view withText:(NSString*)text;
+ (BOOL) showProgressInView:(UIView*)view;
+ (void) hideProgress;
+ (void) hideProgressAfterDelay:(NSTimeInterval)delay;
+ (void) setProgressDoneAndHideWithText:(NSString*)text andDelay:(NSTimeInterval)delay;
+ (void) setProgressDoneAndHideWithText:(NSString*)text;
+ (void) setProgressDoneWithText:(NSString*)text;
+ (void) setProgressErrorAndHideWithText:(NSString*)text andDelay:(NSTimeInterval)delay;
+ (void) setProgressErrorAndHideWithText:(NSString*)text;
+ (void) setProgressErrorWithText:(NSString*)text;
+ (void) setProgressLabel:(NSString*)text;
+ (void) setProgressDetailsLabel:(NSString*)text;
+ (void) setProgressBackground:(BOOL)background;
+ (void) setProgressModeIndeterminate;
+ (void) setProgressModeDeterminate;
+ (void) setProgressModeCustomView:(UIView*)view;
+ (void) setProgressModeImage:(UIImage*)image;
+ (void) setProgressDeterminateValue:(float)val;
+ (void) showWorkDoneInView:(UIView*)view withText:(NSString*)text andDelay:(NSTimeInterval)delay;
+ (void) showWorkDoneInView:(UIView*)view withText:(NSString*)text;
+ (void) showWorkErrorInView:(UIView*)view withText:(NSString*)text andDelay:(NSTimeInterval)delay;
+ (void) showWorkErrorInView:(UIView*)view withText:(NSString*)text andDetails:(NSString*)details andDelay:(NSTimeInterval)delay;
+ (void) showWorkErrorInView:(UIView*)view withText:(NSString*)text;

+ (void) showAlertInfo:(NSString*)message title:(NSString*)title cancelButtonTitle:(NSString*)cancelText;
+ (void) showAlertInfo:(NSString*)message title:(NSString*)title;

+ (void)initAppLanguage;
+ (void)setAppLanguage:(NSString *)l;
+ (NSString *)getLocalizedKey:(NSString *)key alter:(NSString *)alternate;

+ (BOOL)isValidEmail:(NSString *)checkString;
+ (BOOL)isNumeric:(NSString*)inputString;

+ (NSString*)encodeBase64Bytes:(NSData*)rawBytes;
/*+ (NSString*)encodeBase64String:(NSString*)str;
+ (NSString*)decodeBase64String:(NSString*)str;*/
+ (NSData*)decodeBase64Bytes:(NSString*)str;
+ (NSString*) documentsPath;
+ (NSString *) getStringDateAgo:(NSString *)since_date;
+ (NSURL*) getResourcesBasePathForWebView;

+ (NSURLConnection*) createURLConnectionTo:(NSString*)host path:(NSString*)path delegate:(id)delegate;
+ (NSURLConnection*) createURLConnectionTo:(NSString*)host path:(NSString*)path delegate:(id)delegate timeout:(NSTimeInterval)timeout;
+ (NSURLConnection*) createURLConnectionJSONTo:(NSString*)host path:(NSString*)path delegate:(id)delegate body:(NSData*)body;
+ (NSURLConnection*) createURLConnectionTo:(NSString*)host path:(NSString*)path delegate:(id)delegate body:(NSData*)body contentType:(NSString*)contentType timeout:(NSTimeInterval)timeout;

+ (NSString*) getURLFilename:(NSString*)str;

+ (void) logNSDictionary:(NSDictionary*)dict;

+ (NSString*) getAppVersion;
+ (NSString*) getAppVersionBuild;

+ (BOOL) isWideScreen;

@end

@interface EProgressDelegate : NSObject <MBProgressHUDDelegate>

- (void)hudWasHidden:(MBProgressHUD *)hud;

@end

@interface UIColor (EndeproExtras)

+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha;

@end
