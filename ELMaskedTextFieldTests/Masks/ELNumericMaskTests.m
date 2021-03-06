//
//  ELNumericMaskTests.m
//  ELNumericMaskTests
//
//  Created by Vladimir Lyukov on 12/22/13.
//  Copyright (c) 2013 e-legion. All rights reserved.
//

#import "Kiwi.h"
#import "ELNumericMask.h"

SPEC_BEGIN(ELNumericMaskSpec)

describe(@"ELNumericMask", ^{
    __block ELNumericMask *testedObject;

    beforeEach(^{
        testedObject = [[ELNumericMask alloc] init];
        testedObject.inputMask = @"+# (###)";
    });

    describe(@"hasValidData", ^{
        it(@"should return NO mask is not filled", ^{
            [[theValue([testedObject isValidData:@"+7 (96"]) should] beNo];
        });

        it(@"should return YES if mask is filled", ^{
            [[theValue([testedObject isValidData:@"+7 (961"]) should] beYes];
        });

        it(@"should accept unmasked input", ^{
            [[theValue([testedObject isValidData:@"796"]) should] beNo];
            [[theValue([testedObject isValidData:@"7961"]) should] beYes];
        });
    });

    describe(@"adjustReplacementRange:forInput:isDelete:", ^{
        it(@"should move cursor to the first inputable position to the right", ^{
            [[@([testedObject adjustReplacementRange:NSMakeRange(0, 0) forInput:@"+" isDelete:NO].location) should] equal:@1];
        });

        it(@"should not move cursor outside [input length]", ^{
            [[@([testedObject adjustReplacementRange:NSMakeRange(0, 0) forInput:@"" isDelete:NO].location) should] equal:@0];
        });
    });
});

SPEC_END
