//
//  GameScoreGenerator.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/10/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "GameScoreGenerator.h"

@interface GameScoreGenerator ()

@property(nonatomic) NSDictionary *scoresDictionary;

@end

@implementation GameScoreGenerator

static NSString * const COLOR_QUESTION_PASS;
static NSString * const COLOR_QUESTION_FAIL;
static NSString * const ARITHMETIC_QUESTION_PASS;
static NSString * const ARITHMETIC_QUESTION_FAIL;

+ (NSDictionary *) scoresDictionary {
    return [[NSDictionary alloc] initWithObjectsAndKeys:
                                [NSNumber numberWithInt:3], COLOR_QUESTION_PASS,
                                [NSNumber numberWithInt:-1], COLOR_QUESTION_FAIL,
                                [NSNumber numberWithInt:2], ARITHMETIC_QUESTION_PASS,
                                [NSNumber numberWithInt:-1], ARITHMETIC_QUESTION_FAIL,
                                nil];
}

+ (NSInteger)getScore:(NSString *)roundOutcome {
    return [(NSNumber *)[self scoresDictionary][roundOutcome] integerValue];
}

@end
