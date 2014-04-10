//
//  validation.m
//  EdibleBlueCheese
//
//  Created by Hao Zheng on 4/9/14.
//  Copyright (c) 2014 Hao Zheng. All rights reserved.
//

#import "FormValidation.h"

@implementation FormValidation

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
    self.emailError = [NSMutableArray arrayWithObjects:@"0",nil];
    NSString *msg = @"Email is invalid.";
    if ([emailTest evaluateWithObject:emailAddress.text] == NO) {//not match
        [self.emailError replaceObjectAtIndex:0 withObject:@"1"];
        [self.emailErrorMsg addObject:msg];
        return ;
    }else{
        [self.emailError replaceObjectAtIndex:0 withObject:@"0"];
        //[emailAddress resignFirstResponder];
        return ;
    }
}

/*******************************
 
 Letters and number, nospace
 
 *****************************/
-(void) LettersNumbersOnly: (UITextField *) textField FieldName: (NSString *) textFieldName {
    
    NSString *lettersSpaceRegex = @"^[a-zA-Z0-9]+$";
    NSPredicate *lettersSpaceTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", lettersSpaceRegex];
    self.lettersNumbersOnly = [NSMutableArray arrayWithObjects:@"0", nil];
    
    if([lettersSpaceTest evaluateWithObject:textField.text] == NO){
        [self.lettersNumbersOnly replaceObjectAtIndex:0 withObject:@"1"];
        NSString *msg = [NSString stringWithFormat:@"%@%s",textFieldName," letters or numbers only."];
        [self.lettersNumbersOnlyMsg addObject:msg];
        return ;
    }else{
        [self.lettersNumbersOnly replaceObjectAtIndex:0 withObject:@"0"];
        [textField restorationIdentifier];
        return ;
    }
}

/*******************
 
 Required
 
 *****************/
-(void) Required: (UITextField *) textField FieldName: (NSString *) textFieldName {
    
    self.requiredError = [NSMutableArray arrayWithObjects:@"0",nil];
    
    if (textField.text.length == 0) {//empty
        [self.requiredError replaceObjectAtIndex:0 withObject:@"1"];
        NSString *msg = [NSString stringWithFormat:@"Please enter %@.",textFieldName];
        [self.requiredErrorMsg addObject:msg];
        return ;
    }else{
        //[textField resignFirstResponder];
        [self.requiredError replaceObjectAtIndex:0 withObject:@"0"];
        return ;
    }
}

/*******************
 
 MinLength
 
 *****************/
-(void) MinLength: (int) length  textField: (UITextField *)textField FieldName: (NSString *) textFieldName{
    
    self.minLengthError = [NSMutableArray arrayWithObjects:@"0", nil];
    
    if(textField.text.length > length || textField.text.length == length){
        [self.minLengthError replaceObjectAtIndex:0 withObject:@"0"];
        return ;
    }else{//not match
        [self.minLengthError replaceObjectAtIndex:0 withObject:@"1"];
        NSString *msg = [NSString stringWithFormat:@"%@ should longer than %d.",textFieldName, length];
        [self.minLengthErrorMsg addObject:msg];
        return ;
    }
}

/*******************
 
 MaxLength
 
 *****************/
- (void) MaxLength: (int) length textField: (UITextField *)textField FieldName: (NSString *) textFieldName {
    
    self.maxLengthError = [NSMutableArray arrayWithObjects:@"0", nil];
    
    NSLog(@"maxLengthError1  %@",self.maxLengthError[0]);
    if(textField.text.length < length || textField.text.length == length) {
        [self.maxLengthError replaceObjectAtIndex:0 withObject:@"0"];
        return ;
        NSLog(@"xxxxxxmMMM@MMK!@M#KMK@@##@#@#@#@#");
    }else{
        NSLog(@"maxLengthError2  %@",self.maxLengthError[0]);
        [self.maxLengthError replaceObjectAtIndex:0 withObject:@"1"];
        NSLog(@"maxLengthError3  %@",self.maxLengthError[0]);
        for (NSString *maxLength in self.maxLengthError){
            
            NSLog(@"xxxxxxx   %@",maxLength);
        }
        
        
        NSString *msg = [NSString stringWithFormat:@"%@ should less than %d.",textFieldName, length];
        [self.maxLengthErrorMsg addObject:msg];
        return ;
    }
}


/*************************************
 
 Check If TextFields Are Valid
 
 ***********************************/

-(BOOL) isValid {
    
    [self.errors removeAllObjects];
    self.errors = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0", nil];

    
    for (NSString *required in self.requiredError){
        if([required isEqualToString:@"1"]){
            [self.errors replaceObjectAtIndex:0 withObject:@"1"];
            for(NSString *msg in self.requiredErrorMsg){
                [self.errorMsg addObject:msg];
            }
            return NO;
        }else{
            [self.errors replaceObjectAtIndex:0 withObject:@"0"];
        }
    }
    
    for (NSString *email in self.emailError) {
        if([email isEqualToString:@"1"]){
            [self.errors replaceObjectAtIndex:1 withObject:@"1"];
            for(NSString *msg in self.emailErrorMsg){
                [self.errorMsg addObject:msg];
            }
            return NO;
        }else{
            [self.errors replaceObjectAtIndex:1 withObject:@"0"];
        }
    }
    
    
    
    for (NSString *minLength in self.minLengthError){
        if([minLength isEqualToString:@"1"]){
            [self.errors replaceObjectAtIndex:2 withObject:@"1"];
            for(NSString *msg in self.minLengthErrorMsg){
                [self.errorMsg addObject:msg];
            }
            return NO;
        }else{
            [self.errors replaceObjectAtIndex:2 withObject:@"0"];
        }
    }
    
    for (NSString *lettersSpace in self.lettersNumbersOnly){
        if([lettersSpace isEqualToString:@"1"]){
            [self.errors replaceObjectAtIndex:3 withObject:@"1"];
            for(NSString *msg in self.lettersNumbersOnlyMsg){
                [self.errorMsg addObject:msg];
            }
            return NO;
        }else{
            [self.errors replaceObjectAtIndex:3 withObject:@"0"];
        }
    }
    
    for (NSString *maxLength in self.maxLengthError){
        
        NSLog(@"---=-=-   %@",maxLength);
        if([maxLength isEqualToString:@"1"]){
            [self.errors replaceObjectAtIndex:4 withObject:@"1"];
            for(NSString *msg in self.maxLengthErrorMsg){
                [self.errorMsg addObject:msg];
            }
            NSLog(@"---=-=-888e8w8we88111112222");
            return NO;
        }else{
            [self.errors replaceObjectAtIndex:4 withObject:@"0"];
            NSLog(@"---=-=-888e8w8we8811133333");
        }
    }
    
    for (NSString *item in self.errors) {
        if([[self.errors objectAtIndex:1]isEqualToString:@"1"] || [[self.errors objectAtIndex:2]isEqualToString:@"1"] || [[self.errors objectAtIndex:0]isEqualToString:@"1"] || [[self.errors objectAtIndex:3]isEqualToString:@"1"] || [[self.errors objectAtIndex:4]isEqualToString:@"1"]){
            self.textFieldIsValid = FALSE;
        }else{
            self.textFieldIsValid = TRUE;
        }
    }
    
    return self.textFieldIsValid;
}


@end
