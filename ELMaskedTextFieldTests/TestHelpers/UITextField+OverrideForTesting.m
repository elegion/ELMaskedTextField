//
// UITextField(OverrideForTesting)
// ELMaskedTextField
//
// Created by Vladimir Lyukov on 8/1/13.
// Copyright (c) 2013 E-Legion. All rights reserved.

#import "UITextField+OverrideForTesting.h"


@implementation UITextField (OverrideForTesting)

- (id)initWithFrame:(CGRect)frame {
    // we can't call super because we have `logic tests` which doesn't setup UIKit environment
    // and most of UIKit init functions fall with exceptions
    return self;
}

@end