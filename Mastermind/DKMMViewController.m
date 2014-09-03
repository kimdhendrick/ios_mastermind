//
//  DKMMViewController.m
//  Mastermind
//
//  Created by Kimberly Barnes on 8/31/14.
//  Copyright (c) 2014 DKMMBarnes, LLC. All rights reserved.
//

#import "DKMMViewController.h"
#import "CodeMaker.h"

@interface DKMMViewController ()
@property (strong, nonatomic) NSString *secretCode;
@property (assign, nonatomic) NSInteger numberOfGuesses;
@property (assign, nonatomic) BOOL canGuess;

- (int)correctNumberOfColors:(NSString *)guess;
- (int)correctNumberOfLocations:(NSString *)guess;
- (NSString *)generateCode;
- (void)hideKeyboard;
- (void)initializeGame;
- (NSString *)extractExactCodeMatches:(NSString *)guess;
- (NSString *)extractExactGuessMatches:(NSString *)guess;

@end

@implementation DKMMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.guessTextField setDelegate:self];
    [self initializeGame];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [self hideKeyboard];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startOverButtonPressed:(id)sender {
    [self initializeGame];
}

- (IBAction)guessButtonPressed:(UIButton *)sender {
    if (!self.canGuess) {
        return;
    }
    
    [self hideKeyboard];
    NSString *guess = [[NSString stringWithString:self.guessTextField.text] uppercaseString];
    
    self.numberOfGuesses++;
    
    if ([self.secretCode isEqualToString:guess]) {
        self.winLabel.text = @"You Won!!";
        self.numberOfGuessesLabel.text = [NSString stringWithFormat:@"It took you %ld guesses", (long)self.numberOfGuesses];
        self.canGuess = NO;
    } else if (self.numberOfGuesses == 10) {
        self.winLabel.text = @"You Lose :-(";
        self.correctAnswerLabel.text = [NSString stringWithFormat:@"Correct answer: '%@'", self.secretCode];
        self.canGuess = NO;
    } else {
        self.numberOfColorsLabel.text = [NSString stringWithFormat: @"%d", [self correctNumberOfColors:guess]];
        self.numberOfLocationsLabel.text = [NSString stringWithFormat:@"%d", [self correctNumberOfLocations:guess]];
    }
}

- (IBAction)iGiveUpButtonPressed:(UIButton *)sender {
    self.correctAnswerLabel.text = [NSString stringWithFormat:@"Correct answer: '%@'", self.secretCode];
    self.canGuess = NO;
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

-(NSString *)generateCode {
    return [[[CodeMaker alloc] init] generateCode];
}

-(void)hideKeyboard {
    [self.guessTextField resignFirstResponder];
}

- (void)initializeGame {
    self.secretCode = [self generateCode];
    self.numberOfGuesses = 0;
    self.numberOfColorsLabel.text = @"?";
    self.numberOfLocationsLabel.text = @"?";
    self.winLabel.text = @"";
    self.numberOfGuessesLabel.text = @"";
    self.correctAnswerLabel.text = @"";
    self.canGuess = YES;
}


@end
