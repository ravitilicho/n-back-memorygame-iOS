//
//  QuestionsEngine.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 07/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "QuestionsEngine.h"
#import "TLArithmeticQuestionGenerator.h"
#import "TLGridQuestionGenerator.h"

@interface QuestionsEngine ()

- (NSInteger) generateNextQuestionId;

@end

@implementation QuestionsEngine

- (TLQuestion *)getNextQuestion {
    
    NSInteger questionId = [self generateNextQuestionId];
    
    TLArithmeticQuestion *arithmeticQn = [TLArithmeticQuestionGenerator generate];
    TLGridQuestion *gridQn = [TLGridQuestionGenerator generate];
    
    TLQuestion *question = [[TLQuestion alloc] initWithQuestionId:questionId
                                               arithmeticQuestion:arithmeticQn
                                                     gridQuestion:gridQn];
    
    // Register question with outcome handler
    [_outcomeHandler registerQuestion:question];
    
    return question;
}

- (TLGameOutcomeHandler *)outcomeHandler {
    if (_outcomeHandler == nil) {
        _outcomeHandler = [TLGameOutcomeHandler new];
    }
    return _outcomeHandler;
}

- (NSInteger) generateNextQuestionId {
    static NSInteger questionId = 1;
    
    questionId += 1;
    return questionId;
}



@end