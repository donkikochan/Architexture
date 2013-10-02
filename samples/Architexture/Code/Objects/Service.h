//
//  Service.h
//  MutuaManresana
//
//  Created by DonKikochan on 08/12/12.
//  Copyright (c) 2012 Enric Vergara Carreras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Service : NSObject
{
    
}

@property (nonatomic, strong) NSString  *m_sName;
@property (nonatomic, strong) NSString  *m_sPhone;
@property (nonatomic) float             m_fLon;
@property (nonatomic) float             m_fLat;

@end
