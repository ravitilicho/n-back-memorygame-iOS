//
//  TLColorQuestionGenerator.m
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/10/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import "TLGridQuestionGenerator.h"

@interface TLGridQuestionGenerator ()

+ (NSInteger)gridNumberToHighlight:(NSInteger)gridCellCount;

@end

@implementation TLGridQuestionGenerator

static NSInteger prevGridHighlighted = -1;

+ (TLGridQuestion *)generate:(Point)gridSize {
    NSInteger gridCellCount = gridSize.h * gridSize.h;
    NSInteger gridNumToHighlight = [self gridNumberToHighlight:gridCellCount];
    
    if (prevGridHighlighted == -1) {
        prevGridHighlighted = gridNumToHighlight;
    } else {
        while(prevGridHighlighted == gridNumToHighlight) {
            gridNumToHighlight = [self gridNumberToHighlight:gridCellCount];
        }
        
        // grid number different from previous one should be generated when program control reaches here
        prevGridHighlighted = gridNumToHighlight;
    }
    return [[TLGridQuestion alloc] initWithGridSize:gridSize gridNumToHighlight:gridNumToHighlight];
}

+ (NSInteger)gridNumberToHighlight:(NSInteger)gridCellCount {
    return arc4random() % (gridCellCount);
}

@end
