//
//  validation.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/9/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "FormValidator.h"

@implementation FormValidator

- (id)init {
    self = [super init];
    if (self) {
        self.errorMsg = [[NSMutableArray alloc]init];
        self.requiredErrorMsg = [[NSMutableArray alloc]init];
        self.emailErrorMsg = [[NSMutableArray alloc]init];
        self.lettersNumbersOnlyMsg = [[NSMutableArray alloc]init];
        self.maxLengthErrorMsg = [[NSMutableArray alloc]init];
        self.minLengthErrorMsg = [[NSMutableArray alloc]init];
    }
    return self;
}

/*********************************
 
 HAO: easy way to validate all
 
 *******************************/
- (void) Email:(UITextField *) email andUsername: (UITextField *) username andPwd: (UITextField *)pwd{
    
    //----pass the textFields
    [self Required:email FieldName:@"Email"];
    //----register case
    if(username){
        [self Required:username FieldName:@"Username"];
    }
    [self Required:pwd FieldName:@"Password"];
    [self Email:email FieldName:@"Email"];
    //----register case
    if(username){
        
        [self MinLength:4 textField:pwd FieldName:@"Password"];
        [self LettersNumbersOnly:username FieldName:@"Username"];
        
        [self MaxLength:20 textField:username FieldName:@"Username"];
        
    }
    [self MaxLength:20 textField:pwd FieldName:@"Password"];
    
}



/***************
 
 Email Address
 
 *************/
-(void) Email: (UITextField *) emailAddress FieldName: (NSString *) textFieldName{
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    NSString *msg = @"Email is invalid.";
    if ([emailTest evaluateWithObject:emailAddress.text] == NO) {//not match
        self.emailError = YES;
        [self.emailErrorMsg addObject:msg];
        return ;
    }else{
        return ;
    }
}

/*******************************
 
 Letters and number, nospace
 
 *****************************/
-(void) LettersNumbersOnly: (UITextField *) textField FieldName: (NSString *) textFieldName {
    
    NSString *lettersSpaceRegex = @"^[a-zA-Z0-9]+$";
    NSPredicate *lettersSpaceTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", lettersSpaceRegex];
    
    if([lettersSpaceTest evaluateWithObject:textField.text] == NO){
        self.lettersNumbersOnly = YES;
        NSString *msg = [NSString stringWithFormat:@"%@%s",textFieldName," letters or numbers only."];
        [self.lettersNumbersOnlyMsg addObject:msg];
        return ;
    }else{
        [textField restorationIdentifier];
        return ;
    }
}

/*******************
 
 Required
 
 *****************/
-(void) Required: (UITextField *) textField FieldName: (NSString *) textFieldName {
    
    if (textField.text.length == 0) {//empty
        self.requiredError = YES;
        NSString *msg = [NSString stringWithFormat:@"Please enter %@.",textFieldName];
        [self.requiredErrorMsg addObject:msg];
        return ;
    }else{
        return ;
    }
}

/*******************
 
 MinLength
 
 *****************/
-(void) MinLength: (int) length  textField: (UITextField *)textField FieldName: (NSString *) textFieldName{
    
    if(textField.text.length > length || textField.text.length == length){
        return ;
    }else{//not match
        self.minLengthError = YES;
        NSString *msg = [NSString stringWithFormat:@"%@ should longer than %d.",textFieldName, length];
        [self.minLengthErrorMsg addObject:msg];
        return ;
    }
}

/*******************
 
 MaxLength
 
 *****************/
- (void) MaxLength: (int) length textField: (UITextField *)textField FieldName: (NSString *) textFieldName {
    
    if(textField.text.length < length || textField.text.length == length) {
        return ;
    }else{
        self.maxLengthError = YES;
        NSString *msg = [NSString stringWithFormat:@"%@ should less than %d.",textFieldName, length];
        [self.maxLengthErrorMsg addObject:msg];
        return ;
    }
}


/*************************************
 
 Check If TextFields Are Valid
 
 ***********************************/

-(BOOL) isValid {
    
    
    if(self.requiredError){
        for(NSString *msg in self.requiredErrorMsg){
            [self.errorMsg addObject:msg];
        }
        return NO;
        
    }
    
    if(self.emailError) {
        for(NSString *msg in self.emailErrorMsg){
            [self.errorMsg addObject:msg];
        }
        return NO;
    }
    
    
    
    if(self.minLengthError){
        for(NSString *msg in self.minLengthErrorMsg){
            [self.errorMsg addObject:msg];
        }
        return NO;
        
    }
    
    if(self.lettersNumbersOnly){
        for(NSString *msg in self.lettersNumbersOnlyMsg){
            [self.errorMsg addObject:msg];
        }
        return NO;
        
    }
    
    if(self.maxLengthError){
        for(NSString *msg in self.maxLengthErrorMsg){
            [self.errorMsg addObject:msg];
        }
        return NO;
    }
    //add passed, valid it true
    self.textFieldIsValid = TRUE;
    return self.textFieldIsValid;
}


@end
