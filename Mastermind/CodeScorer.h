//
//  CodeScorer.h
//  Mastermind
//
//  Created by Kimberly Barnes on 9/6/14.
//  Copyright (c) 2014 DKMMBarnes, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CodeScorer : NSObject
- (id)initWithSecretCode:(NSString *)secretCode;

- (int)correctNumberOfColors:(NSString *)guess;
- (int)correctNumberOfLocations:(NSString *)guess;
@end
