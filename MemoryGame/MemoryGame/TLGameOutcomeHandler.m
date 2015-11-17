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
#import "TLGameLevelFlowHandler.h"
#import "TLEndlessModeHandler.h"
#import "TLSurvivalModeHandler.h"
#import "ModeHandlerProtocol.h"
#import "NBackList.h"
#import "Enums.h"

@interface TLGameOutcomeHandler ()

@property (nonatomic) ModeOptions *modeOptions;
@property (nonatomic) ViewController *viewController;
@property (nonatomic) SEL callback;

@property (nonatomic) NSInteger gameTotalScore;
@property(nonatomic) TLGameScoreGenerator *scoreGenerator;

@property (nonatomic) id<TLModeHandlerProtocol> modeHandler;

@property(nonatomic) NBackList *roundStates;

- (TLEventOutcome) outcome:(TLEventInput *)input;
- (void)updateCurrentRoundState:(TLEventInput *)input;

@end

@implementation TLGameOutcomeHandler

- (instancetype) initWithModeOptions:(ModeOptions *)modeOptions viewController:(ViewController *)viewController callback:(SEL)callback{
    
    self = [super init];
    
    if (self != nil) {
        
        _modeOptions = modeOptions;
        _viewController = viewController;
        _callback = callback;
        _gameTotalScore = 0;
        
    }
    
    return self;
}

- (void)registerQuestion:(TLQuestion *)question {
    
    if (question) {
        
        [[self roundStates] addQuestion:question];
        
    }
    
}

- (ModeOptions *)modeOptions {
    
    return _modeOptions;
    
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

- (BOOL) isEligibleForNextLevel {
    
    return [[self gameLevelFlowHandler] eligibleForNextLevel];
    
}

- (void) goToNextLevel {
    
    [_roundStates makeEmpty];
    [[self gameLevelFlowHandler] updateGameOptionsForNextLevel];
    
}

- (void) continueCurrentLevel {
    
    // After a popup, user most likely get distracted and can't remember the answers so emptying the n-back stack will enable him to start remembering from now
    [_roundStates makeEmpty];
    [[self gameLevelFlowHandler] continueCurrentLevel];
    
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

- (id<TLModeHandlerProtocol>) modeHandler {
    
    if (_modeHandler == nil) {
        
        if ([[_modeOptions gameplayMode] isEqualToString:@"SURVIVAL"]) {
            
            _modeHandler = [[TLSurvivalModeHandler alloc] initWithOutcomeHandler:self target:_viewController callback:_callback];
            
        } else { // Default
            
            _modeHandler = [[TLEndlessModeHandler alloc] initWithOutcomeHandler:self];
            
        }
        
    }
    
    return _modeHandler;
    
}

- (TLGameLevelFlowHandler *) gameLevelFlowHandler {
    
    return [[self modeHandler] gameLevelFlowHandler];
    
}

- (void) startGame {
    
    [_modeHandler start];
    
}
- (void) pauseGame {
    
    [_modeHandler pause];
    
}

- (BOOL) isPaused {
    
    return [_modeHandler isPaused];
    
}
- (void) stopGame {
    
    [self pauseGame];
    
}
- (void) resumeGame {
    
    [_modeHandler resume];
    
}

@end
