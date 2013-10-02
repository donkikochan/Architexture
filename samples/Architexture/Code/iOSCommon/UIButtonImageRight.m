//
//  UIButtonImageRight.m
//  rankrunner
//
//  Created by Jordi Badia Santaulària on 16/05/12.
//  Copyright (c) 2012 Endepro Software. All rights reserved.
//

#import "UIButtonImageRight.h"

@implementation UIButtonImageRight

- (void)layoutSubviews
{
    // Allow default layout, then adjust image and label positions
    [super layoutSubviews];
    
    UIImageView *imageView = [self imageView];
    UILabel *label = [self titleLabel];
    
    CGRect imageFrame = imageView.frame;
    CGRect labelFrame = label.frame;
    
    labelFrame.origin.x = imageFrame.origin.x;
    imageFrame.origin.x = labelFrame.origin.x + CGRectGetWidth(labelFrame) + 2;
    imageFrame.origin.y += 1;
    
    imageView.frame = imageFrame;
    label.frame = labelFrame;
}

@end
