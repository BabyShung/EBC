

#import <UIKit/UIKit.h>

@protocol WCActionSheetDelegate;
@interface LoginRegisterForm : UIView <UIAppearanceContainer>



- (instancetype)initWithDelegate:(id<WCActionSheetDelegate>)delegate andShowFromBottom:(BOOL)bottom cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;



@property(nonatomic,assign) id<WCActionSheetDelegate> delegate;    // weak reference

// adds a button with the title. returns the index (0 based) of where it was added. buttons are displayed in the order added except for the
// destructive and cancel button which will be positioned based on HI requirements. buttons cannot be customized.
- (NSInteger)addButtonWithTitle:(NSString *)title;    // returns index of button. 0 based.
- (NSInteger)addButtonWithTitle:(NSString *)title actionBlock:(void (^)())actionBlock;
- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex;

- (NSInteger)addTextBoxWithPlaceHolder:(NSString *)PlaceHolder andComponentName:(NSString *) component;


@property(nonatomic,readonly) NSInteger numberOfButtons;

@property(nonatomic,readonly,getter=isVisible) BOOL visible;
@property(nonatomic) CGFloat blurRadius UI_APPEARANCE_SELECTOR;

@property(nonatomic, strong) UIColor *blurTintColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) UIColor *separatorColor UI_APPEARANCE_SELECTOR;

@property(nonatomic, strong) UIColor *highlightedButtonColor UI_APPEARANCE_SELECTOR;

@property(nonatomic, readonly) NSInteger cancelButtonIndex;
@property(nonatomic, readonly) NSInteger destructiveButtonIndex;

//Hao added for login reg
@property (nonatomic, strong) UITextField *emailTextField;
@property (nonatomic, strong) UITextField *pwdTextField;
@property (nonatomic, strong) UITextField *usernameTextField;

/**
 
    Methods
 
 **/
- (void)show;

- (NSDictionary *)buttonTextAttributesForState:(UIControlState)state UI_APPEARANCE_SELECTOR;
- (void)setButtonTextAttributes:(NSDictionary *)attributes forState:(UIControlState)state UI_APPEARANCE_SELECTOR;
- (NSDictionary *)cancelButtonTextAttributesForState:(UIControlState)state UI_APPEARANCE_SELECTOR;
- (void)setCancelButtonTextAttributes:(NSDictionary *)attributes forState:(UIControlState)state UI_APPEARANCE_SELECTOR;
- (NSDictionary *)destructiveButtonTextAttributesForState:(UIControlState)state UI_APPEARANCE_SELECTOR;
- (void)setDestructiveButtonTextAttributes:(NSDictionary *)attributes forState:(UIControlState)state UI_APPEARANCE_SELECTOR;


// hides alert sheet or popup. use this method when you need to explicitly dismiss the alert.
// it does not need to be called if the user presses on a button
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated;

@end


/**
 
 Protocol
 
 **/

@protocol WCActionSheetDelegate <NSObject>
@optional

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(LoginRegisterForm *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)actionSheetCancel:(LoginRegisterForm *)actionSheet;

- (void)willPresentActionSheet:(LoginRegisterForm *)actionSheet;  // before animation and showing view
- (void)didPresentActionSheet:(LoginRegisterForm *)actionSheet;  // after animation

- (void)actionSheet:(LoginRegisterForm *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex; // before animation and hiding view
- (void)actionSheet:(LoginRegisterForm *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;  // after animation

@end
