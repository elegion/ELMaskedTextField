//
//  UITextField(SelectText)
//  ELMaskedTextField
//
//  Created by Vladimir Lyukov on 8/19/13.
//  Copyright (c) 2013 E-Legion. All rights reserved.
//

#import "UITextField+SelectText.h"


@implementation UITextField (SelectText)

- (void)selectTextAtRange:(NSRange)range {
    UITextPosition *start = [self positionFromPosition:[self beginningOfDocument]
                                                offset:range.location];
    UITextPosition *end = [self positionFromPosition:start
                                              offset:range.length];

    [self setSelectedTextRange:[self textRangeFromPosition:start toPosition:end]];
}

@end