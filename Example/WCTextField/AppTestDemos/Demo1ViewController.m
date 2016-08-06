//
//  WCViewController.m
//  WCTextField
//
//  Created by wesley_chen on 03/03/2016.
//  Copyright (c) 2016 wesley_chen. All rights reserved.
//

#import "Demo1ViewController.h"
#import <WCTextField/WCTextField.h>

#ifndef UICOLOR_RGB
#define UICOLOR_RGB(color) [UIColor colorWithRed: (((color) >> 16) & 0xFF) / 255.0 green: (((color) >> 8) & 0xFF) / 255.0 blue: ((color) & 0xFF) / 255.0 alpha: 1.0]
#endif

// preset when initialized
//#define bSecureTextEntry YES
#define bSecureTextEntry1 YES
#define bSecureTextEntry2 YES


/// issues on iOS 7-9 as following:
// 1. when toggle `secureTextEntry` YES to NO and the cursor at trail, will show some unwanted spaces
// 2. when `secureTextEntry` is NO, input some text, then toggle `secureTextEntry` to YES and back to NO, the text's font changed
// 3. when `secureTextEntry` is YES, the cursor in the middle of text, and toggle `secureTextEntry` to NO, the cursor's position is not correct

@interface Demo1ViewController () <UITextFieldDelegate, WCTextFieldDelegate>

@property (nonatomic, strong) UITextField *textField1;
@property (nonatomic, strong) WCTextField *textField2;

@property (nonatomic, strong) UIButton *buttonCheckbox1;
@property (nonatomic, strong) UIButton *buttonCheckbox2;

@end

@implementation Demo1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.textField1];
    [self.view addSubview:self.buttonCheckbox1];
    
    [self.view addSubview:self.textField2];
    [self.view addSubview:self.buttonCheckbox2];
}

#pragma mark - Getters

- (UITextField *)textField1 {
    if (!_textField1) {
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;

        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 64 + 10, screenSize.width - 2 * 20, 30)];
        textField.delegate = self;
        textField.autocorrectionType = UITextAutocapitalizationTypeNone;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textField.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
        textField.layer.cornerRadius = 3.0f;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.font = [UIFont systemFontOfSize:16.0f];
        textField.placeholder = @"a UITextField here...";
        textField.secureTextEntry = bSecureTextEntry1;

        _textField1 = textField;
    }

    return _textField1;
}

- (UIButton *)buttonCheckbox1 {
    if (!_buttonCheckbox1) {
        UIButton *checkboxButton = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.textField1.frame) + 15, 0, 0)];
        checkboxButton.titleLabel.font = [UIFont systemFontOfSize:14];
        checkboxButton.selected = !bSecureTextEntry1;
        [checkboxButton setTitle:@"Show password" forState:UIControlStateNormal];
        [checkboxButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox_s"] forState:UIControlStateSelected];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox"] forState:UIControlStateNormal];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox"] forState:UIControlStateHighlighted];
        [checkboxButton sizeToFit];
        [checkboxButton addTarget:self action:@selector(buttonCheckbox1Clicked:) forControlEvents:UIControlEventTouchUpInside];
        _buttonCheckbox1 = checkboxButton;
    }
    
    return _buttonCheckbox1;
}

- (WCTextField *)textField2 {
    if (!_textField2) {
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        
        WCTextField *textField = [[WCTextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.buttonCheckbox1.frame) + 30, screenSize.width - 2 * 20, 30)];
        textField.delegate = self;
        textField.autocorrectionType = UITextAutocapitalizationTypeNone;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textField.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
        textField.layer.cornerRadius = 3.0f;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.font = [UIFont systemFontOfSize:16.0f];
        textField.placeholder = @"a WCTextField here...";
        textField.secureTextEntry = bSecureTextEntry2;
        
        _textField2 = textField;
    }
    
    return _textField2;
}

- (UIButton *)buttonCheckbox2 {
    if (!_buttonCheckbox2) {
        UIButton *checkboxButton = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.textField2.frame) + 15, 0, 0)];
        checkboxButton.titleLabel.font = [UIFont systemFontOfSize:14];
        checkboxButton.selected = !bSecureTextEntry2;
        [checkboxButton setTitle:@"Show password" forState:UIControlStateNormal];
        [checkboxButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox_s"] forState:UIControlStateSelected];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox"] forState:UIControlStateNormal];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox"] forState:UIControlStateHighlighted];
        [checkboxButton sizeToFit];
        [checkboxButton addTarget:self action:@selector(buttonCheckbox2Clicked:) forControlEvents:UIControlEventTouchUpInside];
        _buttonCheckbox2 = checkboxButton;
    }
    
    return _buttonCheckbox2;
}

#pragma mark - Actions

- (void)buttonCheckbox1Clicked:(id)sender {
    self.buttonCheckbox1.selected = !self.buttonCheckbox1.selected;
    [self.buttonCheckbox1 setTitle:self.buttonCheckbox1.selected ? @"Hide password" : @"Show password" forState:UIControlStateNormal];
    
    self.textField1.secureTextEntry = !self.buttonCheckbox1.selected;
}

- (void)buttonCheckbox2Clicked:(id)sender {
    self.buttonCheckbox2.selected = !self.buttonCheckbox2.selected;
    [self.buttonCheckbox2 setTitle:self.buttonCheckbox2.selected ? @"Hide password" : @"Show password" forState:UIControlStateNormal];
    
    self.textField2.secureTextEntry = !self.buttonCheckbox2.selected;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    /*
    // issue on iOS 9, dot is the same size with UITextField
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    //    textField.secureTextEntry = NO;
    textField.text = text;
    //    textField.secureTextEntry = YES;
    
    return NO;
     */
    
    return YES;
}

#pragma mark - WCTextFieldDelegate

- (void)textFieldDidDeleteBackward:(WCTextField *)textField {
    NSLog(@"Did deleted: %@", textField.text);
}

@end
