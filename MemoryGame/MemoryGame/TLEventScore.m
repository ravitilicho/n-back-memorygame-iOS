//
//  RoundScore.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/10/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "TLEventScore.h"

@implementation TLEventScore

- (instancetype) initWithOutcome:(TLEventOutcome)outcome score:(NSInteger)score timeRemaininOffset:(NSInteger)timeRemainingOffset {
    
    self = [super init];
    
    if (self) {
        
        self.outcome = outcome;
        self.score = score;
        self.timeRemainingOffset = timeRemainingOffset;
    }
    
    return self;
    
}

@end
