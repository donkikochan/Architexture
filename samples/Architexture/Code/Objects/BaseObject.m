//
//  BaseObject.m
//  eTablet
//
//  Created by Jordi Badia Santaulària on 03/04/12.
//  Copyright (c) 2012 Endepro Software. All rights reserved.
//

#import "BaseObject.h"

@implementation BaseObject

@synthesize success = _success;
@synthesize msg = _msg;
@synthesize offset = _offset;
@synthesize limit = _limit;

- (id) init
{
    self = [super init];
    if (self)
    {
        _success = YES;
        _msg = nil;
        _offset = 0;
        _limit = SYNC_LIMIT_DEFAULT;
    }
    return self;
}

- (id) init:(Boolean)success message:(NSString*)msg 
{
    self = [super init];
    if (self)
    {
        _success=success;
        _msg = msg;
        _offset = 0;
        _limit = SYNC_LIMIT_DEFAULT;
    }    
    return self;
}


@end
