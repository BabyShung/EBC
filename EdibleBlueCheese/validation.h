//
//  validation.h
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/9/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface validation : NSObject <UITextFieldDelegate>{
}

//check email
- (void) Email : (UITextField *) emailAddress FieldName: (NSString *) textFieldName;

//check required
- (void) Required : (UITextField *) textField FieldName: (NSString *) textFieldName;

//check minlength
- (void) MinLength: (NSInteger ) length  textField: (UITextField *) textField FieldName: (NSString *) textFieldName;

//
- (void) LettersSpaceOnly: (UITextField *) textField FieldName: (NSString *) textFieldName;

//check maxlength
- (void) MaxLength: (NSInteger) length textField: (UITextField *)textField FieldName: (NSString *) textFieldName;

- (void) successLabel: (UITextField *) textField;
- (void) errorLabel: (UITextField *) textField;


- (BOOL) isValid;

@property(nonatomic) UIButton* submissionButton;
@property(nonatomic, strong) NSMutableArray * errors;
@property(nonatomic, strong) NSMutableArray * errorMsg;
@property(nonatomic, strong) NSMutableArray * emailError;
@property(nonatomic, strong) NSMutableArray * requiredError;
@property(nonatomic, strong) NSMutableArray *minLengthError;
@property(nonatomic, strong) NSMutableArray *lettersSpaceOnly;
@property(nonatomic, strong) NSMutableArray *maxLengthError;

@property(nonatomic, strong) NSMutableArray * emailErrorMsg;
@property(nonatomic, strong) NSMutableArray * requiredErrorMsg;
@property(nonatomic, strong) NSMutableArray *minLengthErrorMsg;
@property(nonatomic, strong) NSMutableArray *lettersSpaceOnlyMsg;
@property(nonatomic, strong) NSMutableArray *maxLengthErrorMsg;
@property(nonatomic, strong) NSString *errorStr;
@property(nonatomic) BOOL textFieldIsValid;

@property(nonatomic, strong) UITextField *textField;


@end

