//
//  TLGameOutcomeHandler.h
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/10/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLEventScore.h"
#import "TLEventInput.h"

@interface TLGameOutcomeHandler : NSObject

- (TLEventScore *) getRoundScore:(TLEventInput *)roundInput;

@end
