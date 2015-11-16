//
//  EndlessModeHandler.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "TLEndlessModeHandler.h"
#import "TLGameLevelFlowHandler.h"

@interface TLEndlessModeHandler ()

@end

@implementation TLEndlessModeHandler

- (instancetype) initWithOutcomeHandler:(TLGameOutcomeHandler *)outcomeHandler {
    
    self = [super init];
    
    if (self != nil) {
        
        _outcomeHandler = outcomeHandler;
        _gameLevelFlowHandler = [[TLGameLevelFlowHandler alloc] initWithOutcomeHandler:outcomeHandler];
        
    }
    
    return self;
    
}

- (void) start {
    
}

- (void) pause {
    
}

- (void) resume {
    
}

- (BOOL) isPaused {
    
    return NO;
    
}

- (BOOL) eligibleForNextLevel {
    
    return [_gameLevelFlowHandler eligibleForNextLevel];
    
}

- (void) continueCurrentLevel {
    
    [_gameLevelFlowHandler continueCurrentLevel];
    
}

- (void) updateGameOptionsForNextLevel {
    
    [_gameLevelFlowHandler updateGameOptionsForNextLevel];
    
}

@end
