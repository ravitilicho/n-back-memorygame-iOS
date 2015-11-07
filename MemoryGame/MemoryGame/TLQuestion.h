//
//  TLQuestion.h
//  MemoryGame
//
//  Created by Ravindar Katkuri on 04/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLArithmeticQuestion.h"
#import "TLGridQuestion.h"

@interface TLQuestion : NSObject

@property(nonatomic) NSInteger questionId;
@property(nonatomic) TLArithmeticQuestion *arithmeticQuestion;
@property(nonatomic) TLGridQuestion *gridQuestion;

- (NSInteger) arithmeticAnswer;
- (NSArray *) arithmeticAnswerOptions;
- (NSInteger) gridAnswer;

@end
