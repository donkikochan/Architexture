//
//  HMSPickerView.m
//  rankrunner
//
//  Created by Jordi Badia Santaulària on 22/05/12.
//  Copyright (c) 2012 Endepro Software. All rights reserved.
//

#import "HMSPickerView.h"
#import "EConsts.h"

@implementation HMSPickerView

@synthesize delegateHMS;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (void) setValue:(long)sec
{
    int hours = sec / 3600;
    int minutes = (sec - (hours*3600)) / 60;
    int seconds = sec % 60;
    [self selectRow:hours inComponent:0 animated:YES];
    [self selectRow:minutes inComponent:1 animated:YES];
    [self selectRow:seconds inComponent:2 animated:YES];
}

- (long) getValue
{
    int hours = [self selectedRowInComponent:0];
    int minutes = [self selectedRowInComponent:1];
    int seconds = [self selectedRowInComponent:2];
    return (hours*3600) + (minutes*60) + seconds;
}

+ (NSString*) secondsToString:(long)sec
{
    return [self secondsToString:sec withFormat:HMS_PICKERVIEW_STR_FORMAT];
}

+ (NSString*) secondsToString:(long)sec withFormat:(NSString*)format
{
    int hours = sec / 3600;
    int minutes = (sec - (hours*3600)) / 60;
    int seconds = sec % 60;
    
    return [NSString stringWithFormat:format, hours, minutes, seconds];
}

+ (NSString*) minutesToString:(double)min
{
    return [self minutesToString:min withFormat:@"%d:%02d"];
}

+ (NSString*) minutesToString:(double)min withFormat:(NSString*)format
{
    int minutes = abs(min);
    int seconds = (min-(double)minutes) * 60;
    
    return [NSString stringWithFormat:format, minutes, seconds];
}


#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component)
    {
        case 0: //Hours
            return 24;
            
        case 1: //Minutes
            return 60;
            
        case 2: //Seconds
            return 60;
            
        default:
            return 0;
    }
}

#pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component)
    {
        case 0: //Hours
            if (row == 0)
                return HMS_PICKERVIEW_HRS_ROW0;
            
            return [NSString stringWithFormat:HMS_PICKERVIEW_HRS_ROW,row];
            
        case 1: //Minutes
            if (row == 0)
                return HMS_PICKERVIEW_MIN_ROW0;
            
            return [NSString stringWithFormat:HMS_PICKERVIEW_MIN_ROW,row];
            
        case 2: //Minutes
            if (row == 0)
                return HMS_PICKERVIEW_SEC_ROW0;
            
            return [NSString stringWithFormat:HMS_PICKERVIEW_SEC_ROW,row];
            
        default:
            return 0;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (delegateHMS != nil)
        [delegateHMS hmsPickerView:self didChangeValue:[self getValue]];
}

@end
