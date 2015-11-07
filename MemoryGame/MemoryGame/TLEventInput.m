//
//  RoundInput.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/10/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "TLEventInput.h"

@implementation TLEventInput

+ (TLEventInput *)forArithmeticInputEvent:(NSInteger) input question:(TLQuestion *) question {
    TLEventInput *result = [TLEventInput new];
    [result setInput:input];
    [result setType:ARITHMETIC];
    [result setQuestion:question];
    return result;
}
+ (TLEventInput *)forColorGridInputEvent:(NSInteger) input question:(TLQuestion *) question {
    TLEventInput *result = [TLEventInput new];
    [result setInput:input];
    [result setType:COLOR_GRID];
    [result setQuestion:question];
    return result;
}

- (NSInteger)questionId {
    return [[self question] questionId];
}

@end
