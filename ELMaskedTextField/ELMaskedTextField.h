//
//  ELMaskedTextField.h
//  ELMaskedTextField
//
//  Created by Vladimir Lyukov on 8/1/13.
//  Copyright (c) 2013 e-legion. All rights reserved.
//

#import "ELBaseMask.h"

@interface ELMaskedTextField : UITextField

@property (nonatomic, strong) ELBaseMask *mask;

- (void)setRawText:(NSString *)text;

#pragma mark - Protected methods

- (void)setupMaskedTextField;

@end
