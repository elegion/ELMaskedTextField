//
//  ViewController.m
//  ELMaskedTextFieldExample
//
//  Created by Vladimir Lyukov on 8/1/13.
//  Copyright (c) 2013 e-legion. All rights reserved.
//

#import "ViewController.h"
#import "ELPhoneTextField.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet ELPhoneTextField *phoneTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *ABPickerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    ABPickerButton.frame = (CGRect){0, 0, 64, 20};
    [ABPickerButton setTitle:@"Contacts" forState:UIControlStateNormal];
    [ABPickerButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    ABPickerButton.titleLabel.font = [ABPickerButton.titleLabel.font fontWithSize:10];
    [ABPickerButton addTarget:self.phoneTextField action:@selector(pickFromAddressBook:) forControlEvents:UIControlEventTouchUpInside];
    self.phoneTextField.rightView = ABPickerButton;
    self.phoneTextField.rightViewMode = UITextFieldViewModeAlways;
}

#pragma mark - Actions

- (IBAction)rootViewTapped:(id)sender {
    [self.view endEditing:YES];
}

@end
