//
//  GameScoreGenerator.h
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/10/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameScoreGenerator : NSObject

+ (NSInteger) getScore:(NSString *)roundOutcome;

@end
