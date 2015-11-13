//
//  GameOptions.h
//  MemoryGame
//
//  Created by Ravindar Katkuri on 10/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enums.h"

@interface TLGameOptions : NSObject

- (instancetype) initWithOptions;

- (NSInteger) nBackCategory;
- (BOOL) isMaxNBackCategory:(NSInteger)category;
- (NSInteger) minNBackCategory;
- (NSInteger) maxNBackCategory;
- (void) setNBackCategory:(NSInteger)category;

- (Point) gridQuestionSize;
- (BOOL) isMaxGridQuestionSize:(Point)size;
- (Point) minGridQuestionSize;
- (void) setGridQuestionSize:(Point)size;

- (NSString *) gameplayMode;
- (void) setGameplayMode:(NSString *)mode;

@end
