//
//  ELBaseMask
//  ELMaskedTextField
//
//  Created by Vladimir Lyukov on 8/1/13.
//  Copyright (c) 2013 E-Legion. All rights reserved.
//

@interface ELBaseMask : NSObject

- (BOOL)isValidInput:(NSString *)input;
- (BOOL)isValidData:(NSString *)data;
- (NSString *)cleanInput:(NSString *)input;
- (NSString *)apply:(NSString *)input;

- (NSRange)adjustReplacementRange:(NSRange)range forInput:(NSString *)input isDelete:(BOOL)delete;
- (NSUInteger)adjustCursorPosition:(NSUInteger)position forInput:(NSString *)input isDelete:(BOOL)isDelete;

@end