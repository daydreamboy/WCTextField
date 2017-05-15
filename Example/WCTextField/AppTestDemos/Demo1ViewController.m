//
//  WCViewController.m
//  WCTextField
//
//  Created by wesley_chen on 03/03/2016.
//  Copyright (c) 2016 wesley_chen. All rights reserved.
//

#import "Demo1ViewController.h"
#import <WCTextField/WCTextField.h>

@interface NSString (Demo1ViewController)
- (NSString *)spacedStringWithFormat:(NSString *)formatString;
@end

@implementation NSString (Demo1ViewController)

- (NSString *)spacedStringWithFormat:(NSString *)formatString {
    NSAssert(!formatString || [formatString isKindOfClass:[NSString class]], @"%@ is not a NSString", formatString);
    
    NSString *trimmedString = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSMutableString *stringM = [NSMutableString string];
    NSUInteger i = 0;
    NSUInteger j = 0;
    for (i = 0; i < formatString.length && j < trimmedString.length; i++) {
        
        unichar char1 = [formatString characterAtIndex:i];
        unichar char2 = [trimmedString characterAtIndex:j];
        
        if (char1 == ' ') {
            [stringM appendString:@" "];
        }
        else {
            [stringM appendFormat:@"%C", char2];
            j++;
        }
    }
    
    for (; j < trimmedString.length; j++) {
        [stringM appendFormat:@"%C", [trimmedString characterAtIndex:j]];
    }
    
    return [stringM copy];
}

@end

@interface UITextField (Addition)
- (NSRange)selectedRange;
- (UITextRange *)textRangeFromRange:(NSRange)range;
@end

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
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.autocorrectionType = UITextAutocapitalizationTypeNone;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textField.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
        textField.layer.cornerRadius = 3.0f;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.font = [UIFont systemFontOfSize:16.0f];
        textField.placeholder = @"a UITextField here...";
        textField.secureTextEntry = NO;//bSecureTextEntry1;

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
    
    if (range.length == 0) {
        // Inserting
        NSLog(@"Inserting");
        
        NSString *showedString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSString *spacedString = [self spacedStringWithString:showedString textField:textField range:range];
        NSLog(@"spacedString: %@", spacedString);
        
//        self.textField1.text = spacedString;
        
        return NO;
    }
    else {
        // Replacing or deleting
        if (string.length == 0) {
            // Deleting backward or deleting selection
            NSLog(@"Deleting");
        }
        else {
            // Replacing, excluding replace with @""
            NSLog(@"Replacing");
        }
    }
    
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

- (void)spaceTextInTextField:(UITextField *)textField replacementRange:(NSRange)replacementRange replacementString:(NSString *)replacementString {
    
}

- (NSString *)spacedStringWithString:(NSString *)string textField:(UITextField *)textField range:(NSRange)replacementRange {
    NSString *trimmedString = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSArray *insertPostions = [NSArray array];
    
    if (trimmedString.length < 4) {
        insertPostions = @[];
    }
    else if (trimmedString.length < 8) {
        // insert one space
        insertPostions = @[@(3)];
    }
    else if (trimmedString.length < 12) {
        // insert two spaces
        insertPostions = @[@(3), @(7)];
    }
    else {
        // still insert two spaces
        insertPostions = @[@(3), @(7), @(11)];
    }
    
    NSString *str = [textField.text substringWithRange:NSMakeRange(0, replacementRange.location)];
    NSUInteger numOfSpaces = [[str componentsSeparatedByString:@" "] count] - 1;
    NSLog(@"numOfSpaces: %lu", numOfSpaces);
    
    NSMutableString *stringM = [[NSMutableString alloc] init];
    NSRange savedRange = textField.selectedRange;
    NSRange setRange = NSMakeRange(savedRange.location + 1, savedRange.length);
    
    NSUInteger currentLocation = 0;
    for (NSUInteger i = 0; i < insertPostions.count + 1; i++) {
        
        NSRange range;
        if (i == insertPostions.count) {
            range = NSMakeRange(currentLocation, trimmedString.length - currentLocation);
            
            NSString *substring = [trimmedString substringWithRange:range];
            [stringM appendString:substring];
        }
        else {
            NSUInteger pos = [insertPostions[i] unsignedIntegerValue];
            range = NSMakeRange(currentLocation, pos - currentLocation);
            
            NSString *substring = [trimmedString substringWithRange:range];
            [stringM appendString:substring];
            [stringM appendString:@" "];
            
            currentLocation = pos;
        }
    }
    
    if (textField.text.length == replacementRange.location) {
        // Insert at trail
        if ([insertPostions containsObject:@(trimmedString.length - 1)]) {
            setRange = NSMakeRange(savedRange.location + 2, savedRange.length);
        }
    }
    else {
        // Insert at middle or head
        NSString *nextCharacter = [textField.text substringWithRange:NSMakeRange(replacementRange.location, 1)];
        if ([nextCharacter isEqualToString:@" "]) {
            setRange = NSMakeRange(savedRange.location + 2, savedRange.length);
        }

    }
    
    textField.text = stringM;
    textField.selectedTextRange = [textField textRangeFromRange:setRange];
    
    return [stringM copy];
}

#pragma mark - WCTextFieldDelegate

- (void)textFieldDidDeleteBackward:(WCTextField *)textField {
    NSLog(@"Did deleted: %@", textField.text);
}

@end

@implementation UITextField (Addition)

// http://stackoverflow.com/questions/21149767/convert-selectedtextrange-uitextrange-to-nsrange
- (NSRange)selectedRange {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextRange *selectedRange = self.selectedTextRange;
    
    if (beginning && selectedRange) {
        UITextPosition *selectionStart = selectedRange.start;
        UITextPosition *selectionEnd = selectedRange.end;
        
        const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
        const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
        
        return NSMakeRange(location, length);
    }
    else {
        return NSMakeRange(NSNotFound, 0);
    }
}

- (UITextRange *)textRangeFromRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;
    
    UITextPosition *start = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *end = [self positionFromPosition:start offset:range.length];
    
    UITextRange *textRange = [self textRangeFromPosition:start toPosition:end];
    
    return textRange;
}

@end
