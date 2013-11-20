//
//  ELMaskedTextFieldDelegate
//  ELMaskedTextField
//
//  Created by Vladimir Lyukov on 8/1/13.
//  Copyright (c) 2013 E-Legion. All rights reserved.
//

#import "ELMaskedTextFieldDelegate.h"
#import "ELMaskedTextField.h"
#import "UITextField+SelectText.h"

@interface ELMaskedTextFieldDelegate ()

@end

@implementation ELMaskedTextFieldDelegate

- (instancetype)initWithRealDelegate:(id <UITextFieldDelegate>)realDelegate mask:(ELBaseMask *)mask {
    self = [self init];
    if (self) {
        self.realDelegate = realDelegate;
        self.mask = mask;
    }
    return self;
}

#pragma mark - NSObject overrides

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.realDelegate;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if (self.realDelegate && [self.realDelegate respondsToSelector:aSelector]) {
        return YES;
    }
    return [super respondsToSelector:aSelector];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.realDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.realDelegate textFieldDidBeginEditing:textField];
    }
    if (![textField.text length]) {
        textField.text = @"";
    }
    NSUInteger newOffset = [self.mask adjustCursorPosition:textField.text.length
                                                  forInput:textField.text
                                                  isDelete:NO];
    [textField selectTextAtRange:(NSRange){newOffset}];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.realDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.realDelegate textFieldDidEndEditing:textField];
    }
    if (![[self.mask cleanInput:textField.text] length]) {
        [(ELMaskedTextField *)textField setRawText:@""];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([self.realDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]
            && ![self.realDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string]) {
        return NO;
    }
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (![self.mask isValidInput:newString]) {
        return NO;
    }

    textField.text = newString;

    NSUInteger newOffset = [self.mask adjustCursorPosition:range.location
                                                  forInput:textField.text
                                                  isDelete:![string length]];
    [textField selectTextAtRange:(NSRange){newOffset}];
    return NO;
}

@end