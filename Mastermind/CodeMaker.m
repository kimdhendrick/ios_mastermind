//
//  CodeMaker.m
//  Mastermind
//
//  Created by Kimberly Barnes on 9/3/14.
//  Copyright (c) 2014 DKMMBarnes, LLC. All rights reserved.
//

#import "CodeMaker.h"

@implementation CodeMaker

-(NSString *)generateCode {
    NSString *possibilities = @"RGBY";
    NSMutableString *code = [NSMutableString stringWithCapacity:4];
    for (NSUInteger i = 0U; i < 4; i++) {
        u_int32_t randomIndex = arc4random() % [possibilities length];
        unichar randomCharacter = [possibilities characterAtIndex:randomIndex];
        [code appendFormat:@"%C", randomCharacter];
    }
    return code;
}

@end
