//
//  ELABPhonePickerNavigationController
//  ELMaskedTextField
//
//  Created by Vladimir Lyukov on 8/22/13.
//  Copyright (c) 2013 E-Legion. All rights reserved.
//

#import <AddressBookUI/AddressBookUI.h>

@class ELABPhonePickerNavigationController;

@protocol ELABPhonePickerNavigationControllerDelegate <NSObject>

- (void)ABPhonePicker:(ELABPhonePickerNavigationController *)picker didSelectPhone:(NSString *)phone;

@end

@interface ELABPhonePickerNavigationController : ABPeoplePickerNavigationController

@property (nonatomic, weak) id<ELABPhonePickerNavigationControllerDelegate> phonePickerDelegate;

@end