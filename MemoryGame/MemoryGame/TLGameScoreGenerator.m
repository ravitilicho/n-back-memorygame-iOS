//
//  GameScoreGenerator.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/10/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "TLGameScoreGenerator.h"
#import "TLEventScore.h"

@interface TLGameScoreGenerator ()

@property(nonatomic) NSDictionary *scoresDictionary;

@end

@implementation TLGameScoreGenerator

- (NSDictionary *) scoresDictionary {
    return [[NSDictionary alloc] initWithObjectsAndKeys:
                                [NSNumber numberWithInt:2], [NSNumber numberWithInt:COLOR_GRID_CORRECT],
                                [NSNumber numberWithInt:-1], [NSNumber numberWithInt:COLOR_GRID_INCORRECT],
                                [NSNumber numberWithInt:4], [NSNumber numberWithInt:ARITHMETIC_CORRECT],
                                [NSNumber numberWithInt:-1], [NSNumber numberWithInt:ARITHMETIC_INCORRECT],
                                [NSNumber numberWithInt:-3], [NSNumber numberWithInt:SKIPPED],
                                nil];
}

- (TLEventScore *) generateScore:(TLEventOutcome)eventOutcome {
    NSNumber *outcomeNumber = [NSNumber numberWithInt:eventOutcome];
    NSInteger score = [(NSNumber *)[self scoresDictionary][outcomeNumber] integerValue];
    
    return [[TLEventScore alloc] initWithOutcome:eventOutcome score:score];
}

@end
