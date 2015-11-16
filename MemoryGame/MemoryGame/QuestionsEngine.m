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

static NSInteger questionId = 1;

- (instancetype) initWithOutcomeHandler:(TLGameOutcomeHandler *)outcomeHandler {
    
    self = [super init];
    
    if (self != nil) {
        
        _outcomeHandler = outcomeHandler;
        
    }
    
    return self;
    
}

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

- (void)reset {
    
    questionId = 1;
    [_outcomeHandler reset];
    
}

- (NSInteger) generateNextQuestionId {
    
    questionId += 1;
    return questionId;
}



@end
