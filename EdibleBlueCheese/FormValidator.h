//
//  validation.h
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/9/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormValidator : NSObject <UITextFieldDelegate>{
}

/*******************************************
 
 validate login or register form (Hao added)
 
 *******************************************/
- (void) Email:(UITextField *) email andUsername: (UITextField *) username andPwd: (UITextField *)pwd;

- (void) OldPwd:(UITextField *) oldpwd andNextPwd: (UITextField *) nextpwd andConfirmPwd: (UITextField *)confirmpwd;


/*******************************************
 
 validating components
 
 *******************************************/
//check email
- (void) Email : (UITextField *) emailAddress FieldName: (NSString *) textFieldName;

//check required
- (void) Required : (UITextField *) textField FieldName: (NSString *) textFieldName;

//check minlength
- (void) MinLength: (int) length  textField: (UITextField *) textField FieldName: (NSString *) textFieldName;

//
- (void) LettersNumbersOnly: (UITextField *) textField FieldName: (NSString *) textFieldName;

//check maxlength
- (void) MaxLength: (int) length textField: (UITextField *)textField FieldName: (NSString *) textFieldName;


- (BOOL) isValid;

@property(nonatomic) UIButton* submissionButton;
@property(nonatomic, strong) NSMutableArray * errors;
@property(nonatomic, strong) NSMutableArray * errorMsg;

@property(nonatomic) BOOL emailError;
@property(nonatomic) BOOL requiredError;
@property(nonatomic) BOOL samePwdError;
@property(nonatomic) BOOL minLengthError;
@property(nonatomic) BOOL lettersNumbersOnly;
@property(nonatomic) BOOL maxLengthError;

@property(nonatomic, strong) NSMutableArray * emailErrorMsg;
@property(nonatomic, strong) NSMutableArray * requiredErrorMsg;
@property(nonatomic, strong) NSMutableArray * samePwdErrorMsg;
@property(nonatomic, strong) NSMutableArray *minLengthErrorMsg;
@property(nonatomic, strong) NSMutableArray *lettersNumbersOnlyMsg;
@property(nonatomic, strong) NSMutableArray *maxLengthErrorMsg;
@property(nonatomic, strong) NSString *errorStr;

@property(nonatomic) BOOL textFieldIsValid;

@property(nonatomic, strong) UITextField *textField;


@end

