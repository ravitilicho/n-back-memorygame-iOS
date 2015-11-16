//
//  TLSurvivalModeHandler.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "TLSurvivalModeHandler.h"

@interface TLSurvivalModeHandler ()

@property (nonatomic) NSTimer *timer;
@property (nonatomic) id target;
@property (nonatomic) SEL callback;
@property (nonatomic) BOOL isPaused;

@end

@implementation TLSurvivalModeHandler

- (instancetype) initWithOutcomeHandler:(TLGameOutcomeHandler *)outcomeHandler target:(id)target callback:(SEL)callback {
    
    self = [super init];
    
    if (self != nil) {
        
        self.outcomeHandler = outcomeHandler;
        self.gameLevelFlowHandler = [[TLGameLevelFlowHandler alloc] initWithOutcomeHandler:outcomeHandler];
        _callback = callback;
        _target = target;
        _isPaused = YES;
        
    }
    
    return self;
    
}

- (void) start {
    
    if ([self isPaused]) {
        
        [self initTimer];
        
    }
    
    _isPaused = NO;
    [_timer fire];
    
}

- (void) pause {
    
    [self stopTimer];
    _isPaused = YES;
    
}

- (void) resume {

    [self start];
    
}

- (BOOL) isPaused {
    
    return _isPaused;
    
}

- (void) initTimer {
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:_target selector:_callback userInfo:nil repeats:YES];
    
}

- (void) stopTimer {
    
    [_timer invalidate];
    _isPaused = YES;
    
}


@end
