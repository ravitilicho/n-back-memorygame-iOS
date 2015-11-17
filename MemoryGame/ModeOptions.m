//
//  ModeOptions.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "ModeOptions.h"

@implementation ModeOptions

- (instancetype) initWithGameplayMode:(NSString *)gameplayMode gridRange:(NumberRange)gridRange nBackRange:(NumberRange)nBackRange {
    
    self = [super init];
    
    if (self != nil) {
        
        _gameplayMode = gameplayMode;
        _gridQuestionLengthRange = gridRange;
        _nBackCategoryRange = nBackRange;
        
    }
    
    return self;
    
}

@end
