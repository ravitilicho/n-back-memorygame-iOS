//
//  RoundInput.h
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/10/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enums.h"

@interface TLEventInput : NSObject

@property(nonatomic) TLEventType type;
@property(nonatomic) NSInteger input;
@property(nonatomic) NSInteger questionId;

+ (TLEventInput *)forArithmeticInputEvent:(NSInteger) input questionId:(NSInteger) questionId;
+ (TLEventInput *)forColorGridInputEvent:(NSInteger) input questionId:(NSInteger) questionId;

@end
