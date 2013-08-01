//
//  ELMaskedTextFieldDelegateTests.m
//  ELMaskedTextFieldDelegateTests
//
//  Created by Vladimir Lyukov on 8/1/13.
//  Copyright (c) 2013 e-legion. All rights reserved.
//

#import "Kiwi.h"

#import "ELMaskedTextFieldDelegate.h"

SPEC_BEGIN(ELMaskedTextFieldDelegateSpec)

describe(@"ELMaskedTextFieldDelegate", ^{
    __block id mockTextField;
    __block id mockRealDelegate;
    __block id mockMask;
    __block ELMaskedTextFieldDelegate *testedObject;

    beforeEach(^{
        mockTextField = [UITextField mock];
        mockMask = [ELBaseMask mock];
    });

    it(@"should respond to realDelegate selectors", ^{
        mockRealDelegate = [UITableView mock];

        testedObject = [[ELMaskedTextFieldDelegate alloc] initWithRealDelegate:mockRealDelegate mask:nil];

        [[testedObject should] respondToSelector:@selector(cellForRowAtIndexPath:)];
    });

    it(@"should pass unrecognized selectors to real delegate", ^{
        id expectedResult = [NSObject mock];
        id arg = [NSIndexPath mock];
        [[mockRealDelegate should] receive:@selector(cellForRowAtIndexPath:) andReturn:expectedResult withArguments:arg];

        testedObject = [[ELMaskedTextFieldDelegate alloc] initWithRealDelegate:mockRealDelegate mask:nil];
        id result = [(id)testedObject cellForRowAtIndexPath:arg];

        [[result should] equal:expectedResult];
    });

    describe(@"initWithRealDelegate:mask:", ^{
        it(@"should assign realDelegate and mask to corresponding properties", ^{
            [testedObject initWithRealDelegate:mockRealDelegate mask:mockMask];

            [[(id)testedObject.realDelegate should] equal:mockRealDelegate];
            [[testedObject.mask should] equal:mockMask];
        });
    });

    describe(@"textFieldDidBeginEditing:", ^{
        it(@"should call realDelegate textFieldDidBeginEditing", ^{
            [mockTextField stub:@selector(text) andReturn:@"text"];
            mockRealDelegate = [KWMock mockForProtocol:@protocol(UITextFieldDelegate)];;
            [[mockRealDelegate should] receive:@selector(textFieldDidBeginEditing:)];

            testedObject = [[ELMaskedTextFieldDelegate alloc] initWithRealDelegate:mockRealDelegate mask:mockMask];
            [testedObject textFieldDidBeginEditing:mockTextField];
        });

        it(@"should do nothing if tex†Field already has text", ^{
            [mockTextField stub:@selector(text) andReturn:@"text"];
            [[mockTextField shouldNot] receive:@selector(setText:)];
            testedObject = [[ELMaskedTextFieldDelegate alloc] initWithRealDelegate:mockRealDelegate mask:mockMask];
            [testedObject textFieldDidBeginEditing:mockTextField];
        });

        it(@"should set textfield text to mask.apply if textField was empty", ^{
            id sampleMaskResponse = @"sample";
            [[mockMask should] receive:@selector(apply:) andReturn:sampleMaskResponse withArguments:@""];
            [mockTextField stub:@selector(text) andReturn:@""];
            [[mockTextField should] receive:@selector(setText:) withArguments:sampleMaskResponse];

            testedObject = [[ELMaskedTextFieldDelegate alloc] initWithRealDelegate:mockRealDelegate mask:mockMask];
            [testedObject textFieldDidBeginEditing:mockTextField];
        });
    });

    describe(@"textFieldDidEndEditing:", ^{
        it(@"should call realDelegate textFieldDidEndEditing", ^{
            [mockTextField stub:@selector(text) andReturn:@"text"];
            [mockMask stub:@selector(cleanInput:) andReturn:@"text"];
            mockRealDelegate = [KWMock mockForProtocol:@protocol(UITextFieldDelegate)];;
            [[mockRealDelegate should] receive:@selector(textFieldDidEndEditing:)];

            testedObject = [[ELMaskedTextFieldDelegate alloc] initWithRealDelegate:mockRealDelegate mask:mockMask];
            [testedObject textFieldDidEndEditing:mockTextField];
        });
    });

    describe(@"textField:shouldChangeCharactersInRange:replacementString:", ^{
        NSString *textFieldText = @"SomeText";
        NSRange range = (NSRange){0, 1};
        NSString *replacementString = @"R";
        NSString *newString = [textFieldText stringByReplacingCharactersInRange:range withString:replacementString];

        beforeEach(^{
            [mockTextField stub:@selector(text) andReturn:textFieldText];

            mockRealDelegate = [KWMock mockForProtocol:@protocol(UITextFieldDelegate)];

            [mockMask stub:@selector(isValidInput:) andReturn:theValue(YES)];
            [mockMask stub:@selector(adjustCursorPosition:forInput:isDelete:) andReturn:theValue(0)];
            [mockTextField stub:@selector(selectTextAtRange:)];

            testedObject = [[ELMaskedTextFieldDelegate alloc] initWithRealDelegate:nil mask:nil];
        });

        it(@"should immediately return NO if realDelegate returns NO", ^{
            [[mockRealDelegate should] receive:@selector(textField:shouldChangeCharactersInRange:replacementString:) andReturn:theValue(NO) withArguments:mockTextField, theValue(range), replacementString];
            [[mockMask shouldNot] receive:@selector(isValidInput:)];

            testedObject.realDelegate = mockRealDelegate;
            BOOL result = [testedObject textField:mockTextField shouldChangeCharactersInRange:range replacementString:replacementString];

            [[theValue(result) should] beFalse];
        });

        it(@"should pass new string to mask.isValidInput and return NO if mask.isValidInput returns NO", ^{
            mockMask = [ELBaseMask mock];
            [[mockMask should] receive:@selector(isValidInput:) andReturn:theValue(NO) withArguments:newString];
            [[mockTextField shouldNot] receive:@selector(setText:)];

            testedObject.mask = mockMask;
            BOOL result = [testedObject textField:mockTextField shouldChangeCharactersInRange:range replacementString:replacementString];

            [[theValue(result) should] beFalse];
        });

        it(@"should apply mask to new string and assign it to textView, then return NO anyway", ^{
            id expectedString = [NSString mock];
            [[mockMask should] receive:@selector(apply:) andReturn:expectedString withArguments:newString];
            [[mockTextField should] receive:@selector(setText:) withArguments:expectedString];

            testedObject.mask = mockMask;
            BOOL result = [testedObject textField:mockTextField shouldChangeCharactersInRange:range replacementString:replacementString];

            [[theValue(result) should] beFalse];
        });
    });
});

SPEC_END
