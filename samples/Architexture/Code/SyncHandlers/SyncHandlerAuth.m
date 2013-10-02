//
//  SyncHandlerAuth.m
//  rankrunnertest
//
//  Created by Roser Fontseca Galceran on 07/05/12.
//  Copyright (c) 2012 Endepro Software. All rights reserved.
//

//----IMPORTS-->
#import "SyncHandlerAuth.h"
#import "EConsts.h"
#import "ECommon.h"
//<-------------

@implementation SyncHandlerAuth


- (void) fillRequestParams:(NSMutableDictionary*)data
{
    NSString *userToken = [ECommon getUserDefaultValueStringForKey:USER_DEFAULT_USER_TOKEN];
    NSLog(@"UserToken: %@",userToken);
    [data setValue:userToken forKey:JSON_USERID];
}

@end
