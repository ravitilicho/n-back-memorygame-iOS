//
//  QuestionsEngine.h
//  MemoryGame
//
//  Created by Ravindar Katkuri on 07/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLQuestion.h"
#import "TLGameOutcomeHandler.h"

@interface QuestionsEngine : NSObject

@property(nonatomic) TLGameOutcomeHandler *outcomeHandler;

- (TLQuestion *)getNextQuestion;

@end
