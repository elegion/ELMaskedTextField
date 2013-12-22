//
//  ELNumericTextField
//  ELMaskedTextField
//
//  Created by Vladimir Lyukov on 9/27/13.
//  Copyright (c) 2013 E-Legion. All rights reserved.
//

#import "ELMaskedTextField.h"
#import "ELNumericMask.h"


@interface ELNumericTextField : ELMaskedTextField

@property (nonatomic, strong) ELNumericMask *mask;

@property (nonatomic, strong) NSString *inputMask;

@end