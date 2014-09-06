//
//  DKMMViewController.m
//  Mastermind
//
//  Created by Kimberly Barnes on 8/31/14.
//  Copyright (c) 2014 DKMMBarnes, LLC. All rights reserved.
//

#import "DKMMViewController.h"
#import "CodeMaker.h"
#import "CodeScorer.h"

@interface DKMMViewController ()
@property (strong, nonatomic) NSString *secretCode;
@property (string, nonatomic) CodeScorer *codeScorer;
@property (assign, nonatomic) NSInteger numberOfGuesses;
@property (assign, nonatomic) BOOL canGuess;

- (void)hideKeyboard;
- (void)initializeGame;

@end

@implementation DKMMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.guessTextField setDelegate:self];
    [self initializeGame];
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
        self.numberOfColorsLabel.text = [NSString stringWithFormat: @"%d", [self.codeScorer correctNumberOfColors:guess];
        self.numberOfLocationsLabel.text = [NSString stringWithFormat:@"%d", [self.codeScorer correctNumberOfLocations:guess];
    }
}

- (IBAction)iGiveUpButtonPressed:(UIButton *)sender {
    self.correctAnswerLabel.text = [NSString stringWithFormat:@"Correct answer: '%@'", self.secretCode];
    self.canGuess = NO;
}

-(void)hideKeyboard {
    [self.guessTextField resignFirstResponder];
}

- (void)initializeGame {
    self.secretCode = [[[CodeMaker alloc] init] generateCode];
    self.numberOfGuesses = 0;
    self.numberOfColorsLabel.text = @"?";
    self.numberOfLocationsLabel.text = @"?";
    self.winLabel.text = @"";
    self.numberOfGuessesLabel.text = @"";
    self.correctAnswerLabel.text = @"";
    self.canGuess = YES;
    self.codeScorer = [[CodeScorer alloc] initWithSecretCode:self.secretCode];
}
                                            
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [self hideKeyboard];
    return YES;
}
                                            
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
                                            
@end
