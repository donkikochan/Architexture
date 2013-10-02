//
//  BaseObjectDelegate.h
//  rankrunnertest
//
//  Created by Roser Fontseca Galceran on 09/05/12.
//  Copyright (c) 2012 Endepro Software. All rights reserved.
//

#import "BaseObject.h"
#import "SyncHandler.h"


@interface BaseObjectDelegate : BaseObject <SyncHandlerDelegate>

@property (nonatomic, strong) id<SyncHandlerDelegate> delegate;


- (id) init:(id<SyncHandlerDelegate>)del;


@end
