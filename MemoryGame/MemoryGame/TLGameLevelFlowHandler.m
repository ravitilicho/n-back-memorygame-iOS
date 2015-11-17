//
//  TLGameLevelFlowHandler.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 10/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "TLGameLevelFlowHandler.h"
#import "TLGameOptions.h"
#import "ModeOptions.h"
#import "TLNumberRangeUtil.h"
#import "Enums.h"

@interface TLGameLevelFlowHandler()

@property (nonatomic) NSInteger minScoreForNextLevelEligibility;

@property (nonatomic) TLGameOutcomeHandler *outcomeHandler;

@property (nonatomic) ModeOptions *modeOptions;
@property (nonatomic) NumberRange nBackCategoryRange;
@property (nonatomic) NumberRange gridLengthRange;

@property (nonatomic) NSInteger currentNBackCategory;
@property (nonatomic) NSInteger currentGridWidth;

@end

@implementation TLGameLevelFlowHandler

const NSInteger startingScore = 50;
const NSInteger scoreOffsetWhenContinuingCurrentLevel = 100;
const NSInteger scoreOffsetWhenMovingToNextLevel = 100;

- (instancetype) initWithOutcomeHandler:(TLGameOutcomeHandler *)outcomeHandler {
    
    self = [super init];
    
    if (self != nil) {
        
        self.outcomeHandler = outcomeHandler;
        [self initGameOptionRanges];

        _minScoreForNextLevelEligibility = startingScore;
        
    }
    
    return self;
    
}

- (BOOL) eligibleForNextLevel {
    
    return [_outcomeHandler gameTotalScore] >= _minScoreForNextLevelEligibility;
    
}

- (void) continueCurrentLevel {
    
    if ([self eligibleForNextLevel]) {
        
        // Update min score limit to higher value, to enable user play current level for some more time
        _minScoreForNextLevelEligibility += scoreOffsetWhenContinuingCurrentLevel;
        
    }
    
}

- (void) updateGameOptionsForNextLevel {
    
    if ([self eligibleForNextLevel]) {
        
        _minScoreForNextLevelEligibility += scoreOffsetWhenMovingToNextLevel;
        
        TLGameOptions *gameOptions = [self gameOptions];
        
        [gameOptions setNBackCategory:[self nextNBackCategory]];
        [gameOptions setGridQuestionSize:[self nextGridQuestionSize]];
        
    }
    
}

- (NSInteger) nextNBackCategory {
    
    if ([TLNumberRangeUtil isMaxInRange:_currentNBackCategory range:_nBackCategoryRange]) {
        
        // User cleared all the rounds! => Nothing to do: let him continue the current round itself!!
        return _currentNBackCategory;
        
    } else {
        
        if ([TLNumberRangeUtil isMaxInRange:_currentGridWidth range:_gridLengthRange]) {
            
            return ++_currentNBackCategory;
            
        } else {
            
            return _currentNBackCategory;
            
        }
        
    }
    
}

- (Point) nextGridQuestionSize {
    
    Point nextGridQuestionSize;
    NSInteger nextSize;
    
    if ([TLNumberRangeUtil isMaxInRange:_currentGridWidth range:_gridLengthRange]) {
        
        nextSize = [TLNumberRangeUtil minItem:_gridLengthRange];
        
    } else {
        
        nextSize = ++_currentGridWidth;
        
    }
    
    nextGridQuestionSize.h = nextSize;
    nextGridQuestionSize.v = nextSize;

    [[self gameOptions] setGridQuestionSize:nextGridQuestionSize];
    return nextGridQuestionSize;
    
}

- (TLGameOptions *) gameOptions {
    
    return [[TLGameOptions alloc] initWithOptions];
    
}

- (NSInteger) startingScore {
    
    return 50 * [[self gameOptions] gridQuestionSize].h + (100 * ([[self gameOptions] maxNBackCategory] - [[self gameOptions] nBackCategory] + 1));
    
}

- (ModeOptions *)modeOptions {
    
    return [_outcomeHandler modeOptions];
    
}

- (void) initGameOptionRanges {
    
    // TODO: Validate later
    
    _nBackCategoryRange = [[self modeOptions] nBackCategoryRange];
    _gridLengthRange = [[self modeOptions] gridQuestionLengthRange];
    
    _currentNBackCategory = _nBackCategoryRange.left;
    [[self gameOptions] setNBackCategory:_currentNBackCategory];
    
    _currentGridWidth = _gridLengthRange.left;
    Point size = {_currentGridWidth, _currentGridWidth};
    
    [[self gameOptions] setGridQuestionSize:size];
    
}

@end
