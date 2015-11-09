//
//  RoundState.h
//  MemoryGame
//
//  Created by Ravindar Katkuri on 09/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLQuestion.h"

@interface TLRoundState : NSObject

@property (nonatomic) BOOL arithmeticQuestionAnswered;
@property (nonatomic) BOOL gridQuestionAnswered;
@property (nonatomic) TLQuestion *question;

- (instancetype) initWithQuestion:(TLQuestion *)question;

- (BOOL) isAllAnswered;

@end
