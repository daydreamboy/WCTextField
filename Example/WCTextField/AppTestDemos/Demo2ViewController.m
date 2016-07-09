//
//  Demo2ViewController.m
//  WCTextField
//
//  Created by wesley chen on 16/7/9.
//  Copyright © 2016年 wesley_chen. All rights reserved.
//

#import "Demo2ViewController.h"

#import <WCTextField/WCTextField.h>

@interface Demo2ViewController () <UITextFieldDelegate, WCTextFieldDelegate>
@property (nonatomic, strong) UITextField *textField1;
@property (nonatomic, strong) WCTextField *textField2;

// toggles
@property (nonatomic, strong) UIButton *buttonDisableCopyAndCut;
@property (nonatomic, strong) UIButton *buttonDisablePaste;
@property (nonatomic, strong) UIButton *buttonDisableShowMagnifier;
@property (nonatomic, strong) UIButton *buttonDisableSelectionWhenMultiTouch;
@property (nonatomic, strong) UIButton *buttonSelectable;

@end

@implementation Demo2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.textField1];
    [self.view addSubview:self.textField2];
    [self.view addSubview:self.buttonDisableCopyAndCut];
    [self.view addSubview:self.buttonDisablePaste];
    [self.view addSubview:self.buttonDisableShowMagnifier];
    [self.view addSubview:self.buttonDisableSelectionWhenMultiTouch];
    [self.view addSubview:self.buttonSelectable];
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
        
        _textField1 = textField;
    }
    
    return _textField1;
}

- (WCTextField *)textField2 {
    if (!_textField2) {
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        
        WCTextField *textField = [[WCTextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.textField1.frame) + 30, screenSize.width - 2 * 20, 30)];
        textField.delegate = self;
        textField.autocorrectionType = UITextAutocapitalizationTypeNone;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textField.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
        textField.layer.cornerRadius = 3.0f;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.font = [UIFont systemFontOfSize:16.0f];
        textField.placeholder = @"a WCTextField here...";
        textField.proxy = self;
        
        _textField2 = textField;
    }
    
    return _textField2;
}

- (UIButton *)buttonDisableCopyAndCut {
    if (!_buttonDisableCopyAndCut) {
        UIButton *checkboxButton = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.textField2.frame) + 15, 0, 0)];
        checkboxButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [checkboxButton setTitle:@"Disable Copy & Cut" forState:UIControlStateNormal];
        [checkboxButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox_s"] forState:UIControlStateSelected];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox"] forState:UIControlStateNormal];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox"] forState:UIControlStateHighlighted];
        [checkboxButton sizeToFit];
        [checkboxButton addTarget:self action:@selector(buttonDisableCopyAndCutClicked:) forControlEvents:UIControlEventTouchUpInside];
        _buttonDisableCopyAndCut = checkboxButton;
    }
    
    return _buttonDisableCopyAndCut;
}

- (UIButton *)buttonDisablePaste {
    if (!_buttonDisablePaste) {
        UIButton *checkboxButton = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.buttonDisableCopyAndCut.frame) + 10, 0, 0)];
        checkboxButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [checkboxButton setTitle:@"Disable Paste" forState:UIControlStateNormal];
        [checkboxButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox_s"] forState:UIControlStateSelected];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox"] forState:UIControlStateNormal];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox"] forState:UIControlStateHighlighted];
        [checkboxButton sizeToFit];
        [checkboxButton addTarget:self action:@selector(buttonDisablePasteClicked:) forControlEvents:UIControlEventTouchUpInside];
        _buttonDisablePaste = checkboxButton;
    }
    
    return _buttonDisablePaste;
}

- (UIButton *)buttonDisableShowMagnifier {
    if (!_buttonDisableShowMagnifier) {
        UIButton *checkboxButton = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.buttonDisablePaste.frame) + 10, 0, 0)];
        checkboxButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [checkboxButton setTitle:@"Disable Show Magnifier" forState:UIControlStateNormal];
        [checkboxButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox_s"] forState:UIControlStateSelected];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox"] forState:UIControlStateNormal];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox"] forState:UIControlStateHighlighted];
        [checkboxButton sizeToFit];
        [checkboxButton addTarget:self action:@selector(buttonDisableShowMagnifierClicked:) forControlEvents:UIControlEventTouchUpInside];
        _buttonDisableShowMagnifier = checkboxButton;
    }
    
    return _buttonDisableShowMagnifier;
}

- (UIButton *)buttonDisableSelectionWhenMultiTouch {
    if (!_buttonDisableSelectionWhenMultiTouch) {
        UIButton *checkboxButton = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.buttonDisableShowMagnifier.frame) + 10, 0, 0)];
        checkboxButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [checkboxButton setTitle:@"Disable Selection When MultiTouch (deprecated)" forState:UIControlStateNormal];
        [checkboxButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox_s"] forState:UIControlStateSelected];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox"] forState:UIControlStateNormal];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox"] forState:UIControlStateHighlighted];
        [checkboxButton sizeToFit];
        [checkboxButton addTarget:self action:@selector(buttonDisableSelectionWhenMultiTouchClicked:) forControlEvents:UIControlEventTouchUpInside];
        _buttonDisableSelectionWhenMultiTouch = checkboxButton;
    }
    
    return _buttonDisableSelectionWhenMultiTouch;
}

- (UIButton *)buttonSelectable {
    if (!_buttonSelectable) {
        UIButton *checkboxButton = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.buttonDisableSelectionWhenMultiTouch.frame) + 10, 0, 0)];
        checkboxButton.titleLabel.font = [UIFont systemFontOfSize:14];
        checkboxButton.selected = YES;
        [checkboxButton setTitle:@"Selectable" forState:UIControlStateNormal];
        [checkboxButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox_s"] forState:UIControlStateSelected];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox"] forState:UIControlStateNormal];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox"] forState:UIControlStateHighlighted];
        [checkboxButton sizeToFit];
        [checkboxButton addTarget:self action:@selector(buttonSelectableClicked:) forControlEvents:UIControlEventTouchUpInside];
        _buttonSelectable = checkboxButton;
    }
    
    return _buttonSelectable;
}

#pragma mark - Actions

- (void)buttonDisableCopyAndCutClicked:(id)sender {
    self.buttonDisableCopyAndCut.selected = !self.buttonDisableCopyAndCut.selected;
    self.textField2.disableCopyAndCut = self.buttonDisableCopyAndCut.selected;
}

- (void)buttonDisablePasteClicked:(id)sender {
    self.buttonDisablePaste.selected = !self.buttonDisablePaste.selected;
    self.textField2.disablePaste = self.buttonDisablePaste.selected;
}

- (void)buttonDisableShowMagnifierClicked:(id)sender {
    self.buttonDisableShowMagnifier.selected = !self.buttonDisableShowMagnifier.selected;
    self.textField2.disableShowMagnifier = self.buttonDisableShowMagnifier.selected;
}

- (void)buttonDisableSelectionWhenMultiTouchClicked:(id)sender {
    self.buttonDisableSelectionWhenMultiTouch.selected = !self.buttonDisableSelectionWhenMultiTouch.selected;
    self.textField2.disableSelectionWhenMultiTouch = self.buttonDisableSelectionWhenMultiTouch.selected;
}

- (void)buttonSelectableClicked:(id)sender {
    self.buttonSelectable.selected = !self.buttonSelectable.selected;
    self.textField2.selectable = self.buttonSelectable.selected;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - WCTextFieldDelegate

- (void)textFieldDidDeleteBackward:(WCTextField *)textField {
    NSLog(@"text: %@", textField.text);
}

@end
