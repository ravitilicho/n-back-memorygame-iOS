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

typedef enum
{
    ARITHMETIC_CORRECT,
    ARITHMETIC_INCORRECT,
    COLOR_GRID_CORRECT,
    COLOR_GRID_INCORRECT
} TLEventOutcome;


#endif /* Enums_h */
