/*==============================================================================
 Copyright (c) 2012 QUALCOMM Austria Research Center GmbH.
 All Rights Reserved.
 Qualcomm Confidential and Proprietary
 ==============================================================================*/


//---Imports:---
#import <UIKit/UIKit.h>
#import "MainNavController.h"
#import "Menu_VC.h"
#import "CheckoutInfo.h"
//--------------


//----News Define:------------------
#define RING_PRIZE              25.0f
#define NUM_BLURRED_IMG         20

#define _01_HAPPINESS           @"HAPPI"
#define _02_REFLEX              @"REFLEX"
#define _03_SKY                 @"SKY"
#define _04_CLOTHING            @"CLOTHING"
#define _05_FANCY               @"FANCY"
#define _06_EARTH               @"EARTH"
#define _07_RHYTHM              @"RHYTHM"
#define _08_TRANSPARENCY        @"TRANSPARENCY"
#define _09_GOLD                @"GOLD"
#define _10_COLOURS             @"COLOURS"
#define _11_LIGHT               @"LIGHT"
#define _12_MOUNTAIN            @"MOUNTAIN"
#define _13_FLOWER              @"FLOWER"
#define _14_PLACE               @"PLACE"
#define _15_CALME               @"CALME"
#define _16_ANGLE               @"ANGLE"
#define _17_ICONE               @"ICONE"
#define _18_RGG                 @"RGB"

#define COLLECTION_BARCELONA    @"BARCELONA"
#define COLLECTION_MATERIALS    @"MATERILAS"
#define COLLECTION_PARIS        @"PARIS"
#define SP_COLLECTION_DALI      @"DALI"
#define SP_COLLECTION_BORN      @"BORN"
//------------------------------------


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSDictionary *imgsDictionary;
}

@property (strong, nonatomic) UINavigationController*   mainNavigationViewController;
@property (strong, nonatomic) Menu_VC*                  menuViewController;
@property (strong, nonatomic) UIWindow*                 window;
@property (strong, nonatomic) CheckoutInfo*             m_CheckOutInfo;
@property (strong, nonatomic) NSString*                 m_sCollectionToLoad;
@property (strong, nonatomic) NSString*                 m_sRingToLoad;
@property (strong, nonatomic) NSString*                 m_sGoToNewCollection;

+ (AppDelegate*) mainAppDelegate;

//----Functions [iOS Slide-out Navigation]:
- (void) setNavigationViewController:(UINavigationController *)navigationViewController;
- (void) showSideMenu;
- (void) hideSideMenu;

@end