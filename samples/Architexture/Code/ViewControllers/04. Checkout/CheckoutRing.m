//
//  CheckoutRing.m
//  ArchiteXture
//
//  Created by DonKikochan on 27/07/13.
//
//

#import "CheckoutRing.h"

@implementation CheckoutRing


- (id) initWithPhotoName:(NSString*)_photoName andRingName:(NSString*) _name andCollectionName:(NSString*)_collectionName;
{
    self = [super init];
    if (self)
    {
        // Initialization code
        m_sMiniPhoto = _photoName;
        m_sRingName = _name;
        m_sCollectionName = _collectionName;
        m_iAmmount = 0;
    }
    return self;
}

- (void) setMiniPhotoName:(NSString*)_photoName andRingName:(NSString*) _name andCollectionName:(NSString*)_collectionName;
{
    m_sMiniPhoto = _photoName;
    m_sRingName = _name;
    m_sCollectionName = _collectionName;
}

- (void) addAmmount:(int)ammount
{
    m_iAmmount += ammount;
    if (m_iAmmount < 0)
    {
        m_iAmmount = 0;
    }
}

- (int) getAmmount
{
    return m_iAmmount;
}

- (void) reset
{
    m_iAmmount = 0;
}

- (NSString*) getStringPhotoName
{
    return m_sMiniPhoto;
}
- (NSString*) getRingName
{
    return m_sRingName;
}
- (NSString*) getCollectionName
{
    return m_sCollectionName;
}

- (UIImage*) getImg
{
    return [UIImage imageNamed:m_sMiniPhoto];
}

@end
