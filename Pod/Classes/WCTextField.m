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

#ifndef IOS9_OR_LATER
#define IOS9_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"9.0" options:NSNumericSearch] != NSOrderedAscending)
#endif

@interface WCTextField () <UIKeyInput>
@property (nonatomic, strong) UIView *topSeparator;
@property (nonatomic, strong) UIView *bottomSeparator;
@property (nonatomic, assign) CGFloat separatorHeight;

@property (nonatomic, strong) UIView *overlapView;

@property (nonatomic, strong) NSAttributedString *savedAttributedPlaceholder;
@property (nonatomic, strong) NSAttributedString *originalAttributedPlaceholder;

@property (nonatomic, strong) UIFont *fontInOriginalAttributedPlaceholder;
@property (nonatomic, assign) BOOL centerAttributedPlaceholderVertically; /**< Default is NO */

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
        _attributedPlaceholderUseFont = YES;

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

- (void)setText:(NSString *)text {
    if (!IOS9_OR_LATER) {
        [super setText:text];
    }
    else {
        if (self.secureTextEntry) {
            // on iOS 9 and secureTextEntry is YES
            // http://stackoverflow.com/questions/20969451/uitextfield-securetextentry-bullets-with-a-custom-font
            // http://stackoverflow.com/questions/19475918/change-uifont-in-secure-uitextfield-strange-behaviour-in-ios7
            [super setSecureTextEntry:NO];
            [super setText:text];
            [super setSecureTextEntry:YES];
        }
        else {
            [super setText:text];
        }
    }
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry {
    
    if (IOS9_OR_LATER) {
        // on iOS 9+
        [super setSecureTextEntry:secureTextEntry];
        
        if ([self isFirstResponder]) {
            // @sa http://stackoverflow.com/questions/19113566/uitextfield-font-size-changes-when-start-or-stop-entering-the-characters
            // @sa http://stackoverflow.com/questions/28454870/uitextfield-changes-font-while-editing-in-swift-1-2-2-0 (issue: resign/become firstResponder will switch keyboard if there's a third-part keyboard)
            if (!secureTextEntry) {
                UIFont *font = self.font;
                
                // issue 1: this will affect attributedPlaceholder's font
                self.font = nil;
                self.font = font; // set original UIFont back when turn off secureTextEntry
                
                // fix issue 1
                if (self.savedAttributedPlaceholder) {
                    self.attributedPlaceholder = [self.savedAttributedPlaceholder copy];
                }
            }
        }
        
        NSString *savedText = self.text;
        self.text = @" ";
        self.text = savedText;
        savedText = nil;
    }
    else if (IOS8_OR_LATER) {
        // on iOS 8
        [super setSecureTextEntry:secureTextEntry];
        
        // @sa http://stackoverflow.com/questions/14220187/uitextfield-has-trailing-whitespace-after-securetextentry-toggle
        NSString *savedText = self.text;
        self.text = @" ";
        self.text = savedText;
        savedText = nil;
    }
    else if (IOS7_OR_LATER) {
        // on iOS 7
        [super setSecureTextEntry:secureTextEntry];
        
        self.text = self.text;
    }
    else {
        // iOS 6-
        // @sa http://stackoverflow.com/questions/6710019/uitextfield-securetextentry-works-going-from-yes-to-no-but-changing-back-to-y
        // @sa http://stackoverflow.com/questions/23782671/ios-uitextflied-securetextentry-not-working-on-ios-6-1
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
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
    [super setAttributedPlaceholder:attributedPlaceholder];
    
    if (!self.originalAttributedPlaceholder) {
        self.originalAttributedPlaceholder = [attributedPlaceholder copy];
        
        if (!self.disableAttributedPlaceholderCenterVertically) {
            NSRange range;
            id style = [attributedPlaceholder attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:&range];
            if (!style) {
                // not found user's NSParagraphStyleAttributeName, so mark attributedPlaceholder should be centered vertically
                self.centerAttributedPlaceholderVertically = YES;
                
                id font = [attributedPlaceholder attribute:NSFontAttributeName atIndex:0 effectiveRange:NULL];
                if (font) {
                    self.fontInOriginalAttributedPlaceholder = [font copy];
                }
            }
        }
    }
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    // http://stackoverflow.com/questions/15745824/uitextfield-how-to-disable-the-paste

    if (_disablePaste && action == @selector(paste:)) {
        return NO;
    }

    if (_disableCopyAndCut && (
           // actions for long press gesture
            action == @selector(select:) || action == @selector(selectAll:)
           // actions for double tap gesture
            || @selector(copy:) || @selector(cut:))) {
        return NO;
    }

    return [super canPerformAction:action withSender:sender];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!self.savedAttributedPlaceholder) {
        
        if (!self.originalAttributedPlaceholder) {
            self.originalAttributedPlaceholder = [self.attributedPlaceholder copy];
        }
        
        // if placeholder or attributedPlaceholder not set, just ignore it
        if (self.originalAttributedPlaceholder) {
            NSMutableAttributedString *attrStringM = [[NSMutableAttributedString alloc] initWithAttributedString:[self.originalAttributedPlaceholder copy]];
            
            // process 1: attributedPlaceholder should have same font
            if (self.attributedPlaceholderUseFont) {
                [attrStringM addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attrStringM.length)];
            }
            
            // process 2: attributedPlaceholder should center vertically
            if (self.centerAttributedPlaceholderVertically && !self.disableAttributedPlaceholderCenterVertically) {
                UIFont *textFont = self.fontInOriginalAttributedPlaceholder ?: self.font;
                
                // If placeholder size greater than text size, just ignore it
                if (textFont.pointSize < self.font.pointSize) {
                    NSMutableParagraphStyle *style = [self.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
                    style.minimumLineHeight = self.font.lineHeight - (self.font.lineHeight - textFont.lineHeight) / 2.0;
                    
                    [attrStringM addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attrStringM.length)];
                }
            }
            
            self.savedAttributedPlaceholder = attrStringM;
            self.attributedPlaceholder = self.savedAttributedPlaceholder;
        }
    }

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

// @sa http://stackoverflow.com/questions/25371254/how-to-detect-delete-key-on-an-uitextfield-in-ios-8/25862878#25862878
- (BOOL)keyboardInputShouldDelete:(UITextField *)textField {
    BOOL shouldDelete = YES;
    
    // Check if UITextField has keyboardInputShouldDelete: method
    if ([UITextField instancesRespondToSelector:_cmd]) {
        // Get the method pointer of keyboardInputShouldDelete: method in UITextField
        BOOL (*keyboardInputShouldDelete)(id, SEL, UITextField *) = (BOOL (*)(id, SEL, UITextField *))[UITextField instanceMethodForSelector:_cmd];
        
        if (keyboardInputShouldDelete) {
            // Call keyboardInputShouldDelete: method of UITextField (not WCTextField), this will cause to call textField:shouldChangeCharactersInRange:replacementString: method
            shouldDelete = keyboardInputShouldDelete(self, _cmd, textField);
        }
    }
    
    BOOL isIos8 = ([[[UIDevice currentDevice] systemVersion] intValue] == 8);
    BOOL isLessThanIos8_3 = ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.3f);
    
    if (isIos8 && isLessThanIos8_3) {
        [self deleteBackward];
        
        // avoid delete again by system
        return NO;
    }
    
    return shouldDelete;
}

/*!
 *  <#Description#>
 *
 *  @sa http://torimaru.com/2014/12/preventing-text-selection-in-uitextview-with-auto-detection-on/
 *  @sa http://stackoverflow.com/a/18345198/4794665
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (_disableSelectionWhenMultiTouch) {
        // Check for gestures to prevent
        if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {

            // For Debug
//            NSLog(@"%ld", ((UITapGestureRecognizer *)gestureRecognizer).numberOfTouchesRequired);
//            NSLog(@"%ld", ((UITapGestureRecognizer *)gestureRecognizer).numberOfTouches);
//            NSLog(@"%ld", ((UITapGestureRecognizer *)gestureRecognizer).numberOfTapsRequired);
//            NSLog(@"---------------------------------");
            
            // Check for two more fingers tap at the same time
            if (((UITapGestureRecognizer *)gestureRecognizer).numberOfTouchesRequired >= 2) {
                return NO;
            }
            
            if (((UITapGestureRecognizer *)gestureRecognizer).numberOfTouches >= 2) {
                return NO;
            }
            
            // Check for double tap and more
            if (((UITapGestureRecognizer *)gestureRecognizer).numberOfTapsRequired >= 2) {
                // Prevent the double tap and more (double tap in Simulator, two more taps in Device)
                return NO;
            }
        }
    }
    
    if (_disableShowMagnifier) {
        if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
            // For Debug
//            NSLog(@"long press");
            return NO;
        }
    }
    
    // For Debug
//    NSLog(@"return YES");
    
    // Always anything that makes it here
    return YES;
}

#pragma mark - UIKeyInput

// @sa http://stackoverflow.com/questions/1977934/detect-backspace-in-uitextfield
//
// @note Relation between deleteBackward and textField:shouldChangeCharactersInRange:replacementString:
//  <br/> 1. Call this method always, when UITextField.text is empty
//          Press `Delete` key will ignore the return value of textField:shouldChangeCharactersInRange:replacementString:
//
//  <br/> 2. Call this method respected to the return value of textField:shouldChangeCharactersInRange:replacementString:, when UITextField.text is NOT empty
//          If YES, call deleteBackward
//          If NO, not call deleteBackward
- (void)deleteBackward {
    // Call super method to delete
    [super deleteBackward];

    if ([self.proxy respondsToSelector:@selector(textFieldDidDeleteBackward:)]) {
        [self.proxy textFieldDidDeleteBackward:self];
    }
}

@end
