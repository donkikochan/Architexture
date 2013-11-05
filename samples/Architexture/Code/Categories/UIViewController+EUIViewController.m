//
//  UIViewController+EUIViewController.m
//  rankrunner
//
//  Created by Jordi Badia Santaulària on 11/05/12.
//  Copyright (c) 2012 Endepro Software. All rights reserved.
//

#import "UIViewController+EUIViewController.h"
#import <objc/runtime.h>
#import "ECommon.h"

static char const * const KeyboardControlsKey = "KeyboardControls";

@implementation UIViewController (EUIViewController)

#pragma mark - Keyboard Controls

@dynamic keyboardControls;

- (id) keyboardControls
{
    return objc_getAssociatedObject(self, KeyboardControlsKey);
}

- (void)setKeyboardControls:(id)newKeyboardControls
{
    objc_setAssociatedObject(self, KeyboardControlsKey, newKeyboardControls, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setupKeyboardControls:(id<BSKeyboardControlsDelegate>)delegate textFields:(NSArray*)textFields;
{
    // Initialize the keyboard controls
    self.keyboardControls = [[BSKeyboardControls alloc] init];
    
    // Set the delegate of the keyboard controls
    self.keyboardControls.delegate = delegate;
    
    // Add all text fields you want to be able to skip between to the keyboard controls
    // The order of thise text fields are important. The order is used when pressing "Previous" or "Next"
    self.keyboardControls.textFields = textFields;
    
    // Set the style of the bar. Default is UIBarStyleBlackTranslucent.
    self.keyboardControls.barStyle = UIBarStyleBlackTranslucent;
    
    // Set the tint color of the "Previous" and "Next" button. Default is black.
    self.keyboardControls.previousNextTintColor = [UIColor whiteColor];
    
    // Set the tint color of the done button. Default is a color which looks a lot like the original blue color for a "Done" butotn
    self.keyboardControls.doneTintColor = [UIColor colorWithRed:34.0/255.0 green:164.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    // Set title for the "Previous" button. Default is "Previous".
    self.keyboardControls.previousTitle = NSLocalizedString(@"Previous", @"");
    
    // Set title for the "Next button". Default is "Next".
    self.keyboardControls.nextTitle = NSLocalizedString(@"Next", @"");
    
    // Add the keyboard control as accessory view for all of the text fields
    // Also set the delegate of all the text fields to self
    for (id textField in self.keyboardControls.textFields)
    {
        if ([textField isKindOfClass:[UITextField class]])
        {
            ((UITextField *) textField).inputAccessoryView = self.keyboardControls;
            ((UITextField *) textField).delegate = self;
        }
        else if ([textField isKindOfClass:[UITextView class]])
        {
            ((UITextView *) textField).inputAccessoryView = self.keyboardControls;
            ((UITextView *) textField).delegate = self;
        }
    }
}

- (void)keyboardControlsDonePressed:(BSKeyboardControls *)controls
{
    [controls.activeTextField resignFirstResponder];
}

- (void)keyboardControlsPreviousNextPressed:(BSKeyboardControls *)controls withDirection:(KeyboardControlsDirection)direction andActiveTextField:(id)textField
{
    [textField becomeFirstResponder];
    /*int idx = [self.keyboardControls.textFields indexOfObject:textField];
     if (idx >= 0)
     {
     UITextField *tf = nil;
     if (direction == KeyboardControlsDirectionNext)
     {
     if (idx+1 < self.keyboardControls.textFields.count)
     tf = [self.keyboardControls.textFields objectAtIndex:idx+1];
     }
     else
     {
     if (idx-1 >= 0)
     tf = [self.keyboardControls.textFields objectAtIndex:idx-1];
     }
     
     if (tf != nil)
     [self setTextFieldFirstResponder:tf];
     }*/
}

#pragma mark UITextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.keyboardControls.textFields containsObject:textField])
        self.keyboardControls.activeTextField = textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.returnKeyType == UIReturnKeyDone)
        [self.keyboardControls done];
    else if (textField.returnKeyType == UIReturnKeyNext)
        [self.keyboardControls next];
    return YES;
}

#pragma mark - UITextView Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.keyboardControls.textFields containsObject:textView])
        self.keyboardControls.activeTextField = textView;
}

#pragma mark - Back Button

- (void) setBackButtonCustom
{
    if ([self.navigationController.viewControllers objectAtIndex:0] == self)
        return;
    
    // Set the custom back button
    UIImage *buttonImage = [UIImage imageNamed:@"00_black_bar_back_.png"];
    
    //create the button and assign the image
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    //set the frame of the button to the size of the image (see note below)
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    [button setTitle:NSLocalizedString(@"Back", @"") forState:UIControlStateNormal];
    button.titleLabel.textAlignment = UITextAlignmentCenter;
    [button setTitleColor:[UIColor colorWithR:145 G:145 B:145 A:1] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    //create a UIBarButtonItem with the button as a custom view
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = customBarItem;
    self.navigationItem.leftItemsSupplementBackButton = NO;
}

- (void) back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end