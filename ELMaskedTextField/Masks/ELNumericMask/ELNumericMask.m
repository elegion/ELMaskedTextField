//
//  ELNumericMask
//  ELMaskedTextFielde
//
//  Created by Vladimir Lyukov on 9/7/13.
//  Copyright (c) 2013 E-Legion. All rights reserved.
//

#import "ELNumericMask.h"


@implementation ELNumericMask

- (id)init {
    self = [super init];
    if (self) {
        self.placeholderSymbol = @"_";
    }
    return self;
}

- (BOOL)isValidData:(NSString *)data {
//    return YES;
    return [[self apply:data] rangeOfString:self.placeholderSymbol].location == NSNotFound;
}

- (NSString *)cleanInput:(NSString *)input {
    NSRegularExpression *nonNumericRe = [NSRegularExpression regularExpressionWithPattern:@"\\D+"
                                                                                  options:0
                                                                                    error:nil];
    return [nonNumericRe stringByReplacingMatchesInString:input
                                                  options:0
                                                    range:(NSRange){0, [input length]}
                                             withTemplate:@""];
}

- (NSString *)apply:(NSString *)input {
    NSString *cleanInput = [self cleanInput:input];
    NSMutableString *result = [NSMutableString stringWithString:self.inputMask];

    NSUInteger maxCleanInputLength = [[self.inputMask componentsSeparatedByString:@"#"] count] - 1;
    NSString *paddedCleanInput = [cleanInput stringByPaddingToLength:maxCleanInputLength
                                                          withString:self.placeholderSymbol
                                                     startingAtIndex:0];
    NSUInteger j=0;
    for (NSUInteger i=0; i< [result length]; i++) {
        if ([result characterAtIndex:i] == '#') {
            [result replaceCharactersInRange:(NSRange){i, 1} withString:[paddedCleanInput substringWithRange:(NSRange) {j, 1}]];
            j++;
        }
    }
    return result;
}

- (NSRange)adjustReplacementRange:(NSRange)range isDelete:(BOOL)delete {
    NSInteger (^firstInputableToTheLeft)() = ^NSInteger{
        for (NSInteger i=MIN(range.location, self.inputMask.length - 1); i >= 0; i--) {
            unichar c = [self.inputMask characterAtIndex:i];
            if (c == '#') {
                return i;
            }
        }
        return NSNotFound;
    };
    NSInteger (^firstInputableToTheRight)() = ^NSInteger{
        for (NSInteger i=range.location; i < self.inputMask.length; i++) {
            unichar c = [self.inputMask characterAtIndex:i];
            if (c == '#') {
                return i;
            }
        }
        return NSNotFound;
    };
    BOOL atEndOfMask = range.location == [self.inputMask rangeOfString:@"#" options:NSBackwardsSearch].location + 1;
    if (!atEndOfMask && (range.length == 0 || (delete && range.length == 1))) {
        if (delete) {
            NSInteger location = firstInputableToTheLeft();
            if (location == NSNotFound) {
                location = firstInputableToTheRight();
            }
            range.location = location;
        } else {
            NSInteger location = firstInputableToTheRight();
            if (location == NSNotFound) {
                location = firstInputableToTheLeft();
            }
            range.location = location;
        }
    }
    return range;
}

- (NSUInteger)adjustCursorPosition:(NSUInteger)position forInput:(NSString *)input isDelete:(BOOL)isDelete {
    NSUInteger (^firstNumberToTheLeft)() = ^NSUInteger{
        for (NSUInteger i=position; i > 0; i--) {
            unichar c = [input characterAtIndex:i - 1];
            if (c >= '0' && c <= '9') {
                return i;
            }
        }
        return (NSUInteger)NSNotFound;
    };
    NSUInteger (^firstNumberOrVacantToTheRight)() = ^NSUInteger{
        for (NSUInteger i=MIN(position + 1, [input length]); i<[input length]; i++) {
            unichar c = [input characterAtIndex:i];
            if ((c >= '0' && c <= '9') || (c == [self.placeholderSymbol characterAtIndex:0])) {
                return i;
            }
        }
        return (NSUInteger)NSNotFound;
    };
    NSUInteger (^firstVacantPosition)() = ^NSUInteger{
        for (NSUInteger i=0; i<[input length]; i++) {
            unichar c = [input characterAtIndex:i];
            if (c == [self.placeholderSymbol characterAtIndex:0]) {
                return i;
            }
        }
        return NSNotFound;
    };
    NSUInteger (^defaultPos)() = ^NSUInteger{
        return [self.inputMask rangeOfString:@"#"].location;
    };

    NSUInteger res;
    if (isDelete) {
        res = MAX(firstNumberToTheLeft(), defaultPos());
    } else {
        res = MIN(firstNumberOrVacantToTheRight(), [input length]);
        res = MIN(res, firstVacantPosition()); // in case if cursor if far to the right from first vacant position
        // +7 (1__) _|__-__-__ => +7 (1|__) ___-__-__
    }
    if (res == NSNotFound) {
        res = defaultPos();
    }
    return res;
}

@end