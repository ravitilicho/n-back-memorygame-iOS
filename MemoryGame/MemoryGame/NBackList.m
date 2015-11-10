//
//  NBackAnswersList.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 07/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "NBackList.h"
#import "TLRoundState.h"
#import "TLGameOptions.h"

@interface NBackList ()

@property(nonatomic) NSMutableArray *roundStates;

- (BOOL)isQuestionAtTop:(NSInteger)questionId;

@end

@implementation NBackList

- (void)addQuestion:(TLQuestion *)question {
    
    TLRoundState *roundState = [[TLRoundState alloc] initWithQuestion:question];
    
    if (![self isQuestionAtTop:[question questionId]]) {
        [[self roundStates] insertObject:roundState atIndex:0];
        NSInteger maxListSize = [self nBackCategory] + 1;
        
        if ([_roundStates count] > maxListSize) {
            _roundStates = [[_roundStates subarrayWithRange:NSMakeRange(0, maxListSize)] mutableCopy];
        }
    }
}

- (BOOL)isNBackFull {
    
    NSInteger maxListSize = [self nBackCategory] + 1;

    return [_roundStates count] >= maxListSize;
}

- (NSInteger)nBackArithmeticAnswer {

    if (![self isNBackFull]) {
        return -1;
    } else {
        return [[[_roundStates lastObject] question] arithmeticAnswer];
    }
}

- (NSInteger)nBackGridAnswer {
    
    if (![self isNBackFull]) {
        return -1;
    } else {
        return [[[_roundStates lastObject] question] gridAnswer];
    }
}

- (BOOL)isQuestionAtTop:(NSInteger)questionId {
    if ([_roundStates count] == 0) {
        return NO;
    } else {
        return [[[_roundStates firstObject] question] questionId] == questionId;
    }
}

- (NSMutableArray *)roundStates {
    
    if (_roundStates == nil) {
        _roundStates = [NSMutableArray new];
    }
    return _roundStates;
}

- (void)makeEmpty {
    _roundStates = [NSMutableArray new];
}

- (BOOL)isCurrentArithmeticQuestionAnswered {
    
    if ([[self roundStates] count] == 0) {
        return NO;
    } else {
        return [[[self roundStates] firstObject] arithmeticQuestionAnswered];
    }
}

- (BOOL)isCurrentGridQuestionAnswered {
    
    if ([[self roundStates] count] == 0) {
        return NO;
    } else {
        return [[[self roundStates] firstObject] gridQuestionAnswered];
    }
    
}

- (void)setCurrentArithmeticQuestionAnswered:(NSInteger)questionId {

    TLRoundState *currentRoundState = [_roundStates firstObject];
    
    // Update state only if the passed questoinId matches
    if ([[currentRoundState question] questionId] == questionId) {
        
        [currentRoundState setArithmeticQuestionAnswered:YES];
        
    }
}

- (void)setCurrentGridQuestionAnswered:(NSInteger)questionId {
    
    TLRoundState *currentRoundState = [_roundStates firstObject];
    
    // Update state only if the passed questoinId matches
    if ([[currentRoundState question] questionId] == questionId) {
        
        [currentRoundState setGridQuestionAnswered:YES];
        
    }

}

- (BOOL)isCurrentQuestionFullyAnswered {
    
    if ([_roundStates count] == 0)
        return NO;
    else {
        
        return [[_roundStates firstObject] isAllAnswered];
        
    }
}

- (NSInteger) nBackCategory {
    
    return [[[TLGameOptions alloc] initWithOptions] nBackCategory];
    
}

@end
