//
//  Service.m
//  MutuaManresana
//
//  Created by DonKikochan on 08/12/12.
//  Copyright (c) 2012 Enric Vergara Carreras. All rights reserved.
//

#import "Service.h"

@implementation Service

@synthesize m_sName     = _m_sName;
@synthesize m_sPhone    = _m_sPhone;
@synthesize m_fLon      = _m_fLon;
@synthesize m_fLat      = _m_fLat;

- (id)init
{
    self = [super init];
    if (self)
    {
        //...
    }
    return self;
}

@end

