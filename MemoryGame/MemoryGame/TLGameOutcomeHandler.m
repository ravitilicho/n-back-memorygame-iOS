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
#import "NBackAnswersList.h"
#import "Enums.h"

@interface TLGameOutcomeHandler ()

@property(nonatomic) TLGameScoreGenerator *scoreGenerator;
@property(nonatomic) NBackAnswersList *answersList;

- (TLEventOutcome) outcome:(TLEventInput *)input;

@end

@implementation TLGameOutcomeHandler

- (TLEventScore *) getRoundScore:(TLEventInput *)eventInput {
    
    // 1. Generate Outcome
    TLEventOutcome outcome = [self outcome:eventInput];
    
    // 2. Generate Score from Outcome
    TLEventScore *score = [[self scoreGenerator] generateScore:outcome];
    
    return score;
}

- (TLEventOutcome) outcome:(TLEventInput *)input {
    
    TLEventType eventType = [input type];

    if ([_answersList isNBackFull]) {
        
        NSInteger answer;
        // Find out if the n-back answer is correct
        if (eventType == ARITHMETIC) {
            
            answer = [_answersList nBackArithmeticAnswer];
            
            if (answer == [input input]) {
                return ARITHMETIC_CORRECT;
            } else {
                return ARITHMETIC_INCORRECT;
            }
            
        } else if (eventType == COLOR_GRID) {
            
            answer = [_answersList nBackGridAnswer];
            
            if (answer == [input input]) {
                return COLOR_GRID_CORRECT;
            } else {
                return COLOR_GRID_INCORRECT;
            }
            
        }
        
    }
    
    return UNDEFINED;
}

- (TLGameScoreGenerator *)scoreGenerator {
    if (_scoreGenerator == nil) {
        _scoreGenerator = [TLGameScoreGenerator new];
    }
    return _scoreGenerator;
}

@end
