//
//  RoundScore.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/10/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "TLEventScore.h"

@implementation TLEventScore

- (instancetype) initWithOutcome:(TLEventOutcome)outcome score:(NSInteger)score {
    self = [super init];
    
    if (self) {
        self.outcome = outcome;
        self.score = score;
    }
    
    return self;
}

+ (TLEventScore *) fromEventOutcome:(TLEventOutcome)outcome scoresMap:(NSDictionary *)scoresMap {
    NSNumber *score = [scoresMap objectForKey:[NSNumber numberWithInt:outcome]];
    if (score == nil) {
        return [[TLEventScore alloc] initWithOutcome:outcome score:0];
    } else {
        return [[TLEventScore alloc] initWithOutcome:outcome score:[score integerValue]];
    }
}

@end
