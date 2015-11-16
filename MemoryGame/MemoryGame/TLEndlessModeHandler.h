//
//  EndlessModeHandler.h
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModeHandlerProtocol.h"
#import "TLGameLevelFlowHandler.h"

@interface TLEndlessModeHandler : NSObject <TLModeHandlerProtocol>

- (instancetype) initWithOutcomeHandler:(TLGameOutcomeHandler *)outcomeHandler;

- (BOOL) eligibleForNextLevel;
- (void) continueCurrentLevel;
- (void) updateGameOptionsForNextLevel;

@end
