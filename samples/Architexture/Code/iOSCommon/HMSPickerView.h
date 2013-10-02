//
//  HMSPickerView.h
//  rankrunner
//
//  Created by Jordi Badia Santaulària on 22/05/12.
//  Copyright (c) 2012 Endepro Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMSPickerView;

@protocol HMSPickerViewDelegate <NSObject>

- (void)hmsPickerView:(HMSPickerView *)hmspickerView didChangeValue:(long)seconds;

@end


@interface HMSPickerView : UIPickerView <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, assign) id<HMSPickerViewDelegate> delegateHMS;

- (void) setValue:(long)sec;
- (long) getValue;
+ (NSString*) secondsToString:(long)sec;
+ (NSString*) secondsToString:(long)sec withFormat:(NSString*)format;
+ (NSString*) minutesToString:(double)min;
+ (NSString*) minutesToString:(double)min withFormat:(NSString*)format;

@end
