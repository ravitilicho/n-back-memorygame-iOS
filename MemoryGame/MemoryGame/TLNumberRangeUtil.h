//
//  TLNumberRangeUtil.h
//  MemoryGame
//
//  Created by Ravindar Katkuri on 17/11/15.
//  Copyright © 2015 Tilicho Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enums.h"

@interface TLNumberRangeUtil : NSObject

+ (BOOL) isMaxInRange:(NSInteger)item range:(NumberRange)numberRange;
+ (BOOL) isMinInRange:(NSInteger)item range:(NumberRange)numberRange;;
+ (NSInteger) nextItem:(NSInteger)item range:(NumberRange)numberRange;;
+ (NSInteger) minItem:(NumberRange)numberRange;;
+ (NSInteger) maxItem:(NumberRange)numberRange;;

@end
