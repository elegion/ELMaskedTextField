//
//  ELPhoneMask
//  ELMaskedTextField
//
//  Created by Vladimir Lyukov on 8/1/13.
//  Copyright (c) 2013 E-Legion. All rights reserved.
//
#import "ELPhoneMask.h"


@implementation ELPhoneMask

- (NSString *)defaultMask {
    return @"+# (###) ###-##-##";
}

- (NSString *)placeholderSymbol {
    return @"_";
}

- (BOOL)isValidInput:(NSString *)input {
    return [super isValidInput:input];
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
    const NSInteger localPhoneLength = 10;
    NSString *cleanInput = [self cleanInput:input];
    NSString *countryCode = [self countryCodeFromPhone:cleanInput];
    NSMutableString *result = [NSMutableString stringWithString:[self defaultMask]];
    NSRange countryCodeRange = [result rangeOfString:@"#"]; // First # stands for country code
    NSString *localPhone = @"";

    if (self.countryCode) {
        if (countryCode == nil) {
            localPhone = cleanInput;
        } else if (![countryCode isEqualToString:self.countryCode]) {
            if ([cleanInput length] <= localPhoneLength) {
                localPhone = cleanInput;
            } else {
                localPhone = [cleanInput substringFromIndex:MIN([countryCode length], [self.countryCode length])];
            }
        } else { // countryCode == self.countryCode
            localPhone = [cleanInput substringFromIndex:MIN([countryCode length], [self.countryCode length])];
        }
        countryCode = self.countryCode;
    } else if (countryCode) {
        localPhone = [cleanInput substringFromIndex:[countryCode length]];
    }

    if (countryCode) {
        NSString *paddedLocalPhone = [localPhone stringByPaddingToLength:10 withString:self.placeholderSymbol startingAtIndex:0];
        NSUInteger j=0;
        [result replaceCharactersInRange:countryCodeRange withString:countryCode];
        for (NSUInteger i=0; i< [result length]; i++) {
            if ([result characterAtIndex:i] == '#') {
                [result replaceCharactersInRange:(NSRange){i, 1} withString:[paddedLocalPhone substringWithRange:(NSRange) {j, 1}]];
                j++;
            }
        }
        return result;
    } else {
        if (cleanInput) {
            [result replaceCharactersInRange:countryCodeRange withString:[cleanInput stringByAppendingString:self.placeholderSymbol]];
        }
        return [result stringByReplacingOccurrencesOfString:@"#" withString:self.placeholderSymbol];
    }
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
        return [self.defaultMask rangeOfString:@"#"].location;
    };

    NSUInteger res;
    if (isDelete) {
        res = firstNumberToTheLeft();
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

- (NSString *)countryCodeFromPhone:(NSString *)phone {
    NSArray *codes = @[
            @"1",
            @"20",
            @"212",
            @"213",
            @"216",
            @"218",
            @"220",
            @"221",
            @"222",
            @"223",
            @"224",
            @"225",
            @"226",
            @"227",
            @"228",
            @"229",
            @"230",
            @"231",
            @"232",
            @"233",
            @"234",
            @"235",
            @"236",
            @"237",
            @"238",
            @"239",
            @"240",
            @"241",
            @"242",
            @"243",
            @"244",
            @"245",
            @"246",
            @"247",
            @"248",
            @"249",
            @"250",
            @"251",
            @"252",
            @"253",
            @"254",
            @"255",
            @"256",
            @"257",
            @"258",
            @"260",
            @"261",
            @"262",
            @"262",
            @"263",
            @"264",
            @"265",
            @"266",
            @"267",
            @"268",
            @"269",
            @"27",
            @"290",
            @"291",
            @"297",
            @"298",
            @"299",
            @"30",
            @"31",
            @"32",
            @"33",
            @"34",
            @"350",
            @"351",
            @"352",
            @"353",
            @"354",
            @"355",
            @"356",
            @"357",
            @"358",
            @"359",
            @"36",
            @"370",
            @"371",
            @"372",
            @"373",
            @"374",
            @"375",
            @"376",
            @"377",
            @"378",
            @"379",
            @"380",
            @"381",
            @"382",
            @"385",
            @"386",
            @"387",
            @"389",
            @"39",
            @"40",
            @"41",
            @"420",
            @"421",
            @"423",
            @"43",
            @"44",
            @"45",
            @"46",
            @"47",
            @"48",
            @"49",
            @"500",
            @"501",
            @"502",
            @"503",
            @"504",
            @"505",
            @"506",
            @"507",
            @"508",
            @"509",
            @"51",
            @"52",
            @"53",
            @"54",
            @"55",
            @"56",
            @"57",
            @"58",
            @"590",
            @"591",
            @"592",
            @"593",
            @"594",
            @"595",
            @"596",
            @"597",
            @"598",
            @"599",
            @"60",
            @"61",
            @"62",
            @"63",
            @"64",
            @"65",
            @"66",
            @"670",
            @"673",
            @"674",
            @"675",
            @"677",
            @"678",
            @"679",
            @"680",
            @"681",
            @"682",
            @"683",
            @"685",
            @"686",
            @"687",
            @"688",
            @"689",
            @"690",
            @"691",
            @"692",
            @"7",
            @"7",
            @"81",
            @"82",
            @"84",
            @"850",
            @"852",
            @"853",
            @"855",
            @"856",
            @"86",
            @"870" ,
            @"880",
            @"886",
            @"90",
            @"91",
            @"92",
            @"93",
            @"94",
            @"95",
            @"960",
            @"961",
            @"962",
            @"963",
            @"964",
            @"965",
            @"966",
            @"967",
            @"968",
            @"971",
            @"972",
            @"973",
            @"974",
            @"975",
            @"976",
            @"977",
            @"98",
            @"992",
            @"993",
            @"994",
            @"995",
            @"996",
            @"998"];
    for (NSUInteger i=1; i<=MIN(3, [phone length]); i++) {
        NSString *code = [phone substringToIndex:i];
        if ([codes indexOfObject:code] != NSNotFound) {
            return code;
        }
    }
    if ([phone length] >= 3) { // Unknown country code. Consider first three digits to be country code.
        return [phone substringToIndex:3];
    }
    return nil;
};

@end