//
//  BaseObject.h
//  eTablet
//
//  Created by Jordi Badia Santaulària on 03/04/12.
//  Copyright (c) 2012 Endepro Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseObject : NSObject


@property (nonatomic, readwrite) Boolean success;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic) long offset;
@property (nonatomic) long limit;

- (id) init:(Boolean)success message:(NSString*)msg;

@end
