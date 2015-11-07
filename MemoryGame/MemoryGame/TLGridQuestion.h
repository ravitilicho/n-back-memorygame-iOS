//
//  TLGridQuestion.h
//  MemoryGame
//
//  Created by Ravindar Katkuri on 04/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLGridQuestion : NSObject

@property(nonatomic) NSInteger gridNumToHighlight;
@property(nonatomic) Point gridSize;

- (instancetype) initWithGridSize:(Point)gridSize gridNumToHighlight:(NSInteger)gridNumToHighlight;
- (NSInteger) answer;

@end
