//
//  RoundInput.h
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/10/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLQuestion.h"
#import "Enums.h"

@interface TLEventInput : NSObject

@property(nonatomic) TLEventType type;
@property(nonatomic) NSInteger input;
@property(nonatomic) TLQuestion* question;

+ (TLEventInput *)forArithmeticInputEvent:(NSInteger) input question:(TLQuestion *) question;
+ (TLEventInput *)forColorGridInputEvent:(NSInteger) input question:(TLQuestion *) question;

- (NSInteger)questionId;
@end
