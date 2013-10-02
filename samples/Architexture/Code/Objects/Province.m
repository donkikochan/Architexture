//
//  Province.m
//  MutuaManresana
//
//  Created by DonKikochan on 21/01/13.
//  Copyright (c) 2013 Enric Vergara Carreras. All rights reserved.
//


//----IMPORTS-->
#import "Province.h"
#import "SyncHandlerProvinces.h"
//<-------------


@implementation ProvinceArray

@synthesize provinces = _provinces;

- (id) init:(id<SyncHandlerDelegate>)del
{
    self = [super init:del];
    if (self)
    {
        self.provinces = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) getCountries
{
    SyncHandlerProvinces *handler = [[SyncHandlerProvinces alloc] init:self];
    [handler start];
}

@end

@implementation Province

@synthesize identifier;
@synthesize name;

@end
