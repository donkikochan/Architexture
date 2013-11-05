//
//  CheckoutInfo.m
//  ArchiteXture
//
//  Created by DonKikochan on 27/07/13.
//
//

//---Imports:--
#import "CheckoutInfo.h"
#import "CheckoutRing.h"
//-------------

@implementation CheckoutInfo

- (id) init
{
    self = [super init];
    if (self)
    {
        // Initialization code
       
        m_aCollections          = [[NSMutableArray alloc] init];
        m_aCollectionsToShop    = [[NSMutableArray alloc] init];
        m_aCollectionsToMenu    = [[NSMutableArray alloc] init];
        
        CheckoutRing* ring;
        
        //--- BARCELONA COLLECTION
        NSMutableArray* l_ArrayBarcelonaCollection = [NSMutableArray arrayWithCapacity:6];
        ring= [[CheckoutRing alloc] initWithPhotoName:@"MINI-HAPPINESS.png"     andRingName:@"HAPPINESS"    andCollectionName:NSLocalizedString(@"BARCELONA_COLLECTION",nil)];
        [l_ArrayBarcelonaCollection addObject:ring];
        ring= [[CheckoutRing alloc] initWithPhotoName:@"MINI-REFLEX.png"        andRingName:@"REFLEX"       andCollectionName:NSLocalizedString(@"BARCELONA_COLLECTION",nil)];
        [l_ArrayBarcelonaCollection addObject:ring];
        ring= [[CheckoutRing alloc] initWithPhotoName:@"MINI-SKY.png"           andRingName:@"SKY"          andCollectionName:NSLocalizedString(@"BARCELONA_COLLECTION",nil)];
        [l_ArrayBarcelonaCollection addObject:ring];
        ring= [[CheckoutRing alloc] initWithPhotoName:@"MINI-CLOTHING.png"      andRingName:@"CLOTHING"     andCollectionName:NSLocalizedString(@"BARCELONA_COLLECTION",nil)];
        [l_ArrayBarcelonaCollection addObject:ring];
        ring= [[CheckoutRing alloc] initWithPhotoName:@"MINI-FANCY.png"         andRingName:@"FANCY"        andCollectionName:NSLocalizedString(@"BARCELONA_COLLECTION",nil)];
        [l_ArrayBarcelonaCollection addObject:ring];
        ring= [[CheckoutRing alloc] initWithPhotoName:@"MINI-EARTH.png"         andRingName:@"EARTH"        andCollectionName:NSLocalizedString(@"BARCELONA_COLLECTION",nil)];
        [l_ArrayBarcelonaCollection addObject:ring];
        
        [m_aCollections         addObject:l_ArrayBarcelonaCollection];
        [m_aCollectionsToShop   addObject:l_ArrayBarcelonaCollection];
        [m_aCollectionsToMenu   addObject:l_ArrayBarcelonaCollection];
        
        //--- MATERIALS COLLECTION
        NSMutableArray* l_ArrayMaterialsCollection = [NSMutableArray arrayWithCapacity:6];
        ring= [[CheckoutRing alloc] initWithPhotoName:@"MINI-RHYTHM.png"        andRingName:@"RHYTHM"       andCollectionName:NSLocalizedString(@"MATERIALS_COLLECTION",nil)];
        [l_ArrayMaterialsCollection addObject:ring];
        ring= [[CheckoutRing alloc] initWithPhotoName:@"MINI-TRANSPARENCY.png"  andRingName:@"TRANSPARENCY" andCollectionName:NSLocalizedString(@"MATERIALS_COLLECTION",nil)];
        [l_ArrayMaterialsCollection addObject:ring];
        ring= [[CheckoutRing alloc] initWithPhotoName:@"MINI-GOLD.png"          andRingName:@"GOLD"         andCollectionName:NSLocalizedString(@"MATERIALS_COLLECTION",nil)];
        [l_ArrayMaterialsCollection addObject:ring];
        ring= [[CheckoutRing alloc] initWithPhotoName:@"MINI-COLOURS.png"       andRingName:@"COLOURS"      andCollectionName:NSLocalizedString(@"MATERIALS_COLLECTION",nil)];
        [l_ArrayMaterialsCollection addObject:ring];
        ring= [[CheckoutRing alloc] initWithPhotoName:@"MINI-LIGHT.png"         andRingName:@"LIGHT"        andCollectionName:NSLocalizedString(@"MATERIALS_COLLECTION",nil)];
        [l_ArrayMaterialsCollection addObject:ring];
        ring= [[CheckoutRing alloc] initWithPhotoName:@"MINI-MOUNTAIN.png"      andRingName:@"MOUNTAIN"     andCollectionName:NSLocalizedString(@"MATERIALS_COLLECTION",nil)];
        [l_ArrayMaterialsCollection addObject:ring];
        
        [m_aCollections         addObject:l_ArrayMaterialsCollection];
        [m_aCollectionsToShop   addObject:l_ArrayMaterialsCollection];
        [m_aCollectionsToMenu   addObject:l_ArrayMaterialsCollection];
        
        //--- PARIS COLLECTION
        NSMutableArray* l_ArrayParisCollection = [NSMutableArray arrayWithCapacity:4];
        ring= [[CheckoutRing alloc] initWithPhotoName:@"MINI-FLOWER.png"        andRingName:@"FLOWER"       andCollectionName:NSLocalizedString(@"PARIS_COLLECTION",nil)];
        [l_ArrayParisCollection addObject:ring];
        ring= [[CheckoutRing alloc] initWithPhotoName:@"MINI-PLACE.png"         andRingName:@"PLACE"        andCollectionName:NSLocalizedString(@"PARIS_COLLECTION",nil)];
        [l_ArrayParisCollection addObject:ring];
        ring= [[CheckoutRing alloc] initWithPhotoName:@"MINI-CALME.png"         andRingName:@"CALME"        andCollectionName:NSLocalizedString(@"PARIS_COLLECTION",nil)];
        [l_ArrayParisCollection addObject:ring];
        ring= [[CheckoutRing alloc] initWithPhotoName:@"MINI-ANGLE.png"          andRingName:@"ANGLE"        andCollectionName:NSLocalizedString(@"PARIS_COLLECTION",nil)];
        [l_ArrayParisCollection addObject:ring];
        ring= [[CheckoutRing alloc] initWithPhotoName:@"MINI-ICONE.png"         andRingName:@"ICONE"        andCollectionName:NSLocalizedString(@"PARIS_COLLECTION",nil)];
        [l_ArrayParisCollection addObject:ring];
        ring= [[CheckoutRing alloc] initWithPhotoName:@"MINI-RGB.png"           andRingName:@"RGB"          andCollectionName:NSLocalizedString(@"PARIS_COLLECTION",nil)];
        [l_ArrayParisCollection addObject:ring];
        
        [m_aCollections         addObject:l_ArrayParisCollection];
        [m_aCollectionsToShop   addObject:l_ArrayParisCollection];
        [m_aCollectionsToMenu   addObject:l_ArrayParisCollection];
        
        //--- SPECIAL COLLECTIONS
        NSMutableArray* l_SpecialCollection = [NSMutableArray arrayWithCapacity:4];
        ring= [[CheckoutRing alloc] initWithPhotoName:@"MINI-DALI.png"          andRingName:@"DALÍ Collection"  andCollectionName:NSLocalizedString(@"SPECIAL_COLLECTIONS",nil)];
        [l_SpecialCollection addObject:ring];
        ring= [[CheckoutRing alloc] initWithPhotoName:@"MINI-BORN.png"          andRingName:@"BORN Collection"  andCollectionName:NSLocalizedString(@"SPECIAL_COLLECTIONS",nil)];
        [l_SpecialCollection addObject:ring];
        
        [m_aCollections         addObject:l_SpecialCollection];
        [m_aCollectionsToMenu   addObject:l_SpecialCollection];
        
        
        //--- BORN COLLECTIONS
        NSMutableArray* l_ArrayBornCollection = [NSMutableArray arrayWithCapacity:4];
        ring= [[CheckoutRing alloc] initWithPhotoName:@"MINI-TEULA.png"         andRingName:@"TEULA"        andCollectionName:NSLocalizedString(@"BORN_COLLECTION",nil)];
        [l_ArrayBornCollection addObject:ring];
        ring= [[CheckoutRing alloc] initWithPhotoName:@"MINI-ANTIC.png"         andRingName:@"ANTIC"        andCollectionName:NSLocalizedString(@"BORN_COLLECTION",nil)];
        [l_ArrayBornCollection addObject:ring];
        ring= [[CheckoutRing alloc] initWithPhotoName:@"MINI-MUR.png"           andRingName:@"MUR"          andCollectionName:NSLocalizedString(@"BORN_COLLECTION",nil)];
        [l_ArrayBornCollection addObject:ring];
        ring= [[CheckoutRing alloc] initWithPhotoName:@"MINI-BORN AN.png"       andRingName:@"BORN"         andCollectionName:NSLocalizedString(@"BORN_COLLECTION",nil)];
        [l_ArrayBornCollection addObject:ring];
        
        
        [m_aCollections         addObject:l_ArrayBornCollection];
        [m_aCollectionsToShop   addObject:l_ArrayBornCollection];
        
        
        m_sName     =
        m_sAddress  =
        m_sCity     =
        m_sZIP      =
        m_sProvince =
        m_sEmail    =
        m_sCountry  = @"";
    }
    
    return self;
}

- (NSMutableArray*) getCollections
{
    return m_aCollections;
}

- (NSMutableArray*) getCollectionsToMenu
{
    return m_aCollectionsToMenu;
}

- (NSMutableArray*) getCollectionsToShop
{
    return m_aCollectionsToShop;
}

- (NSString*) getName
{
    return m_sName;
}

- (NSString*) getAddress
{
    return m_sAddress;
}
- (NSString*) getCity
{
    return m_sCity;
}
- (NSString*) getZIP
{
    return m_sZIP;
}
- (NSString*) getProvince
{
    return m_sProvince;
}
- (NSString*) getEmail
{
    return m_sEmail;
}
- (NSString*) getCountry
{
    return m_sCountry;
}

- (void) setName:(NSString*) name
{
    m_sName = name;
}

- (void) setAddress:(NSString*) address
{
    m_sAddress = address;
}

- (void) setCity:(NSString*) city
{
    m_sCity = city;
}

- (void) setZIP:(NSString*) zip
{
    m_sZIP = zip;
}

- (void) setProvince:(NSString*) province
{
    m_sProvince = province;
}

- (void) setEmail:(NSString*) email
{
    m_sEmail = email;
}

- (void) setCountry:(NSString*) country
{
    m_sCountry = country;
}

- (void) addAmmount:(int) ammount ToRing:(NSString*)_id
{
    for (NSArray* collection in m_aCollections)
    {
        for (CheckoutRing* ring in collection)
        {
            if ([[ring getRingName] isEqualToString:_id])
            {
                [ring addAmmount:ammount];
            }
        }
    }
}

- (void) jumpToRing:(NSString*)_id
{
    m_sRingToJump = _id;
}
- (NSString*) getRingToJump
{
    NSString* ring = m_sRingToJump;
    m_sRingToJump = @"";
    return ring;
}

- (int) getNumBuyedRings
{
    int numBuyedRings = 0;
    for (NSArray* collection in m_aCollections)
    {
        for (CheckoutRing* ring in collection)
        {
            numBuyedRings += [ring getAmmount];
        }
    }
    return numBuyedRings;
}

- (void) resetRings
{
    for (NSArray* collection in m_aCollections)
    {
        for (CheckoutRing* ring in collection)
        {
            [ring reset];
        }
    }
}
@end
