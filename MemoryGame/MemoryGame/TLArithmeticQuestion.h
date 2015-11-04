//
//  ArithmeticQuestion.h
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/10/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLArithmeticQuestion : NSObject

@property(nonatomic) NSInteger operand1;
@property(nonatomic) NSInteger operand2;
@property(nonatomic) NSString *operation;

- (NSString *)questionString;
- (instancetype)initWithOperands:(NSInteger)operand1 operand2: (NSInteger)operand2;

- (NSInteger)answer;
- (NSString *)answerString;

@end
