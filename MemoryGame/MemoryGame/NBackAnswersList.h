//
//  NBackAnswersList.h
//  MemoryGame
//
//  Created by Ravindar Katkuri on 07/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLQuestion.h"

@interface NBackAnswersList : NSObject

// Adds at the top of list
- (void)addQuestion:(TLQuestion *)question;

// Returns whether this list size is equal to 'n' in n-back
- (BOOL)isNBackFull;

// Returns arithmetic answer for n-back question, if any
// If question isn't found, returns -1
- (NSInteger)nBackArithmeticAnswer;
- (NSInteger)nBackGridAnswer;

@end
