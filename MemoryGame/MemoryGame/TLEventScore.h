//
//  RoundScore.h
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/10/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enums.h"

@interface TLEventScore : NSObject

@property(nonatomic) TLEventOutcome outcome;
@property(nonatomic) NSInteger score;
@property (nonatomic) NSInteger timeRemainingOffset;

- (instancetype) initWithOutcome:(TLEventOutcome)outcome score:(NSInteger)score timeRemaininOffset:(NSInteger)timeRemainingOffset;

@end
