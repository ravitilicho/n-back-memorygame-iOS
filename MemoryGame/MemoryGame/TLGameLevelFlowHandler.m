//
//  TLGameLevelFlowHandler.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 10/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "TLGameLevelFlowHandler.h"
#import "TLGameOptions.h"

@interface TLGameLevelFlowHandler()

@property (nonatomic) NSInteger minScoreForNextLevelEligibility;
@property (nonatomic) TLGameOutcomeHandler *outcomeHandler;

@end

@implementation TLGameLevelFlowHandler

- (instancetype) initWithOutcomeHandler:(TLGameOutcomeHandler *)outcomeHandler {
    
    self = [super init];
    
    if (self != nil) {
        
        self.outcomeHandler = outcomeHandler;
        _minScoreForNextLevelEligibility = 300;
        
    }
    
    return self;
    
}

- (BOOL) eligibleForNextLevel {
    
    return [_outcomeHandler gameTotalScore] >= _minScoreForNextLevelEligibility;
    
}

- (void) continueCurrentLevel {
    
    if ([self eligibleForNextLevel]) {
        
        // Update min score limit to higher value, to enable user play current level for some more time
        _minScoreForNextLevelEligibility += 600;
        
    }
    
}

- (void) updateGameOptionsForNextLevel {
    
    if ([self eligibleForNextLevel]) {
        
        TLGameOptions *gameOptions = [self gameOptions];
        
        [gameOptions setNBackCategory:[self nextNBackCategory:gameOptions]];
        [gameOptions setGridQuestionSize:[self nextGridQuestionSize:gameOptions]];
        
    }
    
}

- (NSInteger) nextNBackCategory:(TLGameOptions *)gameOptions {
    
    Point gridQuestionSize = [gameOptions gridQuestionSize];
    NSInteger currentNBackCategory = [gameOptions nBackCategory];
    
    if ([[self gameOptions] isMaxNBackCategory:currentNBackCategory]) {
        
        // User cleared all the rounds! => Nothing to do: let him continue the current round itself!!
        return currentNBackCategory;
        
    } else {
        
        if ([gameOptions isMaxGridQuestionSize:gridQuestionSize]) {
            
            return currentNBackCategory + 1;
            
        } else {
            
            return currentNBackCategory;
            
        }
        
    }
    
}

- (Point) nextGridQuestionSize:(TLGameOptions *)gameOptions {
    
    NSInteger currentNBackCategory = [gameOptions nBackCategory];
    Point gridQuestionSize = [gameOptions gridQuestionSize];
    
    if ([gameOptions isMaxGridQuestionSize:gridQuestionSize]) {
        
        if ([gameOptions isMaxNBackCategory:currentNBackCategory]) {
            // User cleared all the rounds! => Nothing to do: let him continue the current round itself!!

            return gridQuestionSize;
            
        } else {
            
            return [gameOptions minGridQuestionSize];
            
        }
        
    } else {
        
        Point nextGridQuestionSize = {gridQuestionSize.h + 1, gridQuestionSize.h + 1};
        return nextGridQuestionSize;
        
    }
    
    
}

- (TLGameOptions *) gameOptions {
    
    return [[TLGameOptions alloc] initWithOptions];
    
}

@end
