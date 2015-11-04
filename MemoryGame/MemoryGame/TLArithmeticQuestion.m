//
//  ArithmeticQuestion.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/10/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "TLArithmeticQuestion.h"

@implementation TLArithmeticQuestion

-(NSString *)questionString {
    
    return [NSString stringWithFormat:@"%ld %@ %ld", (long)_operand1, @"+", (long)_operand2];
}

- (instancetype)initWithOperands:(NSInteger)operand1 operand2: (NSInteger)operand2 {
    
    self = [TLArithmeticQuestion new];
    
    if (self) {
        self.operand1 = operand1;
        self.operand2 = operand2;
    }
    
    return self;
}

- (NSInteger)answer {
    
    return _operand1 + _operand2;
}

- (NSString *)answerString {
    return [NSString stringWithFormat:@"%ld", (long)[self answer]];
}
@end
