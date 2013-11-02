//
//  Payment.m
//  ArchiteXture
//
//  Created by Developer on 10/06/13.
//  Copyright (c) 2013 Enric Vergara. All rights reserved.
//

//----IMPORTS-->
#import "Payment.h"
#import "SyncHandlerCheckCoupon.h"
#import "SyncHandlerSendPaymentInfo.h"
//----------------


//-------CLASS Payment:
@implementation Payment

@synthesize couponAmmount   = _couponAmmount;
@synthesize couponID_DB     = _couponID_DB;

- (id) init:(id<SyncHandlerDelegate>)del
{
    self = [super init:del];
    if (self)
    {
        //nothin to do.
    }
    return self;
}



- (void) checkCouponWithCode:(NSString*)_code
{
    SyncHandlerCheckCoupon *handler = [[SyncHandlerCheckCoupon alloc] init:self];
    handler.couponID    = _code;

    [handler start];
}


- (void) sendPaymentInfoWithName:(NSString*)_name
                       withEmail:(NSString*)_email
                     withAddress:(NSString*)_address
                        withCity:(NSString*)_city
                         withZIP:(NSString*)_zip
                     withCountry:(NSString*)_country
                withSlowShipping:(NSString*)_slowShipping
                withTotalAmmount:(NSString*)_totalAmmount
                       withCollections:(NSArray*)_collections;
{
    SyncHandlerSendPaymentInfo *handler = [[SyncHandlerSendPaymentInfo alloc] init:self];
    
    handler.Name            = _name;
    handler.Email           = _email;
    handler.Address         = _address;
    handler.City            = _city;
    handler.ZIP             = _zip;
    handler.Country         = _country;
    handler.SlowShipping    = _slowShipping;
    handler.TotalAmmount    = _totalAmmount;
    handler.Collections     = _collections;
    
    [handler start];
}



@end
