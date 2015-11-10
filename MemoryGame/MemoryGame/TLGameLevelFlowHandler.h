//
//  TLGameLevelFlowHandler.h
//  MemoryGame
//
//  Created by Ravindar Katkuri on 10/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLEventScore.h"
#import "TLGameOutcomeHandler.h"

@interface TLGameLevelFlowHandler : NSObject

- (instancetype) initWithOutcomeHandler:(TLGameOutcomeHandler *)outcomeHandler;

- (BOOL) eligibleForNextLevel;
- (void) continueCurrentLevel;

- (void) updateGameOptionsForNextLevel;

@end
