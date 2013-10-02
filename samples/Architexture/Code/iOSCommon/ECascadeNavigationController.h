//
//  ECascadeNavigationController.h
//
//  Created by Jordi Badia Santaulària on 16.03.2012.
//  Copyright (c) 2012 Endepro Software. All rights reserved.
//
//  Based on ExampleNavigationController by Emil Wojtaszek on 13.09.2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Cascade/Cascade.h>

@interface ECascadeNavigationController : CLCascadeNavigationController {
    UIImageView* _staticDetachImage;
    UIImageView* _dynamicDetachImage;
}

- (void) removeAllPages:(BOOL)animated;

@end
