//
//  ELPhoneFieldTests.m
//  ELPhoneFieldTests
//
//  Created by Vladimir Lyukov on 8/1/13.
//  Copyright (c) 2013 e-legion. All rights reserved.
//

#import "Kiwi.h"

#import "ELPhoneTextField.h"
#import "ELPhoneMask.h"
#import "ELMaskedTextFieldDelegate.h"

SPEC_BEGIN(ELPhoneFieldSpec)

describe(@"ELPhoneTextField", ^{
    __block id mockPhoneMask;
    __block id mockMaskedDelegate;
    __block ELPhoneTextField *testedObject;

    beforeEach(^{
        mockPhoneMask = [ELPhoneMask mock];
        [ELPhoneMask stub:@selector(alloc) andReturn:mockPhoneMask];

        mockMaskedDelegate = [ELMaskedTextFieldDelegate mock];
        [ELMaskedTextFieldDelegate stub:@selector(alloc) andReturn:mockMaskedDelegate];
    });

    describe(@"init", ^{
        it(@"should initialize ELMaskedTextFieldDelegate with ELPhoneMask and assign it to self.delegate", ^{
            [[mockPhoneMask should] receive:@selector(init) andReturn:mockPhoneMask];
            [[mockMaskedDelegate should] receive:@selector(initWithRealDelegate:mask:) andReturn:mockMaskedDelegate withArguments:nil, mockPhoneMask];

            [[ELPhoneTextField alloc] init];
        });
    });
});

SPEC_END
