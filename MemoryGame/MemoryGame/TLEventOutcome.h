//
//  EventOutcome.h
//  MemoryGame
//
//  Created by Ravindar Katkuri on 03/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enums.h"
#import "TLEventInput.h"

@interface TLEventOutcome : NSObject

@property(nonatomic) EventOutcomeType* type;

+ (TLEventOutcome *) forEventInput:(EventInput *) input;

@end
