//
//  TLQuestion.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 04/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "TLQuestion.h"

@implementation TLQuestion

- (instancetype)initWithQuestionId:(NSInteger)questionId
                arithmeticQuestion:(TLArithmeticQuestion *)arithmeticQuestion
                      gridQuestion:(TLGridQuestion *)gridQuestion {
    self = [super init];
    
    if (self) {
        _questionId = questionId;
        _arithmeticQuestion = arithmeticQuestion;
        _gridQuestion = gridQuestion;
    }
    
    return self;
}

- (NSInteger) arithmeticAnswer {
    return [[self arithmeticQuestion] answer];
}

- (NSInteger) gridAnswer {
    return [[self gridQuestion] answer];
}

- (NSArray *) arithmeticAnswerOptions {
    NSArray *options = @[@0, @1, @2, @3, @4, @5, @6, @7, @8, @9];
    return options;
}

@end
