//
//  UIImage+EUIImage.h
//  rankrunner
//
//  Created by Jordi Badia Santaulària on 18/05/12.
//  Copyright (c) 2012 Endepro Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (EUIImage)

- (UIImage *)imageAtRect:(CGRect)rect;
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

@end
