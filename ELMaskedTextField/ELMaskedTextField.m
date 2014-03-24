//
//  ELMaskedTextField.m
//  ELMaskedTextField
//
//  Created by Vladimir Lyukov on 8/1/13.
//  Copyright (c) 2013 e-legion. All rights reserved.
//

#import "ELMaskedTextField.h"
#import "ELMaskedTextFieldDelegate.h"

@interface ELMaskedTextField()

@property (nonatomic, strong) ELMaskedTextFieldDelegate *maskedTextFieldDelegate;

@end

@implementation ELMaskedTextField

- (void)setupMaskedTextField {
    self.delegate = nil;
}

- (BOOL)hasValidData {
    return [self.mask isValidData:self.text];
}

- (void)setRawText:(NSString *)text {
    [super setText:text];
}

#pragma mark - UITextField overrides

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupMaskedTextField];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupMaskedTextField];
    }
    return self;
}

- (void)setDelegate:(id <UITextFieldDelegate>)delegate {
    self.maskedTextFieldDelegate = [[ELMaskedTextFieldDelegate alloc] initWithRealDelegate:delegate mask:self.mask];
    [super setDelegate:self.maskedTextFieldDelegate];
}

- (void)setText:(NSString *)text {
    [super setText:[self.mask apply:text]];
}

@end
