//
//  ELBaseMask
//  ELMaskedTextField
//
//  Created by Vladimir Lyukov on 8/1/13.
//  Copyright (c) 2013 E-Legion. All rights reserved.
//
#import "ELBaseMask.h"


@implementation ELBaseMask

- (BOOL)isValidInput:(NSString *)input {
    return YES;
}

- (BOOL)isValidData:(NSString *)data {
    return YES;
}

- (NSString *)cleanInput:(NSString *)input {
    return input;
}

- (NSString *)apply:(NSString *)input {
    return input;
}

- (NSRange)adjustReplacementRange:(NSRange)range isDelete:(BOOL)delete {
    return range;
}

- (NSUInteger)adjustCursorPosition:(NSUInteger)position forInput:(NSString *)input isDelete:(BOOL)isDelete {
    return position + (isDelete ? 0 : 1);
}

@end