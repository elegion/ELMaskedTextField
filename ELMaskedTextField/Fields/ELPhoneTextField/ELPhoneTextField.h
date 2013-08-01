//
//  ELPhoneTextField
//  ELMaskedTextField
//
//  Created by Vladimir Lyukov on 8/1/13.
//  Copyright (c) 2013 E-Legion. All rights reserved.
//

#import "ELMaskedTextField.h"

@interface ELPhoneTextField : ELMaskedTextField

@property (nonatomic, strong) NSString *countryCode;

- (IBAction)pickFromAddressBook:(id)sender;
- (void)showAddressBookPickerInViewController:(UIViewController *)controller;

@end
