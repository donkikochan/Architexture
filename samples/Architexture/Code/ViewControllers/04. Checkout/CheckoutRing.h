//
//  CheckoutRing.h
//  ArchiteXture
//
//  Created by DonKikochan on 27/07/13.
//
//

#import <Foundation/Foundation.h>

@interface CheckoutRing : NSObject
{
    NSString*   m_sMiniPhoto;
    NSString*   m_sRingName;
    NSString*   m_sCollectionName;
    int         m_iAmmount;
}

- (id) initWithPhotoName:(NSString*)_photoName andRingName:(NSString*) _name andCollectionName:(NSString*)_collectionName;

- (void)        setMiniPhotoName:(NSString*)_photoName andRingName:(NSString*) _name andCollectionName:(NSString*)_collectionName;
- (void)        addAmmount:(int)ammount;
- (int)         getAmmount;
- (void)        reset;
- (NSString*)   getStringPhotoName;
- (UIImage*)    getImg;
- (NSString*)   getCollectionName;
- (NSString*)   getRingName;

@end
