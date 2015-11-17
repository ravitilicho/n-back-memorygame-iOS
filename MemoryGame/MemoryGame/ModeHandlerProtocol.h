//
//  ModeHandlerProtocol.h
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLGameOutcomeHandler.h"
#import "TLGameLevelFlowHandler.h"

@protocol TLModeHandlerProtocol <NSObject>

- (void) start;
- (void) pause;
- (void) resume;
- (BOOL) isPaused;

- (TLGameLevelFlowHandler *)gameLevelFlowHandler;

@end
