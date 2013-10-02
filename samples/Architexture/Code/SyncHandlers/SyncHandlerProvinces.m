//
//  SyncHandlerProvinces.m
//  MutuaManresana
//
//  Created by DonKikochan on 21/01/13.
//  Copyright (c) 2013 Enric Vergara Carreras. All rights reserved.
//

//----IMPORTS-->
#import "SyncHandlerProvinces.h"
#import "EConsts.h"
#import "Province.h"
//<-------------


@implementation SyncHandlerProvinces


- (NSString*) getMethod
{
    return SERVER_METHOD_GET_PROVINCES;
}

- (BOOL) processJSON:(id)data;
{
    BOOL ok = YES;
    
    ProvinceArray *provinceArray = (ProvinceArray*)self.delegate;
    [provinceArray.provinces removeAllObjects];
    
    NSArray *arr = (NSArray*)data;
    
    NSDictionary *objData;
    for (int i=0; i<arr.count && ok && !self.cancelled; i++)
    {
        objData = [arr objectAtIndex:i];
        
        Province *province = [[Province alloc] init];
        
        province.identifier  = [objData objectForKey:JSON_PROVINCE_ID];
        province.name        = [objData objectForKey:JSON_PROVINCE];
        
        [provinceArray.provinces addObject:province];
    }
    
    [self syncDone:YES object:provinceArray];
    
    return ok;
}

@end
