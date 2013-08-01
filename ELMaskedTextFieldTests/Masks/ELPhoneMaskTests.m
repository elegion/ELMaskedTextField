//
//  ELPhoneMaskTests.m
//  ELPhoneMaskTests
//
//  Created by Vladimir Lyukov on 8/1/13.
//  Copyright (c) 2013 e-legion. All rights reserved.
//

#import "Kiwi.h"

#import "ELPhoneMask.h"

SPEC_BEGIN(ELPhoneMaskSpec)

describe(@"ELPhoneMask", ^{
    __block ELPhoneMask *testedObject;
    describe(@"apply", ^{
        beforeEach(^{
            testedObject = [[ELPhoneMask alloc] init];
        });

        it(@"should return whole mask when phone number is empty string", ^{
            [[[testedObject apply:@""] should] equal:@"+_ (___) ___-__-__"];
        });

        it(@"should consider three-digit code for unknown codes", ^{
            [[[testedObject apply:@"0001"] should] equal:@"+000 (1__) ___-__-__"];
        });

        it(@"should determine finished country code", ^{
            [[[testedObject apply:@"1"] should] equal:@"+1 (___) ___-__-__"];
        });

        it(@"should determine one-symbol country code", ^{
            [[[testedObject apply:@"12312"] should] equal:@"+1 (231) 2__-__-__"];
        });

        it(@"should determine two-symbol country code", ^{
            [[[testedObject apply:@"321123121222"] should] equal:@"+32 (112) 312-12-22"];
        });

        it(@"should determine unfinished country code", ^{
            [[[testedObject apply:@"2"] should] equal:@"+2_ (___) ___-__-__"];
        });

        it(@"should return formatted phone number for 12312312", ^{
            [[[testedObject apply:@"12312312"] should] equal:@"+1 (231) 231-2_-__"];
        });
    });
});

SPEC_END
