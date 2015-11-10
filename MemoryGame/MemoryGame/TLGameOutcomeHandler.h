//
//  TLGameOutcomeHandler.h
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/10/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLEventScore.h"
#import "TLEventInput.h"

@interface TLGameOutcomeHandler : NSObject

- (void)registerQuestion:(TLQuestion *)question;
- (TLEventScore *) getRoundScore:(TLEventInput *)eventInput;

- (BOOL) isCurrentRoundArithmeticQuestionAnswered;
- (BOOL) isCurrentRoundGridQuestionAnswered;

- (BOOL)canStartNBackRound;

// YES when user answered both arithmetic and grid question
- (BOOL) canGoToNextRound;

// Invoked when some game options change
- (void)reset;

- (NSInteger) gameTotalScore;

@end
