//
//  SyncHandlerLogin.h
//  ArchiteXture
//
//  Created by Developer on 10/06/13.
//  Copyright (c) 2013 Enric Vergara. All rights reserved.
//

#import "SyncHandler.h"

@interface SyncHandlerSendPaymentInfo : SyncHandler
{}


/*
 //Mètode per obtenir la llista de recomanacions
 HTTP Methods: POST
 Tipus: JSON
 Mètode : sendPaymentInfo
 post : {   "Namme":"kk","Email":"kk@uab.cat", "Address":"C/Doctor carles tena 3",
            "City":"Santpedor", "ZIP":"08251", "Country":"Spain",
            "SlowShippin":"1/0", "TotalAmmount":"25.4", 
            "Rings":    [   {"RingID":"Icone", "Ammount":"2"},
                            {"RingID":"Mountain", "Ammount":"1"}
                        ]
        }
 retorn : { "success": 1, "msg": "", "data":{}}
 */


@property (nonatomic, strong) NSString* Name;
@property (nonatomic, strong) NSString* Email;
@property (nonatomic, strong) NSString* Address;
@property (nonatomic, strong) NSString* City;
@property (nonatomic, strong) NSString* ZIP;
@property (nonatomic, strong) NSString* Country;
@property (nonatomic, strong) NSString* SlowShipping;
@property (nonatomic, strong) NSString* TotalAmmount;
@property (nonatomic, strong) NSString* Phone;
@property (nonatomic, strong) NSString* OrderNotes;
@property (nonatomic, strong) NSArray*  Collections;

@end
