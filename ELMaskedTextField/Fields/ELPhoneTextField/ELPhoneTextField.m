//
//  ELPhoneTextField
//  ELMaskedTextField
//
//  Created by Vladimir Lyukov on 8/1/13.
//  Copyright (c) 2013 E-Legion. All rights reserved.
//

#import <AddressBookUI/AddressBookUI.h>
#import "ELPhoneTextField.h"
#import "ELPhoneMask.h"
#import "ELABPhonePickerNavigationController.h"

@interface ELPhoneTextField () <ELABPhonePickerNavigationControllerDelegate>

@end

@implementation ELPhoneTextField

- (NSString *)countryCode {
    return [(ELPhoneMask *)self.mask countryCode];;
}

- (void)setCountryCode:(NSString *)countryCode {
    [(ELPhoneMask *)self.mask setCountryCode:countryCode];
}

- (void)setupMaskedTextField {
    self.mask = [[ELPhoneMask alloc] init];

    [super setupMaskedTextField];
}

- (IBAction)pickFromAddressBook:(id)sender {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootViewController = window.rootViewController;
    [self showAddressBookPickerInViewController:rootViewController];
}

- (void)showAddressBookPickerInViewController:(UIViewController *)controller {
    ELABPhonePickerNavigationController *phonePicker = [[ELABPhonePickerNavigationController alloc] init];
    phonePicker.phonePickerDelegate = self;
    [controller presentModalViewController:phonePicker animated:YES];
}

#pragma mark - ELABPhonePickerDelegate

- (void)ABPhonePicker:(ELABPhonePickerNavigationController *)picker didSelectPhone:(NSString *)phone {
    self.text = phone;
}

@end