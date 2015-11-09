//
//  NBackAnswersList.h
//  MemoryGame
//
//  Created by Ravindar Katkuri on 07/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLQuestion.h"

@interface NBackList : NSObject

// Adds at the top of list
- (void)addQuestion:(TLQuestion *)question;

// Returns whether this list size is equal to 'n' in n-back
- (BOOL)isNBackFull;
- (BOOL)isCurrentQuestionFullyAnswered;

- (BOOL)isCurrentArithmeticQuestionAnswered;
- (BOOL)isCurrentGridQuestionAnswered;

// Below 2 methods record the current question input state. 'Answered' below doesn't mean that it is 'correct'
// Passing questionId as defensive check (not to update the current question state for stale previous event
- (void)setCurrentArithmeticQuestionAnswered:(NSInteger)questionId;
- (void)setCurrentGridQuestionAnswered:(NSInteger)questionId;

// Returns arithmetic answer for n-back question, if any
// If question isn't found, returns -1
- (NSInteger)nBackArithmeticAnswer;
- (NSInteger)nBackGridAnswer;

- (void)makeEmpty;

@end
