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
    SKIP,
    TIMER_EXPIRED
} TLEventType;

typedef NS_ENUM(NSUInteger, TLEventOutcome) {
    ARITHMETIC_CORRECT = 0,
    ARITHMETIC_INCORRECT = 1,
    COLOR_GRID_CORRECT = 2,
    COLOR_GRID_INCORRECT = 3,
    SKIPPED = 4,
    UNDEFINED = 10
};

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

#endif /* Enums_h */
