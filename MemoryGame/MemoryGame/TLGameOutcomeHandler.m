//
//  TLGameOutcomeHandler.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/10/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "TLGameOutcomeHandler.h"
#import "TLEventInput.h"
#import "TLEventScore.h"
#import "TLGameScoreGenerator.h"
#import "NBackList.h"
#import "Enums.h"

@interface TLGameOutcomeHandler ()

@property (nonatomic) NSInteger gameTotalScore;
@property(nonatomic) TLGameScoreGenerator *scoreGenerator;
@property(nonatomic) NBackList *roundStates;

- (TLEventOutcome) outcome:(TLEventInput *)input;
- (void)updateCurrentRoundState:(TLEventInput *)input;

@end

@implementation TLGameOutcomeHandler

- (void)registerQuestion:(TLQuestion *)question {
    
    if (question) {
        
        [[self roundStates] addQuestion:question];
        
    }
    
}

- (TLEventScore *) getRoundScore:(TLEventInput *)eventInput {
    
    // 1. Update current RoundState
    [self updateCurrentRoundState:eventInput];
    
    // 2. Generate Outcome
    TLEventOutcome outcome = [self outcome:eventInput];
    
    // 3. Generate Score from Outcome
    TLEventScore *score = [[self scoreGenerator] generateScore:outcome];
    
    // 4. Update total score
    _gameTotalScore += [score score];
    
    return score;
}

- (TLEventOutcome) outcome:(TLEventInput *)input {
    
    TLEventType eventType = [input type];

    if ([_roundStates isNBackFull]) {
        
        NSInteger answer;
        // Find out if the n-back answer is correct
        if (eventType == ARITHMETIC) {
            
            answer = [_roundStates nBackArithmeticAnswer];
            
            if (answer == [input input]) {
                return ARITHMETIC_CORRECT;
            } else {
                return ARITHMETIC_INCORRECT;
            }
            
        } else if (eventType == COLOR_GRID) {
            
            answer = [_roundStates nBackGridAnswer];
            
            if (answer == [input input]) {
                return COLOR_GRID_CORRECT;
            } else {
                return COLOR_GRID_INCORRECT;
            }
            
        } else if (eventType == SKIP) {
            
            return SKIPPED;
            
        }
        
    }
    
    return UNDEFINED;
}

- (NBackList *)roundStates {
    if (_roundStates == nil) {
        _roundStates = [NBackList new];
    }
    return _roundStates;
}

- (void)reset {
    [_roundStates makeEmpty];
}

- (TLGameScoreGenerator *)scoreGenerator {
    if (_scoreGenerator == nil) {
        _scoreGenerator = [TLGameScoreGenerator new];
    }
    return _scoreGenerator;
}

- (BOOL) canStartNBackRound {
    return [_roundStates isNBackFull];
}

- (BOOL) canGoToNextRound {
    return ![self canStartNBackRound] || [_roundStates isCurrentQuestionFullyAnswered];
}

- (void)updateCurrentRoundState:(TLEventInput *)input {
    
    if ([input type] == ARITHMETIC) {
        
        [_roundStates setCurrentArithmeticQuestionAnswered:[input questionId]];
        
    } else if ([input type] == COLOR_GRID) {
        
        [_roundStates setCurrentGridQuestionAnswered:[input questionId]];
        
    } else if ([input type] == SKIP) {
        
        [_roundStates setCurrentArithmeticQuestionAnswered:[input questionId]];
        [_roundStates setCurrentGridQuestionAnswered:[input questionId]];
        
    }
    
}

- (BOOL) isCurrentRoundArithmeticQuestionAnswered {
    return [_roundStates isCurrentArithmeticQuestionAnswered];
}

- (BOOL) isCurrentRoundGridQuestionAnswered {
    return [_roundStates isCurrentGridQuestionAnswered];
}

- (NSInteger) gameTotalScore {
    return _gameTotalScore;
}


@end
