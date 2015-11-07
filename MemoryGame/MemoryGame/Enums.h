//
//  Enums.h
//  MemoryGame
//
//  Created by Ravindar Katkuri on 03/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#ifndef Enums_h
#define Enums_h

typedef enum
{
    ARITHMETIC,
    COLOR_GRID,
    TIMER_EXPIRED
} TLEventType;

typedef NS_ENUM(NSUInteger, TLEventOutcome) {
    ARITHMETIC_CORRECT = 0,
    ARITHMETIC_INCORRECT = 1,
    COLOR_GRID_CORRECT = 2,
    COLOR_GRID_INCORRECT = 3,
    UNDEFINED = 10
};

#endif /* Enums_h */
