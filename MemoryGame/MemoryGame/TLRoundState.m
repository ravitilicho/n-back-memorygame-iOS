//
//  RoundState.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 09/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "TLRoundState.h"

@implementation TLRoundState

- (instancetype) initWithQuestion:(TLQuestion *)question {
    
    self = [TLRoundState new];
    
    if (self) {
        [self setQuestion:question];
        [self setArithmeticQuestionAnswered:NO];
        [self setGridQuestionAnswered:NO];
    }
    
    return self;
}

- (BOOL) isAllAnswered {
    return _arithmeticQuestionAnswered && _gridQuestionAnswered;
}

@end
