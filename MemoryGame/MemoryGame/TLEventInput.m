//
//  RoundInput.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/10/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "TLEventInput.h"

@implementation TLEventInput

+ (TLEventInput *)forArithmeticInputEvent:(NSInteger) input questionId:(NSInteger) questionId {
    TLEventInput *result = [TLEventInput new];
    [result setInput:input];
    [result setType:ARITHMETIC];
    [result setQuestionId:questionId];
    return result;
}
+ (TLEventInput *)forColorGridInputEvent:(NSInteger) input questionId:(NSInteger) questionId {
    TLEventInput *result = [TLEventInput new];
    [result setInput:input];
    [result setType:COLOR_GRID];
    [result setQuestionId:questionId];
    return result;
}

@end
