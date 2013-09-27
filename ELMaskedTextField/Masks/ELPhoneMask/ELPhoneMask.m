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

- (BOOL)isValidInput:(NSString *)input {
    return [super isValidInput:input];
}

- (NSString *)cleanInput:(NSString *)input {
    NSString *cleanInput = [super cleanInput:input];
    return [cleanInput substringFromIndex:MIN([cleanInput length], [self.countryCode length])];
}

- (NSString *)apply:(NSString *)input {
    NSString *mask = self.defaultMask;
    NSRange countryCodeRange = [mask rangeOfString:@"#"]; // First # stands for country code
    if (self.countryCode) {
        mask = [mask stringByReplacingCharactersInRange:countryCodeRange withString:self.countryCode];
    } else {
        NSString *cleanInput = [self cleanInput:input];
        NSString *countryCode = [self countryCodeFromPhone:cleanInput];
        NSString *countryCodeMask = [@"" stringByPaddingToLength:[countryCode length] ?: [cleanInput length] + 1
                                                      withString:@"#"
                                                 startingAtIndex:0];
        mask = [mask stringByReplacingCharactersInRange:countryCodeRange withString:countryCodeMask];
    }
    self.inputMask = mask;
    return [super apply:input];
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