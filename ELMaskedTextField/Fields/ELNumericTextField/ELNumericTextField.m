//
//  ELNumericTextField
//  ELMaskedTextField
//
//  Created by Vladimir Lyukov on 9/27/13.
//  Copyright (c) 2013 E-Legion. All rights reserved.
//

#import "ELNumericTextField.h"
#import "ELNumericMask.h"


@implementation ELNumericTextField

- (NSString *)inputMask {
    return self.mask.inputMask;
}

- (void)setInputMask:(NSString *)inputMask {
    self.mask.inputMask = inputMask;
}

- (void)setupMaskedTextField {
    self.mask = [[ELNumericMask alloc] init];

    [super setupMaskedTextField];
}

@end