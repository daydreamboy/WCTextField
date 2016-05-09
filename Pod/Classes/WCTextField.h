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

/*!
 *  a custom UITextField with the following features
 *  <br/> 1. set insets(paddings) for leftView and rightView
 *  <br/> 2. show/hide top and bottom separator, also set their horizontal insets and color
 *  <br/> 3. enable/disable Paste and Copy & Cut popover menu to avoid Paste and Copy & Cut
 */
@interface WCTextField : UITextField

/*!
 *  Top line color
 */
@property (nonatomic, strong) UIColor *topSeparatorColor;
/**
 *  Bottom line color
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

@property (nonatomic, assign) id<WCTextFieldDelegate> proxy;

- (instancetype)initWithFrame:(CGRect)frame;

@end
