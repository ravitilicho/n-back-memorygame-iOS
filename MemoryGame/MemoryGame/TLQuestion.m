//
//  TLQuestion.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 04/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "TLQuestion.h"

@interface TLQuestion ()

- (NSInteger) generateNextQuestionId;

@end

@implementation TLQuestion

- (NSInteger) generateNextQuestionId {
    static NSInteger questionId = 1;
    
    questionId += 1;
    return questionId;
}

@end
