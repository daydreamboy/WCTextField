//
//  WCTextField.h
//  Pods
//
//  Created by wesley chen on 16/3/3.
//
//

#import <UIKit/UIKit.h>

@class WCTextField;

@protocol WCTextFieldDelegate <NSObject>

@optional
/*!
 *  When press delete key even though the text is empty or not
 *
 *  @param textField    the textField.text is modified after deletion
 */
- (void)textFieldDidDeleteBackward:(WCTextField *)textField;

@end

@interface WCTextField : UITextField

/*!
 *  Top seperator color
 */
@property (nonatomic, strong) UIColor *topSeparatorColor;
/**
 *  Bottom seperator color
 */
@property (nonatomic, strong) UIColor *bottomSeparatorColor;
/*!
 *  Show/Hide top seperator
 *
 *  Default is NO
 */
@property (nonatomic, assign) BOOL showTopSeparator;
/*!
 *  Show/Hide bottom seperator
 *
 *  Default is NO
 */
@property (nonatomic, assign) BOOL showBottomSeparator;
/*!
 *  Only (left, right) will work and negative value will be ignored
 */
@property (nonatomic, assign) UIEdgeInsets topSeparatorInset;
/*!
 *  Only (left, right) will work and negative value will be ignored
 */
@property (nonatomic, assign) UIEdgeInsets bottomSeparatorInset;
/*!
 *  If YES, no 'Select & Select All' show, so no 'Cut & Copy' show
 *
 *  Default is NO.
 *
 *  @see UIResponderStandardEditActions protocol
 */
@property (nonatomic, assign) BOOL disableCopyAndCut;
/*!
 *  If YES, no 'Paste' show
 *
 *  Default is NO.
 *
 *  @see UIResponderStandardEditActions protocol
 */
@property (nonatomic, assign) BOOL disablePaste;

/*!
 *  If YES, not selection when double tapping (select word) or two finger tapping (select all)
 *
 *  Default is NO
 *
 *  @warning selection is still possible when multi-touch (e.g. two fingers) tap quickly too many times.
 */
@property (nonatomic, assign) BOOL disableSelectionWhenMultiTouch;

/*!
 *  If YES, will not show magnifier
 *
 *  Default is NO
 */
@property (nonatomic, assign) BOOL disableShowMagnifier;

/*!
 *  Should be selectable by user. If NO, user can't make WCTextField be focused
 *
 *  Default is YES
 */
@property (nonatomic, assign) BOOL selectable;

/*!
 *  If `attributedPlaceholder` should use `font` no matter how is their assignment order
 *      <br/> If YES, `attributedPlaceholder` has same font as `font` property
 *      <br/> If NO, `attributedPlaceholder` has different font from `font` property
 *
 *  Default is YES
 *  
 *  @warning If `attributedPlaceholder` has not set NSFontAttributeName, will use self.font by system, and set this property to NO doesn't work.
 */
@property (nonatomic, assign) BOOL attributedPlaceholderUseFont;

/*!
 *  Disable attributedPlaceholder center vertically if YES
 *
 *  Default is NO
 */
@property (nonatomic, assign) BOOL disableAttributedPlaceholderCenterVertically;

@property (nonatomic, weak) id<WCTextFieldDelegate> proxy;

- (instancetype)initWithFrame:(CGRect)frame;

@end
