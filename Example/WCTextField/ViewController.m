//
//  WCViewController.m
//  WCTextField
//
//  Created by wesley_chen on 03/03/2016.
//  Copyright (c) 2016 wesley_chen. All rights reserved.
//

#import "ViewController.h"
#import <WCTextField/WCTextField.h>

#import <openssl/rsa.h>
#import <openssl/pem.h>

// preset when initialized
#define bSecureTextEntry YES

@interface ViewController () <UITextFieldDelegate>
@property (nonatomic, strong) WCTextField *textFieldCheckcode;
@property (nonatomic, strong) UIButton *buttonCheckbox;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.textFieldCheckcode];
    [self.view addSubview:self.buttonCheckbox];
    
    [self testRSA];
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
        
        // Test properties
        textField.disablePaste = YES;
        textField.disableCopyAndCut = YES;
        textField.showBottomSeparator = YES;
        textField.showTopSeparator = YES;
        textField.topSeparatorColor = [UIColor redColor];
        
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

static NSData * base64_decode(NSString *str) {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    return data;
}

- (void)testRSA {
    char *public_key = "-----BEGIN PUBLIC KEY-----\n"
    "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC45jJQRNy7P7uygaDEa5XBqAWg\n"
    "aYp0yRi9joFnBZ7gqq8i/daV4Ix3gR3N9GLmdw/cHLaeLuOESAYZtqKfynKuMAjo\n"
    "hbv6NZ9TsLgbFfHmlxUNEeCQLQHHKPe8HH6iSdQku+yaLT0K10d3yuEUQxY++bN9\n"
    "Zm16EWO/l24PhVYwEwIDAQAB\n"
    "-----END PUBLIC KEY-----\n";
    
    char *private_key = "-----BEGIN RSA PRIVATE KEY-----\n"
    "MIICWwIBAAKBgQC45jJQRNy7P7uygaDEa5XBqAWgaYp0yRi9joFnBZ7gqq8i/daV\n"
    "4Ix3gR3N9GLmdw/cHLaeLuOESAYZtqKfynKuMAjohbv6NZ9TsLgbFfHmlxUNEeCQ\n"
    "LQHHKPe8HH6iSdQku+yaLT0K10d3yuEUQxY++bN9Zm16EWO/l24PhVYwEwIDAQAB\n"
    "AoGAZhU53BVY5MzYPULSVv+rC+NPT/RVLAtG7Ij8KrvwrsutrB0HV3JFO0l/AhGW\n"
    "dPVxPS5hKM5scMEvFQ0/lgc47sByRDWPXzyLrCDmJDC+++tTZCKCzMCoHU7FH5NO\n"
    "BguG6mIAiMCp0MqzMvzrsMEZ7FFHx2YoFfDj9jVoAjp+W+ECQQDV1DQ3PuhL84wk\n"
    "2RrU/8f0ztYuQRdVe5Ncaqg3Tav/X+n19N57QCiWPXpLAbL9mfdBUI/XN9iH+VSE\n"
    "d6HlIECRAkEA3V1ji4dfcVvalq/k36lKXPiVKLnyA8JMg2mJbLCxvGDYJXf3ATuG\n"
    "H/vn5CMBqpzhJLL8SlKL4xKYAXbYPqW4YwJAav27AsmfQiGixe0718gELSIxWQOI\n"
    "wWUL3vofIUzj+uvrDP5xNApuRH6Oaml3Ph2D8lJ1JqLy3VaMS5vwjc0NgQJAa9Yw\n"
    "xin+TsTGaZ3qSyK3PS9DyoE66qXejC3/allxXCl5YldcltcecbpPrw12pFykOTKQ\n"
    "QMyRpN7L+fqhQXONrQJAM5r9oEpSeGyxt82j1NJlTRiI75A6xgjO+J04rxIdUQFN\n"
    "fgH3K8uVMv7MKauZ6c2K4qDzq+hPUpjWZMwHdyOXnA==\n"
    "-----END RSA PRIVATE KEY-----\n";
    
    NSString *publicKey;
    NSString *privateKey;
    NSData *data3;
    
    publicKey = @"LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlHZk1BMEdDU3FHU0liM0RRRUJBUVVBQTRHTkFEQ0JpUUtCZ1FDNDVqSlFSTnk3UDd1eWdhREVhNVhCcUFXZwphWXAweVJpOWpvRm5CWjdncXE4aS9kYVY0SXgzZ1IzTjlHTG1kdy9jSExhZUx1T0VTQVladHFLZnluS3VNQWpvCmhidjZOWjlUc0xnYkZmSG1seFVORWVDUUxRSEhLUGU4SEg2aVNkUWt1K3lhTFQwSzEwZDN5dUVVUXhZKytiTjkKWm0xNkVXTy9sMjRQaFZZd0V3SURBUUFCCi0tLS0tRU5EIFBVQkxJQyBLRVktLS0tLQo=";
    
    privateKey = @"LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlDV3dJQkFBS0JnUUM0NWpKUVJOeTdQN3V5Z2FERWE1WEJxQVdnYVlwMHlSaTlqb0ZuQlo3Z3FxOGkvZGFWCjRJeDNnUjNOOUdMbWR3L2NITGFlTHVPRVNBWVp0cUtmeW5LdU1Bam9oYnY2Tlo5VHNMZ2JGZkhtbHhVTkVlQ1EKTFFISEtQZThISDZpU2RRa3UreWFMVDBLMTBkM3l1RVVReFkrK2JOOVptMTZFV08vbDI0UGhWWXdFd0lEQVFBQgpBb0dBWmhVNTNCVlk1TXpZUFVMU1Z2K3JDK05QVC9SVkxBdEc3SWo4S3J2d3JzdXRyQjBIVjNKRk8wbC9BaEdXCmRQVnhQUzVoS001c2NNRXZGUTAvbGdjNDdzQnlSRFdQWHp5THJDRG1KREMrKyt0VFpDS0N6TUNvSFU3Rkg1Tk8KQmd1RzZtSUFpTUNwME1xek12enJzTUVaN0ZGSHgyWW9GZkRqOWpWb0FqcCtXK0VDUVFEVjFEUTNQdWhMODR3awoyUnJVLzhmMHp0WXVRUmRWZTVOY2FxZzNUYXYvWCtuMTlONTdRQ2lXUFhwTEFiTDltZmRCVUkvWE45aUgrVlNFCmQ2SGxJRUNSQWtFQTNWMWppNGRmY1Z2YWxxL2szNmxLWFBpVktMbnlBOEpNZzJtSmJMQ3h2R0RZSlhmM0FUdUcKSC92bjVDTUJxcHpoSkxMOFNsS0w0eEtZQVhiWVBxVzRZd0pBYXYyN0FzbWZRaUdpeGUwNzE4Z0VMU0l4V1FPSQp3V1VMM3ZvZklVemordXZyRFA1eE5BcHVSSDZPYW1sM1BoMkQ4bEoxSnFMeTNWYU1TNXZ3amMwTmdRSkFhOVl3CnhpbitUc1RHYVozcVN5SzNQUzlEeW9FNjZxWGVqQzMvYWxseFhDbDVZbGRjbHRjZWNicFBydzEycEZ5a09US1EKUU15UnBON0wrZnFoUVhPTnJRSkFNNXI5b0VwU2VHeXh0ODJqMU5KbFRSaUk3NUE2eGdqTytKMDRyeElkVVFGTgpmZ0gzSzh1Vk12N01LYXVaNmMySzRxRHpxK2hQVXBqV1pNd0hkeU9YbkE9PQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQo=";
    
    data3 = base64_decode(publicKey);
    NSString *pubKey = [[NSString alloc] initWithData:data3 encoding:NSUTF8StringEncoding];
    
    data3 = base64_decode(privateKey);
    NSString *priKey = [[NSString alloc] initWithData:data3 encoding:NSUTF8StringEncoding];
    
    
    public_key = [pubKey UTF8String];
    private_key = [priKey UTF8String];
    
    BIO *bio = BIO_new_mem_buf((void *)public_key, (int)strlen(public_key));
    RSA *rsa_publickey = PEM_read_bio_RSA_PUBKEY(bio, NULL, 0, NULL);
    BIO_free(bio);
    
    BIO *bio2 = BIO_new_mem_buf((void *)private_key, (int)strlen(private_key));
    RSA *rsa_privatekey = PEM_read_bio_RSAPrivateKey(bio2, NULL, 0, NULL);
    BIO_free(bio2);
    
    NSString *test = @"hello";
    NSData *data = [test dataUsingEncoding:NSUTF8StringEncoding];
    
    // Allocate a buffer
    int maxSize = RSA_size(rsa_publickey);
    unsigned char *output = (unsigned char *)malloc(maxSize * sizeof(char));
    
    // Fill buffer with encrypted data
    int bytes = RSA_public_encrypt((int)[data length], [data bytes], output, rsa_publickey, RSA_PKCS1_PADDING);
    
    // If you want a NSData object back
    NSData *result = [NSData dataWithBytes:output length:bytes];
    
    NSLog(@"%@", result);
    
    NSData *data2 = [result base64EncodedDataWithOptions:0];
    NSString *base64String = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
    NSLog(@"%@", base64String);
    
    // Allocate a buffer
    unsigned char *decrypted = (unsigned char *)malloc(1000);
    
    // Fill buffer with decrypted data
    RSA_private_decrypt(bytes, output, decrypted, rsa_privatekey, RSA_PKCS1_PADDING);
    printf("%s", decrypted);
}

@end
