//
//  TLColorQuestionGenerator.h
//  MemoryGame
//
//  Created by Ravindar Katkuri on 16/10/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLGridQuestion.h"

@interface TLGridQuestionGenerator : NSObject

+ (TLGridQuestion *)generate:(Point)gridSize;

@end
