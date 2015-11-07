//
//  NBackAnswersList.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 07/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "NBackAnswersList.h"

@interface NBackAnswersList ()

@property(nonatomic) NSMutableArray *questions;

- (BOOL)isQuestionAtTop:(NSInteger)questionId;

@end

@implementation NBackAnswersList

- (void)addQuestion:(TLQuestion *)question {
    
    if (![self isQuestionAtTop:[question questionId]]) {
        [_questions insertObject:question atIndex:0];
        NSInteger gameCategory = 1;
        NSInteger maxListSize = gameCategory + 1;
        
        if ([_questions count] > maxListSize) {
            _questions = [[_questions subarrayWithRange:NSMakeRange(0, maxListSize - 1)] mutableCopy];
        }
    }
}

- (BOOL)isNBackFull {
    
    NSInteger gameCategory = 1;
    NSInteger maxListSize = gameCategory + 1;

    return maxListSize >= [_questions count];
}

- (NSInteger)nBackArithmeticAnswer {

    if (![self isNBackFull]) {
        return -1;
    } else {
        return [[_questions lastObject] arithmeticAnswer];
    }
}

- (NSInteger)nBackGridAnswer {
    
    if (![self isNBackFull]) {
        return -1;
    } else {
        return [[_questions lastObject] gridAnswer];
    }
}

- (BOOL)isQuestionAtTop:(NSInteger)questionId {
    if ([_questions count] == 0) {
        return NO;
    } else {
        return [[_questions firstObject] questionId] == questionId;
    }
}

- (NSMutableArray *)questions {
    
    if (_questions == nil) {
        _questions = [NSMutableArray new];
    }
    return _questions;
}

@end
