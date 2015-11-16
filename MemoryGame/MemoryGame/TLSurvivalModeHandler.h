//
//  TLSurvivalModeHandler.h
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLEndlessModeHandler.h"

@interface TLSurvivalModeHandler : TLEndlessModeHandler

- (instancetype) initWithOutcomeHandler:(TLGameOutcomeHandler *)outcomeHandler target:(id)target callback:(SEL)callback;

@end
