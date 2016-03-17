//
//  WCTextField.m
//  Pods
//
//  Created by wesley chen on 16/3/3.
//
//

#import "WCTextField.h"

#ifndef IOS7_OR_LATER
#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending)
#endif

#ifndef IOS8_OR_LATER
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending)
#endif

@interface WCTextField () <UIKeyInput>
@property (nonatomic, strong) UIView *topSeparator;
@property (nonatomic, strong) UIView *bottomSeparator;
@property (nonatomic, assign) CGFloat separatorHeight;

@property (nonatomic, strong) UIView *leftViewWrappingView;
@property (nonatomic, strong) UIView *rightViewWrappingView;
// User's leftView and rightView
@property (nonatomic, strong) UIView *wrappedLeftView;
@property (nonatomic, strong) UIView *wrappedRightView;

@property (nonatomic, strong) UIView *overlapView;

@end


@implementation WCTextField

#pragma mark - Public Methods

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        _topSeparatorColor = [UIColor colorWithRed:0xC8 / 255.0 green:0xC7 / 255.0 blue:0xCC / 255.0 alpha:1];
        _bottomSeparatorColor = [UIColor colorWithRed:0xC8 / 255.0 green:0xC7 / 255.0 blue:0xCC / 255.0 alpha:1];
        _separatorHeight = 1.0 / [UIScreen mainScreen].scale;
        _topSeparator = [UIView new];
        _bottomSeparator = [UIView new];

        if (!IOS7_OR_LATER) {
            self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        }

        _selectable = YES;

        _overlapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _overlapView.userInteractionEnabled = !_selectable;
        [self addSubview:_overlapView];
    }

    return self;
}

#pragma mark Setters

- (void)setTopSeparatorInset:(UIEdgeInsets)topSeparatorInset {
    if (topSeparatorInset.left < 0) {
        topSeparatorInset.left = 0;
    }

    if (topSeparatorInset.right < 0) {
        topSeparatorInset.right = 0;
    }

    _topSeparatorInset = topSeparatorInset;
}

- (void)setBottomSeparatorInset:(UIEdgeInsets)bottomSeparatorInset {
    if (bottomSeparatorInset.left < 0) {
        bottomSeparatorInset.left = 0;
    }

    if (bottomSeparatorInset.right < 0) {
        bottomSeparatorInset.right = 0;
    }

    _bottomSeparatorInset = bottomSeparatorInset;
}

- (void)setTopSeparatorColor:(UIColor *)topSeparatorColor {
    _topSeparatorColor = topSeparatorColor;
    self.topSeparator.backgroundColor = _topSeparatorColor;
}

- (void)setBottomSeparatorColor:(UIColor *)bottomSeparatorColor {
    _bottomSeparatorColor = bottomSeparatorColor;
    self.bottomSeparator.backgroundColor = _bottomSeparatorColor;
}

- (void)setSelectable:(BOOL)selectable {
    _selectable = selectable;
    _overlapView.userInteractionEnabled = !selectable;
}

#pragma mark

- (void)setSecureTextEntry:(BOOL)secureTextEntry {
    if (!IOS7_OR_LATER) {
        // on iOS 6-
        // http://stackoverflow.com/questions/6710019/uitextfield-securetextentry-works-going-from-yes-to-no-but-changing-back-to-y
        // http://stackoverflow.com/questions/23782671/ios-uitextflied-securetextentry-not-working-on-ios-6-1
        if (secureTextEntry) {
            BOOL isFocused = [self isFirstResponder];
            self.enabled = NO;
            [super setSecureTextEntry:YES];
            self.enabled = YES;

            if (isFocused) {
                [self becomeFirstResponder];
            }
        }
        else {
            [super setSecureTextEntry:NO];
        }
    }
    else {
        [super setSecureTextEntry:secureTextEntry];

        // http://stackoverflow.com/questions/14220187/uitextfield-has-trailing-whitespace-after-securetextentry-toggle
        if (IOS8_OR_LATER) {
            // on iOS 8+
            NSString *savedText = self.text;
            self.text = @" ";
            self.text = savedText;
            savedText = nil;
        }
        else {
            // on iOS 7
            self.text = self.text;
        }
    }
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    // http://stackoverflow.com/questions/15745824/uitextfield-how-to-disable-the-paste

    if (_disablePaste && action == @selector(paste:)) {
        return NO;
    }

    if (_disableCopyAndCut && (action == @selector(select:) || action == @selector(selectAll:))) {
        return NO;
    }

    return [super canPerformAction:action withSender:sender];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (!_topSeparator.superview && _showTopSeparator) {
        _topSeparator.frame = CGRectMake(_topSeparatorInset.left, 0, CGRectGetWidth(self.bounds) - _topSeparatorInset.left - _topSeparatorInset.right, _separatorHeight);
        _topSeparator.backgroundColor = _topSeparatorColor;
        [self addSubview:_topSeparator];
    }

    if (!_bottomSeparator.superview && _showBottomSeparator) {
        _bottomSeparator.frame = CGRectMake(_bottomSeparatorInset.left, CGRectGetMaxY(self.bounds) - _separatorHeight, CGRectGetWidth(self.bounds) - _bottomSeparatorInset.left - _bottomSeparatorInset.right, _separatorHeight);
        _bottomSeparator.backgroundColor = _bottomSeparatorColor;
        [self addSubview:_bottomSeparator];
    }

    // Always show separators front when editing
    [self bringSubviewToFront:_topSeparator];
    [self bringSubviewToFront:_bottomSeparator];
    [self bringSubviewToFront:_overlapView];
}

#pragma mark - UIKeyInput

// @sa http://stackoverflow.com/questions/1977934/detect-backspace-in-uitextfield
- (void)deleteBackward {
    [super deleteBackward];

    if ([self.proxy respondsToSelector:@selector(textFieldDidDeleteBackward:)]) {
        [self.proxy textFieldDidDeleteBackward:self];
    }
}

@end
