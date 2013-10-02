//
//  BaseObjectDelegate.m
//  rankrunnertest
//
//  Created by Roser Fontseca Galceran on 09/05/12.
//  Copyright (c) 2012 Endepro Software. All rights reserved.
//

#import "BaseObjectDelegate.h"

@implementation BaseObjectDelegate

@synthesize delegate;


- (id) init:(id<SyncHandlerDelegate>)del
{
    self = [super init];
    
    if (self)
    {
        self.delegate = del;
    }
    
    return self;
}

- (void) syncDone:(BOOL)success object:(BaseObject*)obj
{
    if (delegate != nil)
    {
        if (obj!=nil)
            obj.success = success;

        [delegate syncDone:success object:obj];
    }
}

@end
