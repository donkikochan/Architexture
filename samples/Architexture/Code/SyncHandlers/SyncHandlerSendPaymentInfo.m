//
//  SyncHandlerLogin.m
//  Hashbe
//
//  Created by Developer on 10/06/13.
//  Copyright (c) 2013 Endepro. All rights reserved.
//

//----IMPORTS-->
#import "SyncHandlerSendPaymentInfo.h"
#import "EConsts.h"
#import "ECommon.h"
#import "Payment.h"
#import "CheckoutRing.h"
//<-------------


@implementation SyncHandlerSendPaymentInfo

@synthesize Name            = _Name;
@synthesize Email           = _Email;
@synthesize Address         = _Address;
@synthesize City            = _City;
@synthesize ZIP             = _ZIP;
@synthesize Country         = _Country;
@synthesize SlowShipping    = _SlowShipping;
@synthesize TotalAmmount    = _TotalAmmount;
@synthesize Collections     = _Collections;
@synthesize Phone           = _Phone;
@synthesize OrderNotes      = _OrderNotes;
@synthesize CouponID      = _CouponID;

- (int) getType
{
    return SYNC_HANDLER_TYPE_NONE;
}

- (NSString*) getMethod
{
    return @"/services.php?sendPaymentInfo";
}

- (void) fillRequestParams:(NSMutableDictionary*)data
{
    [super fillRequestParams:data];

    
    [data setValue:_Name            forKey: @"Name"];
    [data setValue:_Email           forKey: @"Email"];
    [data setValue:_Address         forKey: @"Address"];
    [data setValue:_City            forKey: @"City"];
    [data setValue:_ZIP             forKey: @"ZIP"];
    [data setValue:_Country         forKey: @"Country"];
    [data setValue:_SlowShipping    forKey: @"SlowShipping"];
    [data setValue:_TotalAmmount    forKey: @"TotalAmmount"];
    [data setValue:_Phone           forKey: @"Phone"];
    [data setValue:_OrderNotes      forKey: @"OrderNotes"];
    [data setValue:_CouponID        forKey: @"CouponID"];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    for (NSArray* collection in _Collections)
    {
        for (CheckoutRing* ring in collection)
        {
            int ammount = [ring getAmmount];
            if (ammount > 0)
            {
                NSString* ammountRing = [NSString stringWithFormat:@"%d", ammount];
                NSString* ringName = [ring getRingName];
                NSMutableDictionary *data2 = [[NSMutableDictionary alloc] init];
                [data2 setValue:ringName    forKey: @"RingID"];
                [data2 setValue:ammountRing forKey: @"Ammount"];
                [arr addObject:data2];
            }
        }
    }

    [data setValue:arr  forKey: @"Rings"];
}



/*
 //Mètode per obtenir la llista de recomanacions
 HTTP Methods: POST
 Tipus: JSON
 Mètode : sendPaymentInfo
 post : {   "Namme":"kk","Email":"kk@uab.cat", "Address":"C/Doctor carles tena 3",
            "City":"Santpedor", "ZIP":"08251", "Country":"Spain",
            "SlowShippin":"1/0", "TotalAmmount":"25.4",
            "Rings":    [   
                            {"RingID":"Icone", "Ammount":"2"},
                            {"RingID":"Mountain", "Ammount":"1"}
                        ]
        }
 retorn : { "success": 1, "msg": "", "data":{}}
 */



- (BOOL) processJSON:(id)data;
{
    BOOL ok = YES;
    Payment *payment = (Payment*)self.delegate;
    [self syncDone:YES object:payment];
    return ok;
}

@end
