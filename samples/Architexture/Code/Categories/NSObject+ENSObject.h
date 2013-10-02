//
//  NSObject+ENSObject.h
//  rankrunner
//
//  Created by Jordi Badia Santaulària on 11/05/12.
//  Copyright (c) 2012 Endepro Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ENSObject)

@property (nonatomic, weak) AppDelegate *mainAppDelegate;
@property (nonatomic, weak) UIStoryboard *storyboard;

@end
