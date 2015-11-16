//
//  TLGameOutcomeHandler.h
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/10/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "TLEventScore.h"
#import "TLEventInput.h"
#import "ModeOptions.h"

@interface TLGameOutcomeHandler : NSObject

- (instancetype) initWithModeOptions:(ModeOptions *)modeOptions viewController:(ViewController *)viewController callback:(SEL)callback;

- (void)registerQuestion:(TLQuestion *)question;
- (TLEventScore *) getRoundScore:(TLEventInput *)eventInput;

- (BOOL) isCurrentRoundArithmeticQuestionAnswered;
- (BOOL) isCurrentRoundGridQuestionAnswered;
- (BOOL)canStartNBackRound;

// YES when user answered both arithmetic and grid question
- (BOOL) canGoToNextRound;

// Game Level related
- (BOOL) isEligibleForNextLevel;
- (void) goToNextLevel;
- (void) continueCurrentLevel;


// Invoked when some game options change
- (void)reset;

- (NSInteger) gameTotalScore;

@end
