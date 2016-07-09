//
//  Demo3ViewController.m
//  WCTextField
//
//  Created by wesley chen on 16/7/9.
//  Copyright © 2016年 wesley_chen. All rights reserved.
//

#import "Demo3ViewController.h"

#import <WCTextField/WCTextField.h>

#define BoxSide  50
#define BoxSpace 10

#ifndef UICOLOR_RGB
#define UICOLOR_RGB(color) [UIColor colorWithRed: (((color) >> 16) & 0xFF) / 255.0 green: (((color) >> 8) & 0xFF) / 255.0 blue: ((color) & 0xFF) / 255.0 alpha: 1.0]
#endif

@interface Demo3ViewController () <UITextFieldDelegate, WCTextFieldDelegate>
@property (nonatomic, strong) WCTextField *textFieldBox1;
@property (nonatomic, strong) WCTextField *textFieldBox2;
@property (nonatomic, strong) WCTextField *textFieldBox3;
@property (nonatomic, strong) WCTextField *textFieldBox4;
@end

@implementation Demo3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.textFieldBox1];
    [self.view addSubview:self.textFieldBox2];
    [self.view addSubview:self.textFieldBox3];
    [self.view addSubview:self.textFieldBox4];
    
    [self.textFieldBox1 becomeFirstResponder];
}

#pragma mark - Getters

- (WCTextField *)textFieldBox1 {
    if (!_textFieldBox1) {
        CGFloat marginL = ([[UIScreen mainScreen] bounds].size.width - 4 * BoxSide - 3 * BoxSpace) / 2.0;
        
        WCTextField *textField = [[WCTextField alloc] initWithFrame:CGRectMake(marginL, 64 + 20, BoxSide, BoxSide)];
        
        textField.tintColor = UICOLOR_RGB(0xFA8919);
        textField.backgroundColor = [UIColor whiteColor];
        textField.font = [UIFont systemFontOfSize:27];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.delegate = self;
        textField.textAlignment = NSTextAlignmentCenter;
        textField.textColor = UICOLOR_RGB(0x333333);
        textField.layer.cornerRadius = 3;
        textField.layer.borderColor = [UICOLOR_RGB(0xE5E5E5) CGColor];
        textField.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
        
        textField.proxy = self;
        textField.disablePaste = YES;
        textField.disableCopyAndCut = YES;
        textField.selectable = NO;
        
        [textField addTarget:self action:@selector(textFieldBoxTextChanged:) forControlEvents:UIControlEventEditingChanged];
        
        _textFieldBox1 = textField;
    }
    
    return _textFieldBox1;
}

- (WCTextField *)textFieldBox2 {
    if (!_textFieldBox2) {
        CGFloat marginL = 10;
        
        WCTextField *textField = [[WCTextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.textFieldBox1.frame) + marginL, CGRectGetMinY(self.textFieldBox1.frame), BoxSide, BoxSide)];
        
        textField.tintColor = UICOLOR_RGB(0xFA8919);
        textField.backgroundColor = [UIColor whiteColor];
        textField.font = [UIFont systemFontOfSize:27];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.delegate = self;
        textField.textAlignment = NSTextAlignmentCenter;
        textField.textColor = UICOLOR_RGB(0x333333);
        textField.layer.cornerRadius = 3;
        textField.layer.borderColor = [UICOLOR_RGB(0xE5E5E5) CGColor];
        textField.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
        
        textField.proxy = self;
        textField.disablePaste = YES;
        textField.disableCopyAndCut = YES;
        textField.selectable = NO;
        
        [textField addTarget:self action:@selector(textFieldBoxTextChanged:) forControlEvents:UIControlEventEditingChanged];
        
        _textFieldBox2 = textField;
    }
    
    return _textFieldBox2;
}

- (WCTextField *)textFieldBox3 {
    if (!_textFieldBox3) {
        CGFloat marginL = 10;
        
        WCTextField *textField = [[WCTextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.textFieldBox2.frame) + marginL, CGRectGetMinY(self.textFieldBox1.frame), BoxSide, BoxSide)];
        
        textField.tintColor = UICOLOR_RGB(0xFA8919);
        textField.backgroundColor = [UIColor whiteColor];
        textField.font = [UIFont systemFontOfSize:27];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.delegate = self;
        textField.textAlignment = NSTextAlignmentCenter;
        textField.textColor = UICOLOR_RGB(0x333333);
        textField.layer.cornerRadius = 3;
        textField.layer.borderColor = [UICOLOR_RGB(0xE5E5E5) CGColor];
        textField.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
        
        textField.proxy = self;
        textField.disablePaste = YES;
        textField.disableCopyAndCut = YES;
        textField.selectable = NO;
        
        [textField addTarget:self action:@selector(textFieldBoxTextChanged:) forControlEvents:UIControlEventEditingChanged];
        
        _textFieldBox3 = textField;
    }
    
    return _textFieldBox3;
}

- (WCTextField *)textFieldBox4 {
    if (!_textFieldBox4) {
        CGFloat marginL = 10;
        
        WCTextField *textField = [[WCTextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.textFieldBox3.frame) + marginL, CGRectGetMinY(self.textFieldBox1.frame), BoxSide, BoxSide)];
        
        textField.tintColor = UICOLOR_RGB(0xFA8919);
        textField.backgroundColor = [UIColor whiteColor];
        textField.font = [UIFont systemFontOfSize:27];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.delegate = self;
        textField.textAlignment = NSTextAlignmentCenter;
        textField.textColor = UICOLOR_RGB(0x333333);
        textField.layer.cornerRadius = 3;
        textField.layer.borderColor = [UICOLOR_RGB(0xE5E5E5) CGColor];
        textField.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
        
        textField.proxy = self;
        textField.disablePaste = YES;
        textField.disableCopyAndCut = YES;
        textField.selectable = NO;
        
        [textField addTarget:self action:@selector(textFieldBoxTextChanged:) forControlEvents:UIControlEventEditingChanged];
        
        _textFieldBox4 = textField;
    }
    
    return _textFieldBox4;
}

#pragma mark - Actions

- (void)textFieldBoxTextChanged:(id)sender {
    if (sender == self.textFieldBox1) {
        if (self.textFieldBox1.text.length == 1) {
            [self.textFieldBox2 becomeFirstResponder];
        }
    }
    else if (sender == self.textFieldBox2) {
        if (self.textFieldBox2.text.length == 1) {
            [self.textFieldBox3 becomeFirstResponder];
        }
        else if (self.textFieldBox2.text.length == 0) {
            [self.textFieldBox1 becomeFirstResponder];
        }
    }
    else if (sender == self.textFieldBox3) {
        if (self.textFieldBox3.text.length == 1) {
            [self.textFieldBox4 becomeFirstResponder];
        }
        else if (self.textFieldBox3.text.length == 0) {
            [self.textFieldBox2 becomeFirstResponder];
        }
    }
    else if (sender == self.textFieldBox4) {
        if (self.textFieldBox4.text.length == 1) {
            
            NSString *code = [NSString stringWithFormat:@"%@%@%@%@", self.textFieldBox1.text, self.textFieldBox2.text, self.textFieldBox3.text, self.textFieldBox4.text];
            NSString *message = [NSString stringWithFormat:@"You input code: %@", code];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else if (self.textFieldBox4.text.length == 0) {
            [self.textFieldBox3 becomeFirstResponder];
        }
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *fullString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (string.length > 0 && ![[[NSNumberFormatter alloc] init] numberFromString:string]) {
        return NO;
    }
    
    if (fullString.length > 1) {
        NSString *oneCharacter = [fullString substringWithRange:NSMakeRange(fullString.length - 1, 1)];
        textField.text = oneCharacter;
        [self textFieldBoxTextChanged:textField];
        
        return NO;
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.layer.borderColor = [UICOLOR_RGB(0xFFA033) CGColor];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    textField.layer.borderColor = (textField.text.length > 0)
        ? [UICOLOR_RGB(0xFFA033) CGColor]
        : [UICOLOR_RGB(0xE5E5E5) CGColor];
}

#pragma mark - WCTextFieldDelegate

- (void)textFieldDidDeleteBackward:(WCTextField *)textField {
    if (textField == self.textFieldBox4 && textField.text.length == 0) {
        if (![self.textFieldBox3 isFirstResponder]) {
            [self.textFieldBox3 becomeFirstResponder];
        }
    }
    else if (textField == self.textFieldBox3 && textField.text.length == 0) {
        if (![self.textFieldBox2 isFirstResponder]) {
            [self.textFieldBox2 becomeFirstResponder];
        }
    }
    else if (textField == self.textFieldBox2 && textField.text.length == 0) {
        if (![self.textFieldBox1 isFirstResponder]) {
            [self.textFieldBox1 becomeFirstResponder];
        }
    }
}

@end
