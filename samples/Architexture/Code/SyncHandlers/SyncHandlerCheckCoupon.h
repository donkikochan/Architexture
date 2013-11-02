//
//  SyncHandlerLogin.h
//  Hashbe
//
//  Created by Developer on 10/06/13.
//  Copyright (c) 2013 Endepro. All rights reserved.
//

#import "SyncHandler.h"


@interface SyncHandlerCheckCoupon : SyncHandler
{}

/*
 //Mètode per obtenir la llista de recomanacions
 HTTP Methods: POST
 Tipus: JSON
 Mètode : checkCoupon
 post : {"couponID":"blablabla"}
 retorn : { "success": 1, "msg": "", "data": {"couponStatus": "1","expireDate": "10/12/2004"}}
 
 couponStatus: "0" no valid, "1" data expirada, "2" valid
*/


@property (nonatomic, strong) NSString *couponID;


@end
