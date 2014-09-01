//
//  DKMMViewController.h
//  Mastermind
//
//  Created by Kimberly Barnes on 8/31/14.
//  Copyright (c) 2014 DKMMBarnes, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKMMViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *numberOfColorsLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberOfLocationsLabel;
@property (strong, nonatomic) IBOutlet UILabel *correctAnswerLabel;
@property (strong, nonatomic) IBOutlet UITextField *guessTextField;
@property (strong, nonatomic) IBOutlet UILabel *winLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberOfGuessesLabel;

- (IBAction)startOverButtonPressed:(id)sender;
- (IBAction)guessButtonPressed:(UIButton *)sender;
- (IBAction)iGiveUpButtonPressed:(UIButton *)sender;

@end