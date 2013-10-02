//
//  UIViewController+EUIViewController.h
//  rankrunner
//
//  Created by Jordi Badia Santaulària on 11/05/12.
//  Copyright (c) 2012 Endepro Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (EUIViewController) <UITextFieldDelegate, UITextViewDelegate, BSKeyboardControlsDelegate>

@property (nonatomic, strong) BSKeyboardControls *keyboardControls;

- (void)setupKeyboardControls:(id<BSKeyboardControlsDelegate>)delegate textFields:(NSArray*)textFields;

//BSKeyboardControlsDelegate
- (void)keyboardControlsDonePressed:(BSKeyboardControls *)controls;
- (void)keyboardControlsPreviousNextPressed:(BSKeyboardControls *)controls withDirection:(KeyboardControlsDirection)direction andActiveTextField:(id)textField;

- (void) setBackButtonCustom;
- (void) back;

@end