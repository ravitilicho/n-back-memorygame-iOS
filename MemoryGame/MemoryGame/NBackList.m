//
//  NBackAnswersList.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 07/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "NBackList.h"

@interface NBackList ()

@property(nonatomic) NSMutableArray *questions;

- (BOOL)isQuestionAtTop:(NSInteger)questionId;

@end

@implementation NBackList

NSInteger gameCategory = 3;

- (void)addQuestion:(TLQuestion *)question {
    
    if (![self isQuestionAtTop:[question questionId]]) {
        [[self questions] insertObject:question atIndex:0];
        NSInteger maxListSize = gameCategory + 1;
        
        if ([_questions count] > maxListSize) {
            _questions = [[_questions subarrayWithRange:NSMakeRange(0, maxListSize - 1)] mutableCopy];
        }
    }
}

- (BOOL)isNBackFull {
    
    NSInteger maxListSize = gameCategory + 1;

    return [_questions count] >= maxListSize;
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

- (void)makeEmpty {
    _questions = [NSMutableArray new];
}

@end
