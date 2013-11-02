//
//  Payment.h
//  Architexture
//
//  Created by Developer on 10/06/13.
//  Copyright (c) 2013 Endepro. All rights reserved.
//

//

//----IMPORTS-->
#import <Foundation/Foundation.h>
#import "BaseObjectDelegate.h"
//<-------------



//-------CLASS Payment:
@interface Payment : BaseObjectDelegate
{
}

//--Properties:
@property (nonatomic, strong) NSString  *couponAmmount;
@property (nonatomic, strong) NSString  *couponID_DB;

//---Functions:
- (void) checkCouponWithCode:(NSString*)_code;

- (void) sendPaymentInfoWithName:(NSString*)_name
                       withEmail:(NSString*)_email
                     withAddress:(NSString*)_address
                        withCity:(NSString*)_city
                         withZIP:(NSString*)_zip
                     withCountry:(NSString*)_country
                withSlowShipping:(NSString*)_slowShipping
                withTotalAmmount:(NSString*)_totalAmmount
                 withCollections:(NSArray*)_collections;

@end
