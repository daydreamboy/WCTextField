//
//  Demo4ViewController.m
//  WCTextField
//
//  Created by wesley chen on 16/7/9.
//  Copyright © 2016年 wesley_chen. All rights reserved.
//

#import "Demo4ViewController.h"

#import <WCTextField/WCTextField.h>

#define bSecureTextEntry1 YES
#define bSecureTextEntry2 YES
#define bSecureTextEntry3 YES
#define bSecureTextEntry4 YES

@interface Demo4ViewController () <UITextFieldDelegate, WCTextFieldDelegate>

@property (nonatomic, strong) UITextField *textField1;
@property (nonatomic, strong) UITextField *textField2;
@property (nonatomic, strong) WCTextField *textField3;
@property (nonatomic, strong) WCTextField *textField4;

@property (nonatomic, strong) UIButton *buttonCheckbox1;
@property (nonatomic, strong) UIButton *buttonCheckbox2;
@property (nonatomic, strong) UIButton *buttonCheckbox3;
@property (nonatomic, strong) UIButton *buttonCheckbox4;

@end

@implementation Demo4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.textField1];
    [self.view addSubview:self.buttonCheckbox1];
    
    [self.view addSubview:self.textField2];
    [self.view addSubview:self.buttonCheckbox2];
    
    [self.view addSubview:self.textField3];
    [self.view addSubview:self.buttonCheckbox3];
    
    [self.view addSubview:self.textField4];
    [self.view addSubview:self.buttonCheckbox4];
}

#pragma mark - Getters

- (UITextField *)textField1 {
    if (!_textField1) {
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;

        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 64 + 10, screenSize.width - 2 * 20, 40)];
        textField.delegate = self;
        textField.autocorrectionType = UITextAutocapitalizationTypeNone;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textField.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
        textField.layer.cornerRadius = 3.0f;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.secureTextEntry = bSecureTextEntry1;
        
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Type password here..."
                                                                          attributes:@{
                                               NSForegroundColorAttributeName: [UIColor redColor],
                                               NSFontAttributeName: [UIFont systemFontOfSize:12.0f],
                                           }];
        textField.font = [UIFont systemFontOfSize:20.0f];

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

#pragma mark

- (UITextField *)textField2 {
    if (!_textField2) {
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;

        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.buttonCheckbox1.frame) + 30, screenSize.width - 2 * 20, 40)];
        textField.delegate = self;
        textField.autocorrectionType = UITextAutocapitalizationTypeNone;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textField.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
        textField.layer.cornerRadius = 3.0f;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.secureTextEntry = bSecureTextEntry1;

        textField.font = [UIFont systemFontOfSize:20.0f];

        // @note: must assign attributedPlaceholder after assigning font
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Type password here..."
                                                                          attributes:@{
                                               NSForegroundColorAttributeName: [UIColor redColor],
                                               NSFontAttributeName: [UIFont systemFontOfSize:12.0f],
                                           }];

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

#pragma mark

- (WCTextField *)textField3 {
    if (!_textField3) {
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;

        WCTextField *textField = [[WCTextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.buttonCheckbox2.frame) + 30, screenSize.width - 2 * 20, 40)];
        textField.delegate = self;
        textField.autocorrectionType = UITextAutocapitalizationTypeNone;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textField.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
        textField.layer.cornerRadius = 3.0f;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        // @note: `font` and `attributedPlaceholder`'s order has no effect on `attributedPlaceholderUseFont`
        textField.font = [UIFont systemFontOfSize:20.0f];
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Type password here..."
                                                                          attributes:@{
                                               NSForegroundColorAttributeName: [UIColor redColor],
                                               NSFontAttributeName: [UIFont systemFontOfSize:12.0f],
                                           }];
//        textField.font = [UIFont systemFontOfSize:20.0f];
        textField.attributedPlaceholderUseFont = NO;
        textField.secureTextEntry = bSecureTextEntry3;

        _textField3 = textField;
    }

    return _textField3;
}

- (UIButton *)buttonCheckbox3 {
    if (!_buttonCheckbox3) {
        UIButton *checkboxButton = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.textField3.frame) + 15, 0, 0)];
        checkboxButton.titleLabel.font = [UIFont systemFontOfSize:14];
        checkboxButton.selected = !bSecureTextEntry3;
        [checkboxButton setTitle:@"Show password" forState:UIControlStateNormal];
        [checkboxButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox_s"] forState:UIControlStateSelected];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox"] forState:UIControlStateNormal];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox"] forState:UIControlStateHighlighted];
        [checkboxButton sizeToFit];
        [checkboxButton addTarget:self action:@selector(buttonCheckbox3Clicked:) forControlEvents:UIControlEventTouchUpInside];
        _buttonCheckbox3 = checkboxButton;
    }
    
    return _buttonCheckbox3;
}

#pragma mark

- (WCTextField *)textField4 {
    if (!_textField4) {
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;

        WCTextField *textField = [[WCTextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.buttonCheckbox3.frame) + 30, screenSize.width - 2 * 20, 40)];
        textField.delegate = self;
        textField.autocorrectionType = UITextAutocapitalizationTypeNone;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textField.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
        textField.layer.cornerRadius = 3.0f;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.font = [UIFont systemFontOfSize:20.0f];

        UIFont *textFont = [UIFont fontWithName:@"Georgia-Italic" size:12.0];
        
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Type password here..."
                                                                          attributes:@{
                                               NSForegroundColorAttributeName: [UIColor redColor],
                                               NSFontAttributeName: textFont,
                                           }];
        textField.attributedPlaceholderUseFont = NO;
//        textField.disableAttributedPlaceholderCenterVertically = YES;
        textField.secureTextEntry = bSecureTextEntry4;

        _textField4 = textField;
    }

    return _textField4;
}

- (UIButton *)buttonCheckbox4 {
    if (!_buttonCheckbox4) {
        UIButton *checkboxButton = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.textField4.frame) + 15, 0, 0)];
        checkboxButton.titleLabel.font = [UIFont systemFontOfSize:14];
        checkboxButton.selected = !bSecureTextEntry4;
        [checkboxButton setTitle:@"Show password" forState:UIControlStateNormal];
        [checkboxButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox_s"] forState:UIControlStateSelected];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox"] forState:UIControlStateNormal];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox"] forState:UIControlStateHighlighted];
        [checkboxButton sizeToFit];
        [checkboxButton addTarget:self action:@selector(buttonCheckbox4Clicked:) forControlEvents:UIControlEventTouchUpInside];
        _buttonCheckbox4 = checkboxButton;
    }
    
    return _buttonCheckbox4;
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

- (void)buttonCheckbox3Clicked:(id)sender {
    self.buttonCheckbox3.selected = !self.buttonCheckbox3.selected;
    [self.buttonCheckbox3 setTitle:self.buttonCheckbox3.selected ? @"Hide password" : @"Show password" forState:UIControlStateNormal];
    
    self.textField3.secureTextEntry = !self.buttonCheckbox3.selected;
}

- (void)buttonCheckbox4Clicked:(id)sender {
    self.buttonCheckbox4.selected = !self.buttonCheckbox4.selected;
    [self.buttonCheckbox4 setTitle:self.buttonCheckbox4.selected ? @"Hide password" : @"Show password" forState:UIControlStateNormal];
    
    self.textField4.secureTextEntry = !self.buttonCheckbox4.selected;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

@end
