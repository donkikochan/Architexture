//
//  SyncHandlerLogin.m
//  Hashbe
//
//  Created by Developer on 10/06/13.
//  Copyright (c) 2013 Endepro. All rights reserved.
//

//----IMPORTS-->
#import "SyncHandlerCheckCoupon.h"
#import "EConsts.h"
#import "ECommon.h"
#import "Payment.h"
//<-------------


@implementation SyncHandlerCheckCoupon

@synthesize couponID    = _couponID;

- (int) getType
{
    return SYNC_HANDLER_TYPE_NONE;
}

- (NSString*) getMethod
{
    return @"/services.php?checkCoupon";
}

- (void) fillRequestParams:(NSMutableDictionary*)data
{
    [super fillRequestParams:data];
    
    [data setValue:_couponID  forKey:@"CouponID"];  //CouponID
}


/*
 //Mètode per obtenir la llista de recomanacions
 HTTP Methods: POST
 Tipus: JSON
 Mètode : checkCoupon
 post : {"couponID":"blablabla"}
 retorn : { "success": 1, "msg": "", "data": {"couponAmmount: 10.f", "couponStatus": "1","expireDate": "2013-10-15"}}
 
 couponStatus: "0" no valid, "1" data expirada, "2" valid
 */

- (BOOL) processJSON:(id)data;
{
    BOOL ok = YES;
    
    Payment *payment = (Payment*)self.delegate;
    NSArray*arr = (NSArray*)data;
    NSDictionary *objData = [arr objectAtIndex:0];
    
    payment.couponAmmount   = [self stringFromJSON:[objData objectForKey:@"Ammount"]];
    payment.couponID_DB     = [self stringFromJSON:[objData objectForKey:@"ID"]];
    
    //hashtag.FinishDate = [ECommon dateFromString:[objData objectForKey:JSON_FINISH_DATE] withFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    [self syncDone:YES object:payment];
    
    return ok;
}

@end
