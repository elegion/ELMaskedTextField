//
//  ELNumericMask
//  ELMaskedTextField
//
//  Created by Vladimir Lyukov on 9/7/13.
//  Copyright (c) 2013 E-Legion. All rights reserved.
//

#import "ELBaseMask.h"

@interface ELNumericMask : ELBaseMask

@property (nonatomic, strong) NSString *inputMask;
@property (nonatomic, strong) NSString *placeholderSymbol;

@end