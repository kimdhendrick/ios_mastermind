//
//  CodeScorer.m
//  Mastermind
//
//  Created by Kimberly Barnes on 9/6/14.
//  Copyright (c) 2014 DKMMBarnes, LLC. All rights reserved.
//

#import "CodeScorer.h"

@interface CodeScorer ()

@property (strong, nonatomic) NSString *secretCode;

- (NSString *)extractExactCodeMatches:(NSString *)guess;
- (NSString *)extractExactGuessMatches:(NSString *)guess;

@end

@implementation CodeScorer

- (id)initWithSecretCode:(NSString *)secretCode {
    self.secretCode = secretCode;
    return [super init];
}

- (int)correctNumberOfColors:(NSString *)guess {
    NSMutableString *copyOfCode = [NSMutableString stringWithString:[self extractExactCodeMatches:guess]];
    NSMutableString *copyOfGuess = [NSMutableString stringWithString:[self extractExactGuessMatches:guess]];
    int matches = 0;
    
    for(int i=0; i<copyOfGuess.length; i++) {
        
        NSString *guessCharacter = [NSString stringWithFormat:@"%c", [copyOfGuess characterAtIndex:i]];
        NSRange matchingRange = [copyOfCode rangeOfString: guessCharacter];
        
        if (matchingRange.location != NSNotFound) {
            matches++;
            [copyOfCode deleteCharactersInRange: matchingRange];
        }
    }
    return matches;
}

- (NSString *)extractExactCodeMatches:(NSString *)guess {
    NSMutableString *nonExactCodeMatches = [NSMutableString stringWithString:@""];
    
    for(int i=0; i<guess.length; i++) {
        if ([guess characterAtIndex:i] != [self.secretCode characterAtIndex:i]) {
            [nonExactCodeMatches appendString:[NSString stringWithFormat:@"%c", [self.secretCode characterAtIndex:i]]];
        }
    }
    return nonExactCodeMatches;
}

- (NSString *)extractExactGuessMatches:(NSString *)guess {
    NSMutableString *nonExactGuessMatches = [NSMutableString stringWithString:@""];
    
    for(int i=0; i<guess.length; i++) {
        if ([guess characterAtIndex:i] != [self.secretCode characterAtIndex:i]) {
            [nonExactGuessMatches appendString:[NSString stringWithFormat:@"%c", [guess characterAtIndex:i]]];
        }
    }
    return nonExactGuessMatches;
}

- (int)correctNumberOfLocations:(NSString *)guess {
    return 4 - [self extractExactCodeMatches:guess].length;
}

@end
