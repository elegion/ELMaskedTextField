//
//  ELMaskedTextFieldDelegate
//  ELMaskedTextField
//
//  Created by Vladimir Lyukov on 8/1/13.
//  Copyright (c) 2013 E-Legion. All rights reserved.
//

#import "ELBaseMask.h"

@interface ELMaskedTextFieldDelegate : NSObject<UITextFieldDelegate>

@property (nonatomic, strong) id <UITextFieldDelegate> realDelegate;
@property (nonatomic, strong) ELBaseMask *mask;

- (instancetype)initWithRealDelegate:(id <UITextFieldDelegate>)realDelegate mask:(ELBaseMask *)mask;

@end