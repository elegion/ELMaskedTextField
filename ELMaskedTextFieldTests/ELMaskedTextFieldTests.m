//
//  ELMaskedTextFieldTests.m
//  ELMaskedTextFieldTests
//
//  Created by Vladimir Lyukov on 8/1/13.
//  Copyright (c) 2013 e-legion. All rights reserved.
//

#import "Kiwi.h"

#import "ELMaskedTextField.h"
#import "ELMaskedTextFieldDelegate.h"

SPEC_BEGIN(ELMaskedTextFieldSpec)

describe(@"ELMaskedTextField", ^{
    __block id maskedTextFieldDelegateMock;

    beforeEach(^{
        maskedTextFieldDelegateMock = [ELMaskedTextFieldDelegate mock];
        [ELMaskedTextFieldDelegate stub:@selector(alloc) andReturn:maskedTextFieldDelegateMock];
        [maskedTextFieldDelegateMock stub:@selector(initWithRealDelegate:mask:) andReturn:maskedTextFieldDelegateMock];
    });

    it(@"should inherit from UITextField", ^{
        [[[[ELMaskedTextField alloc] init] should] beKindOfClass:[UITextField class]];
    });

    describe(@"initWithFrame", ^{
        it(@"should initially have delegate=ELMaskedTextFieldDeleagte", ^{
            [[ELMaskedTextFieldDelegate should] receive:@selector(alloc) andReturn:maskedTextFieldDelegateMock];
            [[maskedTextFieldDelegateMock should] receive:@selector(initWithRealDelegate:mask:) withArguments:nil, nil];

            ELMaskedTextField *textField = [[ELMaskedTextField alloc] init];

            [[(id)textField.delegate should] equal:maskedTextFieldDelegateMock];
        });
    });

    describe(@"setDelegate", ^{
        it(@"should wrap delegate with ELMaskedTextFieldDeleagte", ^{
            id delegate = [KWMock mockForProtocol:@protocol(UITextFieldDelegate)];
            ELMaskedTextField *textField = [[ELMaskedTextField alloc] init];

            [[ELMaskedTextFieldDelegate should] receive:@selector(alloc) andReturn:maskedTextFieldDelegateMock];
            [[maskedTextFieldDelegateMock should] receive:@selector(initWithRealDelegate:mask:) withArguments:delegate,nil];

            textField.delegate = delegate;

            [[(id)textField.delegate should] equal:maskedTextFieldDelegateMock];
        });
    });
});

SPEC_END
