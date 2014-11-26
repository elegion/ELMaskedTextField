//
//  ELABPhonePickerNavigationController
//  ELMaskedTextField
//
//  Created by Vladimir Lyukov on 8/22/13.
//  Copyright (c) 2013 E-Legion. All rights reserved.
//

#import "ELABPhonePickerNavigationController.h"

@interface ELABPhonePickerNavigationController () <ABPeoplePickerNavigationControllerDelegate>

@end

@implementation ELABPhonePickerNavigationController

- (id)init {
    self = [super init];
    if (self) {
        self.peoplePickerDelegate = self;
    }

    return self;
}

- (void)onPhonePicked:(NSString *)phoneNumber {
    [self.phonePickerDelegate ABPhonePicker:self didSelectPhone:phoneNumber];
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
}

#pragma mark - ABPeoplePickerNavigationControllerDelegate

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);

    if (ABMultiValueGetCount(phoneNumbers) == 1) {
        CFTypeRef phoneNumber = ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
        [self onPhonePicked:(__bridge NSString *)(phoneNumber)];
        CFRelease(phoneNumber);
        CFRelease(phoneNumbers);
        return NO;
    }
    CFRelease(phoneNumbers);
    return YES;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    if (property == kABPersonPhoneProperty) {
        ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, property);
        CFIndex index = ABMultiValueGetIndexForIdentifier(phoneNumbers,  identifier);
        CFTypeRef phoneNumber = ABMultiValueCopyValueAtIndex(phoneNumbers, index);
        [self onPhonePicked:(__bridge NSString *)(phoneNumber)];
        CFRelease(phoneNumber);
        CFRelease(phoneNumbers);
        return NO;
    }
    return YES;
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    [self peoplePickerNavigationController:peoplePicker shouldContinueAfterSelectingPerson:person property:property identifier:identifier];
}

@end