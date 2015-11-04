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
#import "Enums.h"

@interface TLGameOutcomeHandler ()

- (TLEventOutcome *) forEventInput:(TLEventInput *) input;

@end

@implementation TLGameOutcomeHandler

- (TLEventScore *) getRoundScore:(TLEventInput *)roundInput {
    return nil;
}

- (TLEventOutcome *) forEventInput:(TLEventInput *) input {
    return nil;
}

@end
