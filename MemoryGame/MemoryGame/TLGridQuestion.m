//
//  TLGridQuestion.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 04/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "TLGridQuestion.h"

@implementation TLGridQuestion

- (instancetype) initWithGridSize:(Point)gridSize gridNumToHighlight:(NSInteger)gridNumToHighlight {
    self = [super init];
    
    if (self) {
        self.gridSize = gridSize;
        self.gridNumToHighlight = gridNumToHighlight;
    }
    
    return self;
}

- (NSInteger) answer {
    return [self gridNumToHighlight];
}

@end
