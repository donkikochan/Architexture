//
//  CheckoutInfo.h
//  ArchiteXture
//
//  Created by DonKikochan on 27/07/13.
//
//

#import <Foundation/Foundation.h>

@interface CheckoutInfo : NSObject
{
    NSMutableArray* m_aCollections;
    NSString*       m_sName;
    NSString*       m_sAddress;
    NSString*       m_sCity;
    NSString*       m_sZIP;
    NSString*       m_sProvince;
    NSString*       m_sEmail;
    NSString*       m_sCountry;
}

- (NSMutableArray*) getCollections;
- (NSString*)       getName;
- (NSString*)       getAddress;
- (NSString*)       getCity;
- (NSString*)       getZIP;
- (NSString*)       getProvince;
- (NSString*)       getEmail;
- (NSString*)       getCountry;

- (void)            setName:(NSString*) name;
- (void)            setAddress:(NSString*) adress;
- (void)            setCity:(NSString*) city;
- (void)            setZIP:(NSString*) zip;
- (void)            setProvince:(NSString*) province;
- (void)            setEmail:(NSString*) email;
- (void)            setCountry:(NSString*) country;

- (void)            addAmmount:(int) ammount ToRing:(NSString*)_id;
- (int)             getNumBuyedRings;
- (void)            resetRings;
@end
