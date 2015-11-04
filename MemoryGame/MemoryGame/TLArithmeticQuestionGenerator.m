//
//  ArithmeticQuestionGenerator.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/10/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "TLArithmeticQuestionGenerator.h"
#import "TLArithmeticQuestion.h"

@implementation TLArithmeticQuestionGenerator

static NSInteger const MAX_OPERAND1 = 4;
static NSInteger const MAX_OPERAND2 = 5;

+ (TLArithmeticQuestion *)generate {
    
    NSInteger operand1, operand2;
    operand1 = [self generateOperand:0 max:MAX_OPERAND1];
    operand2 = [self generateOperand:0 max:MAX_OPERAND2];
    
    return [[TLArithmeticQuestion alloc] initWithOperands:operand1 operand2:operand2];
}

+ (NSInteger)generateOperand:(NSInteger)min max:(NSInteger)max {
    return (arc4random() % (max - min + 1)) + min;
}

@end
