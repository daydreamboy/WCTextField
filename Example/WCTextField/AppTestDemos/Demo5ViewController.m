//
//  Demo5ViewController.m
//  WCTextField
//
//  Created by wesley chen on 2017/5/15.
//  Copyright © 2017年 wesley_chen. All rights reserved.
//

#import "Demo5ViewController.h"
#import <WCTextField/WCTextField.h>

@interface Demo5ViewController ()
@property (nonatomic, strong) WCTextField *textField3;
@end

@implementation Demo5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.textField3];
}

#pragma mark

- (WCTextField *)textField3 {
    if (!_textField3) {
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;

        WCTextField *textField = [[WCTextField alloc] initWithFrame:CGRectMake(20, 64 + 30, screenSize.width - 2 * 20, 60)];
        textField.autocorrectionType = UITextAutocapitalizationTypeNone;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textField.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
        textField.layer.cornerRadius = 0.0f;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.font = [UIFont systemFontOfSize:20.0f];
        /*
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Type password here..."
                                                                          attributes:@{
                                               NSForegroundColorAttributeName: [UIColor redColor],
                                               NSFontAttributeName: [UIFont systemFontOfSize:12.0f],
                                           }];
         */
        textField.wrappedAttributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Por favor, crie uma senha com 6-16 caracteres"
                                                                                 attributes:@{
                                                                                              NSForegroundColorAttributeName: [UIColor greenColor],
                                                                                              NSFontAttributeName: [UIFont systemFontOfSize:17.0f],
                                                                                              }];
        
        _textField3 = textField;
    }

    return _textField3;
}
@end
