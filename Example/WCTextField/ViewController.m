//
//  WCViewController.m
//  WCTextField
//
//  Created by wesley_chen on 03/03/2016.
//  Copyright (c) 2016 wesley_chen. All rights reserved.
//

#import "ViewController.h"
#import <WCTextField/WCTextField.h>

// preset when initialized
#define bSecureTextEntry YES

@interface ViewController () <UITextFieldDelegate, WCTextFieldDelegate>
@property (nonatomic, strong) WCTextField *textFieldCheckcode;
@property (nonatomic, strong) UIButton *buttonCheckbox;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.textFieldCheckcode];
    [self.view addSubview:self.buttonCheckbox];
}

#pragma mark - Getters

- (UIButton *)buttonCheckbox {
    if (!_buttonCheckbox) {
        UIButton *checkboxButton = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.textFieldCheckcode.frame) + 15, 0, 0)];
        checkboxButton.titleLabel.font = [UIFont systemFontOfSize:14];
        checkboxButton.selected = !bSecureTextEntry;
        [checkboxButton setTitle:@"显示密码" forState:UIControlStateNormal];
        [checkboxButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox_s"] forState:UIControlStateSelected];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox"] forState:UIControlStateNormal];
        [checkboxButton setImage:[UIImage imageNamed:@"login_checkbox"] forState:UIControlStateHighlighted];
        [checkboxButton sizeToFit];
        [checkboxButton addTarget:self action:@selector(buttonCheckboxClicked:) forControlEvents:UIControlEventTouchUpInside];
        _buttonCheckbox = checkboxButton;
    }

    return _buttonCheckbox;
}

- (WCTextField *)textFieldCheckcode {
    
    if (!_textFieldCheckcode) {
        WCTextField *textField = [[WCTextField alloc] initWithFrame:CGRectMake(0, 100, [[UIScreen mainScreen] bounds].size.width, 44)];

        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.backgroundColor = [UIColor whiteColor];
        textField.font = [UIFont systemFontOfSize:17];
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.placeholder = @"请输入验证码";
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.secureTextEntry = bSecureTextEntry;
        textField.delegate = self;
        textField.backgroundColor = [UIColor yellowColor];
//        textField.text = @"123456";
        
        // Test properties
        textField.disablePaste = YES;
        textField.disableCopyAndCut = YES;
        textField.showBottomSeparator = YES;
        textField.showTopSeparator = YES;
        textField.topSeparatorColor = [UIColor redColor];
        textField.proxy = self;
        
        _textFieldCheckcode = textField;
    }
    
    return _textFieldCheckcode;
}

#pragma mark - Actions

- (void)buttonCheckboxClicked:(id)sender {
    self.buttonCheckbox.selected = !self.buttonCheckbox.selected;
    self.textFieldCheckcode.secureTextEntry = !self.buttonCheckbox.selected;
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
